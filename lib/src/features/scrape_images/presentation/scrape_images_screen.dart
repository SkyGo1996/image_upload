import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_upload_test/src/features/scrape_images/view_model/scrape_images_screen_view_model.dart';
import 'package:image_upload_test/src/utils/image_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScrapeImagesScreen extends ConsumerStatefulWidget {
  const ScrapeImagesScreen({super.key});

  @override
  ConsumerState<ScrapeImagesScreen> createState() => _ScrapeImagesScreenState();
}

class _ScrapeImagesScreenState extends ConsumerState<ScrapeImagesScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  List<String> selectedImageUrlsToDownload = [];
  late final WebViewController _controller;
  bool _isLoading = false;
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(onPageFinished: (_) => _scrapeImages()),
          )
          ..addJavaScriptChannel(
            "ImageScraper",
            onMessageReceived: (message) {
              final urls = List<String>.from(json.decode(message.message));
              // print(urls);
              setState(() {
                // _imageUrls.addAll(
                //   urls.toSet().where((url) => isImageExtension(url)),
                // );
                _imageUrls =
                    {
                      ..._imageUrls,
                      ...urls,
                    }.where((url) => isImageExtension(url)).toList();
              });
            },
          );
  }

  Future<void> _scrapeImages() async {
    await _controller.runJavaScript('''
      var images = document.getElementsByTagName('img');
      var baseUrl = window.location.href;
      var urls = Array.from(images).map(function(img) {
        return new URL(img.src, baseUrl).href;
      });
      ImageScraper.postMessage(JSON.stringify(urls));
    ''');
  }

  @override
  Widget build(BuildContext context) {
    const downloadSuccessfulSnackBar = SnackBar(
      content: Text("Download Successful"),
    );
    final scrapeImages = ref.watch(scrapeImagesProvider);
    final downloadImages = ref.watch(downloadImagesProvider);
    ref.listen(downloadImagesProvider, (previous, next) {
      if (previous != null && previous.isLoading && next is AsyncData) {
        ScaffoldMessenger.of(context).showSnackBar(downloadSuccessfulSnackBar);
      } else if (next is AsyncError) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog.adaptive(
                title: Text("Error"),
                content: Text(next.error.toString()),
              ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Scrape Images"),
        actions: [
          if (selectedImageUrlsToDownload.isNotEmpty)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog.adaptive(
                        title: Text("Create Subfolder?"),
                        content: Text(
                          "Do you want to create subfolder to store the images?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(downloadImagesProvider.notifier)
                                  .downloadImages(
                                    selectedImageUrlsToDownload,
                                    true,
                                  );
                              context.pop();
                            },
                            child: Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(downloadImagesProvider.notifier)
                                  .downloadImages(
                                    selectedImageUrlsToDownload,
                                    false,
                                  );
                              context.pop();
                            },
                            child: Text("No"),
                          ),
                        ],
                      ),
                );
              },
              icon:
                  downloadImages is AsyncLoading
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                      : Icon(Icons.download),
            ),

          if (_imageUrls.isNotEmpty)
            TextButton(
              onPressed: () {
                if (_imageUrls.length == selectedImageUrlsToDownload.length) {
                  setState(() {
                    selectedImageUrlsToDownload = [];
                  });
                } else {
                  setState(() {
                    selectedImageUrlsToDownload = List.from(_imageUrls);
                  });
                }
              },
              child: Text(
                _imageUrls.length == selectedImageUrlsToDownload.length
                    ? "Deselect All"
                    : "Select All",
              ),
            ),

          if (_imageUrls.isNotEmpty)
            TextButton(
              child: Text("Clear"),
              onPressed: () {
                setState(() {
                  _imageUrls = [];
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(hintText: "Web page to scrape"),
                    onTapOutside:
                        (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_textEditingController.text != "") {
                      // ref
                      //     .read(scrapeImagesProvider.notifier)
                      //     .scrapeImages(_textEditingController.text);
                      setState(() {
                        _isLoading = true;
                      });

                      // TODO create for loop and load request

                      _controller.loadRequest(
                        Uri.parse(_textEditingController.text),
                      );

                      setState(() {
                        selectedImageUrlsToDownload = [];
                        _isLoading = false;
                      });
                    }
                  },
                  label: Text("Go"),
                  icon: Icon(Icons.forward),
                ),
              ],
            ),
            // scrapeImages.when(
            //   data:
            //       (data) => Expanded(
            //         child: GridView.builder(
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: MediaQuery.sizeOf(context).width ~/ 150,
            //             crossAxisSpacing: 10,
            //             mainAxisSpacing: 10,
            //           ),
            //           itemBuilder: (context, index) {
            //             return GestureDetector(
            //               onTap: () {
            //                 if (selectedImageUrlsToDownload.any(
            //                   (url) => url == data[index],
            //                 )) {
            //                   setState(() {
            //                     selectedImageUrlsToDownload.remove(data[index]);
            //                   });
            //                 } else {
            //                   setState(() {
            //                     selectedImageUrlsToDownload.add(data[index]);
            //                   });
            //                 }
            //               },
            //               child: Stack(
            //                 alignment: AlignmentDirectional.topEnd,
            //                 children: [
            //                   Image.network(data[index]),
            //                   if (selectedImageUrlsToDownload.any(
            //                     (url) => url == data[index],
            //                   ))
            //                     Icon(
            //                       Icons.check_circle,
            //                       size: 30,
            //                       color: Colors.green,
            //                     ),
            //                 ],
            //               ),
            //             );
            //           },
            //           itemCount: data.length,
            //         ),
            //       ),
            //   error: (error, stackTrace) {
            //     return SizedBox();
            //   },
            //   loading:
            //       () => Expanded(
            //         child: Center(
            //           child: SizedBox(
            //             width: 30,
            //             height: 30,
            //             child: CircularProgressIndicator(),
            //           ),
            //         ),
            //       ),
            // ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.sizeOf(context).width ~/ 150,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (selectedImageUrlsToDownload.any(
                        (url) => url == _imageUrls[index],
                      )) {
                        setState(() {
                          selectedImageUrlsToDownload.remove(_imageUrls[index]);
                        });
                      } else {
                        setState(() {
                          selectedImageUrlsToDownload.add(_imageUrls[index]);
                        });
                      }
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Image.network(_imageUrls[index]),
                        if (selectedImageUrlsToDownload.any(
                          (url) => url == _imageUrls[index],
                        ))
                          Icon(
                            Icons.check_circle,
                            size: 30,
                            color: Colors.green,
                          ),
                      ],
                    ),
                  );
                },
                itemCount: _imageUrls.length,
              ),
            ),
            if (_isLoading)
              Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
