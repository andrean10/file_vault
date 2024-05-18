import 'dart:async';
import 'dart:io';
import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_manager/file_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_vault/app/modules/init/controllers/init_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';

class MainController extends GetxController {
  late final InitController initC;
  late final FileManagerController fileManagerC;
  late final AesCrypt aesCrypt;

  final isEncryptedFile = false.obs;

  final isTapFile = false.obs;
  final filePath = ''.obs;
  final isLoading = false.obs;

  final dir = Directory('/storage/emulated/0/.file_vault');

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
    setInitialDirectory();
  }

  Future<void> _init() async {
    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }

    fileManagerC = FileManagerController();
    _requestPermissions();

    aesCrypt = AesCrypt('file_vault');
    aesCrypt.setOverwriteMode(AesCryptOwMode.warn);
  }

  void setInitialDirectory() {
    if (!dir.existsSync()) {
      dir.createSync();
    }
    fileManagerC.openDirectory(dir);
  }

  Future<void> _requestPermissions() async {
    try {
      final state = await Permission.manageExternalStorage.request();

      switch (state) {
        case PermissionStatus.granted:
          logger.i('info: requestPermissions manageExternalStorage di izinkan');
          break;
        case PermissionStatus.permanentlyDenied:
          _showSnackBar();
          break;
        default:
          break;
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  void addFile(FileType type) async {
    try {
      final results = await FilePicker.platform.pickFiles(
        type: type,
        compressionQuality: 100,
        allowCompression: false,
        allowMultiple: true,
        withData: true,
      );

      if (results != null) {
        final filePicker = results.files;

        for (var file in filePicker) {
          if (file.path != null) {
            final path = await aesCrypt.encryptDataToFile(
              file.bytes!,
              '${dir.path}/${file.name}.aes',
            );
            logger.d('debug: path = $path');
          }
        }

        Get.offAllNamed(Routes.MAIN);
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  void tapFile(FileSystemEntity item) {
    isTapFile.value = !isTapFile.value;
    filePath.value = item.path;
    logger.d('debug: tapFile filePath = $filePath');
  }

  Future<void> encryptFile() async {
    isLoading.value = true;

    final randomName = generateRandomString(16);
    final newFolderToFile = '${dir.path}/$randomName';

    logger.d('debug: newFolderToFile = $newFolderToFile');

    // buat dulu folder untuk file enkripsi
    final dirInvisibleFile = Directory(newFolderToFile);
    if (!dirInvisibleFile.existsSync()) {
      dirInvisibleFile.createSync();
      logger.i('info: create dirInvisibleFile');
    }

    logger.d('debug: path encrypted file = $newFolderToFile/$randomName.aes');

    try {
      // final nameFile =
      await aesCrypt.encryptFile(
        filePath.value,
        '$newFolderToFile/$randomName.aes',
      );

      final text = filePath.value;
      // final nameKey =
      await aesCrypt.encryptTextToFile(text, '$newFolderToFile/key.txt.aes');

      // hapus file yang dienkripsi sebelumnya
      final oldFile = File(filePath.value);
      await oldFile.delete(recursive: true);
      isLoading.value = false;
    } catch (e) {
      logger.e('error: $e');
    }
  }

  Future<Uint8List> processEncryt(Map<String, dynamic> args) {
    final initC = args['initC'] as InitController;
    final item = args['item'] as FileSystemEntity;
    final aesCrypt = args['aesCrypt'] as AesCrypt;

    final map = initC.memoizerMap;

    final nameFile = FileManager.basename(item);

    if (!map.containsKey(nameFile)) {
      map[nameFile] = AsyncMemoizer<Uint8List>();
    }

    Logger().d('debug: map = $map');

    return map[nameFile]!.runOnce(() async {
      return await aesCrypt.decryptDataFromFile(item.path);
    });
  }

  Future<Uint8List>? readFileEncrypt({
    required InitController initC,
    required AesCrypt aesCrypt,
    required FileSystemEntity item,
  }) async {
    final map = <String, dynamic>{
      'initC': initC,
      'aesCrypt': aesCrypt,
      'item': item
    };
    return compute(processEncryt, map, debugLabel: 'compute dijalankan');
  }

  Future<Uint8List?> decryptFile(FileSystemEntity item) async {
    isLoading.value = true;

    try {
      final decryptedFile = await aesCrypt.decryptDataFromFile(item.path);
      logger.d('debug: decryptedFile = $decryptedFile');

      return decryptedFile;

      // // decrypt dulu key nya
      // final pathKey =
      //     aesCrypt.decryptTextFromFileSync('${item.path}/key.txt.aes');
      // logger.d('debug: pathKey = $pathKey');

      // final test = item.path;
      // logger.d('debug: test = $test');

      // logger.d(
      //     'debug: path decrypt file = ${item.path}/${FileManager.basename(item.path)}.aes');

      // decrypt file-nya
      // await crypt.decryptFile(
      //     '${item.path}/${FileManager.basename(item.path)}.aes', pathKey);
      // logger.d('debug: Decrypt done');
    } catch (e) {
      logger.e('Error: decryptFile = $e');
    } finally {
      isLoading.value = false;
    }

    return null;
  }

  void _showSnackBar() {
    final textTheme = Get.textTheme;

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              'Requires storage permission',
              style: textTheme.titleSmall,
            ),
            const Gap(2),
            AutoSizeText(
              'Storage access permission is required for the app to function normally',
              style: textTheme.bodySmall,
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'Izinkan',
          onPressed: () async {
            await openAppSettings();
          },
        ),
        duration: Durations.long1,
      ),
    );
  }

  @override
  void onClose() {
    fileManagerC.dispose();
    super.onClose();
  }

  void decryptEntities(List<FileSystemEntity> entities) async {
    final map = initC.memoizerMap;
  
    for (var entity in entities) {
      final nameFile = FileManager.basename(entity);

      if (!map.containsKey(nameFile)) {
        map[nameFile] = AsyncMemoizer<Uint8List>();
      }

      // Jalankan dekripsi dan simpan hasilnya ke memoizer
      final test = await map[nameFile]!.runOnce(() async {
        return await aesCrypt.decryptDataFromFile(entity.path);
      });
    }}

  List<Uint8List> _decryptEntitiesInIsolate(List<FileSystemEntity> entities) {
    final map = <String, AsyncMemoizer<Uint8List>>{};

    // List untuk menyimpan hasil dekripsi
    final decryptedResults = <Uint8List>[];

    // Lakukan iterasi pada setiap entitas
    for (var entity in entities) {
      final nameFile = FileManager.basename(entity);

      if (!map.containsKey(nameFile)) {
        map[nameFile] = AsyncMemoizer<Uint8List>();
      }

      // Jalankan dekripsi dan simpan hasilnya ke memoizer
      map[nameFile]!.runOnce(() async {
        final decryptedData = await aesCrypt.decryptDataFromFile(entity.path);
        decryptedResults
            .add(decryptedData); // Tambahkan hasil dekripsi ke dalam daftar
        return decryptedData; // Kembalikan hasil dekripsi
      });
    }

    return decryptedResults;
  }

  Stream<Uint8List> decryptEntitiesStream(
      List<FileSystemEntity> entities) async* {
    final map = initC.memoizerMap;

    for (var entity in entities) {
      final nameFile = FileManager.basename(entity);

      if (!map.containsKey(nameFile)) {
        map[nameFile] = AsyncMemoizer<Uint8List>();
      }

      final completer = Completer<Uint8List>();

      map[nameFile]!.runOnce(() async {
        final result = await aesCrypt.decryptDataFromFile(entity.path);
        completer.complete(result);
        return result;
      });

      // Emit hasil dekripsi
      yield await completer.future;
    }
  }
}
