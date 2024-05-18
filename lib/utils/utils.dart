import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:logger/logger.dart';

String generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}

Future<Uint8List?> generatedThumbnailVideo(FileSystemEntity item) async {
  Logger().d('debug: generatedThumbnailVideo path item = ${item.path}');

  try {
    final result = await VideoThumbnail.thumbnailData(
      video: item.path,
      maxWidth: 128,
      quality: 50,
    );
    return result;
  } catch (e) {
    Logger().e('Error: generatedThumbnailVideo = $e');
  }

  return null;
}
