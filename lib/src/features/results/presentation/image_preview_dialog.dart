import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_upload_test/src/common_widgets/double_click_zoomable_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ImagePreviewDialog extends StatefulWidget {
  final List<String> imagePaths;
  final int initialIndex;

  const ImagePreviewDialog({
    super.key,
    required this.imagePaths,
    this.initialIndex = 0,
  });

  @override
  State<ImagePreviewDialog> createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<ImagePreviewDialog> {
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();
  ScrollPhysics _scrollPhysics = PageScrollPhysics();
  int _currentIndex = 0;

  void getCurrentIndex() {
    final visibleItems = _itemPositionsListener.itemPositions.value.toList();

    // Get current index that most visible on screen
    final mostVisibleItem = visibleItems.reduce(
      (a, b) => a.itemLeadingEdge.abs() < b.itemLeadingEdge.abs() ? a : b,
    );

    setState(() {
      _currentIndex = mostVisibleItem.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(getCurrentIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialIndex != null) {
        _itemScrollController.jumpTo(index: widget.initialIndex!);
      }
    });
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(getCurrentIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Column(
          children: [
            Expanded(
              child: ScrollablePositionedList.builder(
                itemCount: widget.imagePaths.length,
                itemBuilder: (context, index) {
                  return DoubleClickZoomableView(
                    child: Image.file(
                      File(widget.imagePaths[index]),
                      width: MediaQuery.sizeOf(context).width,
                    ),
                    onZoomIn:
                        () => setState(() {
                          _scrollPhysics = NeverScrollableScrollPhysics();
                        }),
                    onZoomOut:
                        () => setState(() {
                          _scrollPhysics = PageScrollPhysics();
                        }),
                  );
                },
                scrollDirection: Axis.horizontal,
                physics: _scrollPhysics,
                itemPositionsListener: _itemPositionsListener,
                itemScrollController: _itemScrollController,
              ),
            ),
            Container(
              height: 55,
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: _currentIndex == index ? 2 : 0,
                      ),
                    ),
                    child: GestureDetector(
                      onTap:
                          () => _itemScrollController.scrollTo(
                            index: index,
                            duration: Duration(milliseconds: 200),
                          ),
                      child: Image.file(
                        File(widget.imagePaths[index]),
                        width: 50,
                        height: 50,
                      ),
                    ),
                  );
                },
                itemCount: widget.imagePaths.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 10),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Icon(Icons.close, size: 40),
          ),
        ),
      ],
    );
  }
}
