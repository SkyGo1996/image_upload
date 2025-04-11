import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_upload_test/src/utils/image_utils.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ResultsPageViewModel {
  Future<String?> selectFolderPath(
    BuildContext context, [
    String? currentDirectory,
  ]) async {
    try {
      if (context.mounted) {
        final rootDirectory =
            Platform.operatingSystem == "android"
                ? Directory("/storage/emulated/0")
                : await getDownloadsDirectory();

        if (Platform.isIOS) {
          return rootDirectory?.path;
        }

        return FilesystemPicker.open(
          context: context,
          rootDirectory: rootDirectory,
          directory:
              (currentDirectory != "" && currentDirectory != null)
                  ? Directory(currentDirectory)
                  : null,
        );
      }

      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<String>> getAllImagePaths(String folderPath) async {
    try {
      final directory = Directory(folderPath);
      List<String> imagePaths = [];

      final exists = await directory.exists();

      if (exists) {
        final stream = directory.list();

        await for (FileSystemEntity entity in stream) {
          if (entity is File) {
            final extension = path.extension(entity.path).toLowerCase();
            if (isImageExtension(extension)) {
              imagePaths.add(entity.path);
            }
          }
        }
      } else {
        print("directory not found");
      }

      return imagePaths;
    } catch (e) {
      throw Exception(e);
    }
  }
}
