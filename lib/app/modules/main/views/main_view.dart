import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_manager/file_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_vault/utils/constants_values.dart';
import 'package:file_vault/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:thumbnailer/thumbnailer.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstantsValues.appName),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.note_add_rounded),
            itemBuilder: (BuildContext context) => [
              builderPopupMenuItem(
                value: 1,
                icon: Icons.insert_drive_file_rounded,
                text: 'Add File',
              ),
              builderPopupMenuItem(
                value: 2,
                icon: Icons.image_rounded,
                text: 'Add Photo',
              ),
              builderPopupMenuItem(
                value: 3,
                icon: Icons.movie_rounded,
                text: 'Add Video',
              ),
            ],
            onSelected: (value) {
              FileType type;

              switch (value) {
                case 1:
                  type = FileType.any;
                  break;
                case 2:
                  type = FileType.image;
                case 3:
                  type = FileType.video;
                default:
                  type = FileType.any;
                  break;
              }

              controller.addFile(type);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {
              // email optional
            },
          ),
        ],
      ),
      body: FileManager(
        controller: controller.fileManagerC,
        emptyFolder: builderEmptyFolder(theme),
        errorBuilder: (context, error) => builderErrorFolder(theme, error),
        builder: (context, snapshot) {
          final entities = snapshot;

          // return FutureBuilder(
          //   future: controller.decryptEntities(entities),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (snapshot.hasData && snapshot.data != null) {
          //       final bytes = snapshot.data!;

          //       return GridView.builder(
          //           gridDelegate:
          //               const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 3,
          //           ),
          //           itemCount: entities.length,
          //           itemBuilder: (context, index) {
          //             return InkWell(
          //               onTap: () {},
          //               child: Container(
          //                 padding: const EdgeInsets.symmetric(horizontal: 4),
          //                 child: Column(
          //                   children: [
          //                     Expanded(
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Image.memory(
          //                           bytes,
          //                           width: double.infinity,
          //                           height: double.infinity,
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             );

          //             // return InkWell(
          //             //   onTap: () {
          //             //     // if (FileManager.isDirectory(entity)) {
          //             //     //   controller.fileManagerC.openDirectory(entity.);
          //             //     // } else {
          //             //     //   controller.tapFile(entity.);
          //             //     // }
          //             //   },
          //             //   child: Container(
          //             //     padding: const EdgeInsets.symmetric(horizontal: 4),
          //             //     child: Column(
          //             //       children: [
          //             //         Expanded(
          //             //           child: FutureBuilder(
          //             //             future: controller.readFileEncrypt(
          //             //               initC: controller.initC,
          //             //               aesCrypt: controller.aesCrypt,
          //             //               item: item,
          //             //             ),
          //             //             builder: (context, snapshot) {
          //             //               if (snapshot.connectionState ==
          //             //                   ConnectionState.waiting) {
          //             //                 return const Center(
          //             //                   child: CircularProgressIndicator(),
          //             //                 );
          //             //               } else if (snapshot.hasData &&
          //             //                   snapshot.data != null) {
          //             //                 final bytesFile = snapshot.data;
          //             //                 final fileName =
          //             //                     FileManager.basename(item)
          //             //                         .replaceAll('.aes', '');
          //             //                 final isImageFile =
          //             //                     fileName.isImageFileName;
          //             //                 final isVideoFile =
          //             //                     fileName.isVideoFileName;

          //             //                 if (isImageFile) {
          //             //                   return Padding(
          //             //                     padding: const EdgeInsets.all(8.0),
          //             //                     child: Image.memory(
          //             //                       bytesFile!,
          //             //                       width: double.infinity,
          //             //                       height: double.infinity,
          //             //                       fit: BoxFit.cover,
          //             //                     ),
          //             //                   );
          //             //                 }

          //             //                 if (isVideoFile) {
          //             //                   return FutureBuilder(
          //             //                     future: generatedThumbnailVideo(
          //             //                       dirPath: '${controller.dir}/.temp',
          //             //                       fileName: fileName,
          //             //                       byteData: bytesFile!,
          //             //                     ),
          //             //                     builder: (context, snapshot) {
          //             //                       if (snapshot.hasData &&
          //             //                           snapshot.data != null) {
          //             //                         final data = snapshot.data;

          //             //                         return Padding(
          //             //                           padding:
          //             //                               const EdgeInsets.all(8.0),
          //             //                           child: Image.memory(
          //             //                             data!,
          //             //                             width: double.infinity,
          //             //                             height: double.infinity,
          //             //                             fit: BoxFit.cover,
          //             //                           ),
          //             //                         );
          //             //                       }

          //             //                       return builderIcon(
          //             //                         theme: theme,
          //             //                         item: item,
          //             //                       );
          //             //                     },
          //             //                   );
          //             //                 }

          //             //                 return builderIcon(
          //             //                   theme: theme,
          //             //                   item: item,
          //             //                 );
          //             //               } else {
          //             //                 return builderIcon(
          //             //                   theme: theme,
          //             //                   item: item,
          //             //                 );
          //             //               }
          //             //             },
          //             //           ),
          //             //         ),
          //             //         const Gap(2),
          //             //         AutoSizeText(
          //             //           FileManager.basename(item),
          //             //           style: theme.textTheme.labelLarge,
          //             //           minFontSize:
          //             //               theme.textTheme.labelSmall?.fontSize ?? 12,
          //             //           textAlign: TextAlign.center,
          //             //           maxLines: 2,
          //             //           overflow: TextOverflow.fade,
          //             //         ),
          //             //       ],
          //             //     ),
          //             //   ),
          //             // );
          //           }
          //           // },
          //           );
          //     }

          //     return Container();
          //   },
          // );

          if (entities.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = entities[index];

                return InkWell(
                  onTap: () {
                    if (FileManager.isDirectory(item)) {
                      controller.fileManagerC.openDirectory(item);
                    } else {
                      controller.tapFile(item);
                    }
                  },
                  // onLongPress: () async => await item.delete(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        Expanded(
                          child: FutureBuilder(
                            key: Key(item.path),
                            future: controller.readFileEncrypt(item),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data != null) {
                                final bytesFile = snapshot.data;
                                final fileName = FileManager.basename(item)
                                    .replaceAll('.aes', '');
                                final isImageFile = fileName.isImageFileName;
                                final isVideoFile = fileName.isVideoFileName;
                                final isPdfFile = fileName.isPDFFileName;
                                final isExcelFile = fileName.isExcelFileName;

                                if (isImageFile) {
                                  return Thumbnail(
                                    mimeType: 'image/*',
                                    widgetSize: 150,
                                    dataResolver: () => Future.value(bytesFile),
                                  );
                                }

                                if (isVideoFile) {
                                  return FutureBuilder(
                                    future: generatedThumbnailVideo(item),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        final data = snapshot.data;

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.memory(
                                            data!,
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }

                                      return builderIcon(
                                        theme: theme,
                                        item: item,
                                      );
                                    },
                                  );
                                }

                                if (isPdfFile) {
                                  return Thumbnail(
                                    mimeType: 'application/pdf',
                                    widgetSize: 150,
                                    dataResolver: () => Future.value(bytesFile),
                                  );
                                }

                                if (isExcelFile) {
                                  debugPrint(
                                      'debug: isExcelFile = $isExcelFile');

                                  return Thumbnail(
                                    mimeType:
                                        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                    widgetSize: 120,
                                    dataResolver: () => Future.value(bytesFile),
                                    decoration: WidgetDecoration(
                                      wrapperBgColor: Colors.blueAccent,
                                    ),
                                  );
                                }

                                return builderIcon(
                                  theme: theme,
                                  item: item,
                                );
                              } else {
                                return builderIcon(
                                  theme: theme,
                                  item: item,
                                );
                              }
                            },
                          ),
                        ),
                        const Gap(2),
                        AutoSizeText(
                          FileManager.basename(item),
                          style: theme.textTheme.labelLarge,
                          minFontSize:
                              theme.textTheme.labelSmall?.fontSize ?? 12,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: entities.length,
            );
          }

          return builderEmptyFolder(theme);
        },
      ),
      // floatingActionButton: Obx(
      //   () {
      //     final file = File(controller.filePath.value);
      //     final isTapFile = controller.isTapFile.value;
      //     final isLoadingEncrypted = controller.isLoading.value;
      //     final extension = FileManager.getFileExtension(file);

      //     if (isTapFile) {
      //       return FloatingActionButton.extended(
      //         onPressed: () {
      //           if (extension != 'aes') {
      //             controller.encryptFile();
      //           } else {
      //             controller.decryptFile(file);
      //           }
      //         },
      //         label: Text(
      //           isLoadingEncrypted
      //               ? 'Loading'
      //               : extension != 'aes'
      //                   ? 'Encrypt File'
      //                   : 'Decrypt File',
      //         ),
      //         icon: isLoadingEncrypted
      //             ? const CircularProgressIndicator()
      //             : Icon(
      //                 extension != 'aes'
      //                     ? Icons.lock_rounded
      //                     : Icons.lock_open_rounded,
      //               ),
      //       );
      //     }
      //     return Container();
      //   },
      // ),
    );
  }

  PopupMenuItem<int> builderPopupMenuItem({
    required int value,
    required IconData icon,
    required String text,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const Gap(4),
          Text(text),
        ],
      ),
    );
  }

  Center builderErrorFolder(
    ThemeData theme,
    Object? error,
  ) {
    Logger().e('error: mainView ', error: error);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_off_outlined,
              color: theme.colorScheme.primary,
              size: 48,
            ),
            const Gap(6),
            AutoSizeText(
              'The contents of this folder cannot be displayed here, due to Android restrictions.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Center builderEmptyFolder(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_outlined,
            color: theme.colorScheme.primary,
            size: 48,
          ),
          const Gap(6),
          AutoSizeText(
            'Empty Directory',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget builderIcon({
    required ThemeData theme,
    required FileSystemEntity item,
  }) {
    final colorScheme = theme.colorScheme;
    const size = 82.0;

    if (FileManager.isDirectory(item)) {
      return Icon(
        Icons.folder,
        size: size,
        color: colorScheme.primary,
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.insert_drive_file_rounded,
            size: size,
            color: colorScheme.primary,
          ),
          AutoSizeText(
            FileManager.getFileExtension(item),
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      );
    }
  }
}
