bool isImageExtension(String path) {
  final imageExtension = ["jpeg", "jpg", "png", "webp"];

  return imageExtension.any((ext) => path.toLowerCase().contains(ext));
}
