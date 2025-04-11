import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scrape_images_repository.g.dart';

class ScrapeImagesRepository {
  const ScrapeImagesRepository();

  Future<Uint8List> downloadFiles(String fullUrl) async {
    final response = await http.get(Uri.parse(fullUrl));
    return response.bodyBytes;
  }
}

@riverpod
ScrapeImagesRepository scrapeImagesRepository(Ref ref) {
  return ScrapeImagesRepository();
}

@riverpod
Future<Uint8List> getDownloadFiles(Ref ref, String fullUrl) async {
  final scrapeImagesRepository = ref.watch(scrapeImagesRepositoryProvider);

  return scrapeImagesRepository.downloadFiles(fullUrl);
}
