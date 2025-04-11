// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrape_images_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scrapeImagesRepositoryHash() =>
    r'5e769d555bc089b5e54c8e5f5d6eda82934aa2f3';

/// See also [scrapeImagesRepository].
@ProviderFor(scrapeImagesRepository)
final scrapeImagesRepositoryProvider =
    AutoDisposeProvider<ScrapeImagesRepository>.internal(
      scrapeImagesRepository,
      name: r'scrapeImagesRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$scrapeImagesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ScrapeImagesRepositoryRef =
    AutoDisposeProviderRef<ScrapeImagesRepository>;
String _$getDownloadFilesHash() => r'33b28d564b6d0fa5cd5602506a54af021b532bb5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getDownloadFiles].
@ProviderFor(getDownloadFiles)
const getDownloadFilesProvider = GetDownloadFilesFamily();

/// See also [getDownloadFiles].
class GetDownloadFilesFamily extends Family<AsyncValue<Uint8List>> {
  /// See also [getDownloadFiles].
  const GetDownloadFilesFamily();

  /// See also [getDownloadFiles].
  GetDownloadFilesProvider call(String fullUrl) {
    return GetDownloadFilesProvider(fullUrl);
  }

  @override
  GetDownloadFilesProvider getProviderOverride(
    covariant GetDownloadFilesProvider provider,
  ) {
    return call(provider.fullUrl);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getDownloadFilesProvider';
}

/// See also [getDownloadFiles].
class GetDownloadFilesProvider extends AutoDisposeFutureProvider<Uint8List> {
  /// See also [getDownloadFiles].
  GetDownloadFilesProvider(String fullUrl)
    : this._internal(
        (ref) => getDownloadFiles(ref as GetDownloadFilesRef, fullUrl),
        from: getDownloadFilesProvider,
        name: r'getDownloadFilesProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$getDownloadFilesHash,
        dependencies: GetDownloadFilesFamily._dependencies,
        allTransitiveDependencies:
            GetDownloadFilesFamily._allTransitiveDependencies,
        fullUrl: fullUrl,
      );

  GetDownloadFilesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fullUrl,
  }) : super.internal();

  final String fullUrl;

  @override
  Override overrideWith(
    FutureOr<Uint8List> Function(GetDownloadFilesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDownloadFilesProvider._internal(
        (ref) => create(ref as GetDownloadFilesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fullUrl: fullUrl,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Uint8List> createElement() {
    return _GetDownloadFilesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDownloadFilesProvider && other.fullUrl == fullUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fullUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetDownloadFilesRef on AutoDisposeFutureProviderRef<Uint8List> {
  /// The parameter `fullUrl` of this provider.
  String get fullUrl;
}

class _GetDownloadFilesProviderElement
    extends AutoDisposeFutureProviderElement<Uint8List>
    with GetDownloadFilesRef {
  _GetDownloadFilesProviderElement(super.provider);

  @override
  String get fullUrl => (origin as GetDownloadFilesProvider).fullUrl;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
