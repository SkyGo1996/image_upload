import 'package:image_picker/image_picker.dart';

class UploadImagesScreenViewModel {
  void pickImages() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
  }

  void uploadImages(List<XFile> images) async {
    // TODO upload images
  }
}
