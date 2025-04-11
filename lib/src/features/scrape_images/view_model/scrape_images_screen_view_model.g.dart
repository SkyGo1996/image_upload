// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrape_images_screen_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scrapeImagesHash() => r'afd4ddf88e5de44a8cd5d0c2b423ced718d17a93';

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
String _$downloadImagesHash() => r'11e45922a56ec1b1d3a39e095cc3d2f10d337142';

/// See also [DownloadImages].
@ProviderFor(DownloadImages)
final downloadImagesProvider =
    AutoDisposeAsyncNotifierProvider<DownloadImages, void>.internal(
      DownloadImages.new,
      name: r'downloadImagesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$downloadImagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DownloadImages = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
