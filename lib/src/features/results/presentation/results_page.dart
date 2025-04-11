import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_upload_test/src/features/results/presentation/image_preview_dialog.dart';
import 'package:image_upload_test/src/features/results/view_model/results_page_view_model.dart';
import 'package:image_upload_test/src/utils/permission_utils.dart';
import 'package:image_upload_test/src/utils/persist_data_utils.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final _viewModel = ResultsPageViewModel();
  String _selectedFolderPath = PersistDataUtils.getString("folderPath") ?? "";
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setImagePaths(_selectedFolderPath);
      requestFullStoragePermission();
    });
  }

  void setImagePaths(String folderPath) async {
    if (folderPath != "") {
      final paths = await _viewModel.getAllImagePaths(_selectedFolderPath);
      setState(() {
        _imagePaths = paths;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        actions: [
          IconButton(
            onPressed: () => setImagePaths(_selectedFolderPath),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 20,
          children: [
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: Text(
                    _selectedFolderPath == ""
                        ? "No Folder Path Selected"
                        : _selectedFolderPath,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    String? path = await _viewModel.selectFolderPath(
                      context,
                      _selectedFolderPath,
                    );

                    if (path != null) {
                      PersistDataUtils.setString("folderPath", path);
                      setState(() {
                        _selectedFolderPath = path;
                      });
                      setImagePaths(path);
                    }
                  },
                  label: Text("Select Folder Path"),
                  icon: Icon(Icons.folder),
                ),
              ],
            ),

            (_imagePaths.isEmpty && _selectedFolderPath != "")
                ? Text("No image in selected path")
                : Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.sizeOf(context).width ~/ 150,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap:
                            () => showDialog(
                              context: context,
                              builder:
                                  (context) => Dialog.fullscreen(
                                    child: ImagePreviewDialog(
                                      imagePaths: _imagePaths,
                                      initialIndex: index,
                                    ),
                                  ),
                            ),
                        child: Image.file(File(_imagePaths[index])),
                      );
                    },
                    itemCount: _imagePaths.length,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
