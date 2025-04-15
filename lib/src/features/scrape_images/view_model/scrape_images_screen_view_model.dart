import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:html/dom.dart';
import "package:html/parser.dart" as parser;
import 'package:http/http.dart' as http;
import 'package:image_upload_test/src/features/scrape_images/data/scrape_images_repository.dart';
import 'package:image_upload_test/src/utils/image_utils.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "scrape_images_screen_view_model.g.dart";

@riverpod
class ScrapeImages extends _$ScrapeImages {
  @override
  AsyncValue<List<String>> build() {
    return const AsyncData(<String>[]);
  }

  Future<void> scrapeImages(String url) async {
    state = const AsyncLoading();
    List<String> imgUrls = [];

    // try {
    //   for (int i = 1; i < 300; i++) {
    //     final response = await http.get(Uri.parse("$url#$i"));

    //     if (response.statusCode != 200) {
    //       // state = AsyncError("error", StackTrace.current);
    //       throw (Exception("end"));
    //     }

    //     Document document = parser.parse(response.body);
    //     List<Element> imgTags = document.getElementsByTagName("img");

    //     imgUrls.addAll(
    //       imgTags
    //           .map((img) => img.attributes["src"] ?? "")
    //           .where((src) => src.isNotEmpty && isImageExtension(src)),
    //     );
    //   }
    // } catch (e) {
    //   state = AsyncData(imgUrls);
    //   // state = AsyncError(e, StackTrace.current);
    // }
  }
}

@riverpod
class DownloadImages extends _$DownloadImages {
  @override
  FutureOr<void> build() {}

  Future<void> downloadImages(
    List<String> imageUrls,
    bool createSubFolder,
  ) async {
    state = const AsyncLoading();
    try {
      final futureList =
          imageUrls.map((url) => getDownloadFilesProvider(url).future).toList();
      final bytesList = await Future.wait(
        futureList.map((future) => ref.read(future)),
      );

      for (final (index, bytes) in bytesList.indexed) {
        final androidDownloadDirectory = Directory(
          "/storage/emulated/0/Download/random",
        );
        final directory =
            Platform.isAndroid
                ? Directory(
                  path.join(
                    androidDownloadDirectory.path,
                    createSubFolder ? DateTime.now().toString() : "",
                  ),
                )
                : await getDownloadsDirectory();
        String fileName = "default.png";

        if (isImageExtension(imageUrls[index])) {
          final RegExp regexFileWithExt = RegExp(
            r'\/([^\/]+\.(jpg|jpeg|png|gif|bmp|webp|svg|heic))(?:[\?\#].*)?$',
            caseSensitive: false,
          );
          final matchWithExt = regexFileWithExt.firstMatch(imageUrls[index]);
          if (matchWithExt != null && matchWithExt.group(1) != null) {
            fileName = matchWithExt.group(1)!;
          }
        }
        if (directory != null) {
          if (!createSubFolder) {
            final file = File(join(directory.path, fileName));
            await file.writeAsBytes(bytes);
          } else {
            // await directory.create(recursive: true);
            // final file = File(join(directory.path, fileName));
            // await file.writeAsBytes(bytes);

            await FilePicker.platform.saveFile(
              dialogTitle: 'Save Image',
              fileName: fileName,
              type: FileType.image,
              // You can specify allowed extensions if needed
              // allowedExtensions: ['jpg', 'jpeg', 'png'],
              bytes: bytes,
            );
          }
        }
      }
      state = AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(Exception(e), StackTrace.current);
    }
  }
}
