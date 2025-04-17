// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrape_images_screen_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scrapeImagesHash() => r'd93031ade690dd31706870bfc8e37d95de0fd908';

/// See also [ScrapeImages].
@ProviderFor(ScrapeImages)
final scrapeImagesProvider = AutoDisposeNotifierProvider<
  ScrapeImages,
  AsyncValue<List<String>>
>.internal(
  ScrapeImages.new,
  name: r'scrapeImagesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$scrapeImagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScrapeImages = AutoDisposeNotifier<AsyncValue<List<String>>>;
String _$downloadImagesHash() => r'a1899ef896b82cb7fafa6db7b549428ad6a4a25b';

/// See also [DownloadImages].
@ProviderFor(DownloadImages)
final downloadImagesProvider =
    AutoDisposeAsyncNotifierProvider<DownloadImages, Object?>.internal(
      DownloadImages.new,
      name: r'downloadImagesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$downloadImagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DownloadImages = AutoDisposeAsyncNotifier<Object?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
