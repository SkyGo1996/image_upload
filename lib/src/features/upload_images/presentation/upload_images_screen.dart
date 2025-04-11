import 'package:flutter/material.dart';
import 'package:image_upload_test/src/features/upload_images/view_model/upload_images_screen_view_model.dart';
import 'package:image_upload_test/src/utils/permission_utils.dart';
import 'package:image_upload_test/src/utils/persist_data_utils.dart';

class UploadImagesScreen extends StatefulWidget {
  const UploadImagesScreen({super.key});

  @override
  State<UploadImagesScreen> createState() => _UploadImagesScreenState();
}

class _UploadImagesScreenState extends State<UploadImagesScreen> {
  final _viewModel = UploadImagesScreenViewModel();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = PersistDataUtils.getString("baseUrl") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Images")),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: "Base URL"),
                onChanged:
                    (value) => PersistDataUtils.setString("baseUrl", value),
                onTapOutside:
                    (event) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _viewModel.pickImages,
              label: Text("Add Images"),
              icon: Icon(Icons.upload),
            ),
          ],
        ),
      ),
    );
  }
}
