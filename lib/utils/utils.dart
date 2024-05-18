import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

String generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}

Future<Uint8List?> generatedThumbnailVideo({
  required String dirPath,
  required String fileName,
  required Uint8List byteData,
}) async {
  try {
    final tempVideo = File("$dirPath/$fileName")
      ..create(recursive: true)
      ..writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );

    Logger().d('debug: tempVideo = $tempVideo');

    return await VideoThumbnail.thumbnailData(
      video: tempVideo.path,
      imageFormat: ImageFormat.WEBP,
      quality: 50,
    );
  } catch (e) {
    Logger().e('Error: generatedThumbnailVideo = $e');
  }

  return null;
}
