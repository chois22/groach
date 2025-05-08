import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/model/model_review.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/text_style.dart';

class RouteReviewPicture extends StatefulWidget {
  final ModelReview modelReview;
  final int pictureNumber;

  const RouteReviewPicture({
    required this.modelReview,
    required this.pictureNumber,
    super.key,
  });

  @override
  State<RouteReviewPicture> createState() => _RouteReviewPictureState();
}

class _RouteReviewPictureState extends State<RouteReviewPicture> {
  late final ValueNotifier<int> _currentIndex = ValueNotifier<int>(widget.pictureNumber);
  late final PageController _pageController = PageController(initialPage: widget.pictureNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(''),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: widget.modelReview.listImgUrl.length,
              pageController: _pageController,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider (widget.modelReview.listImgUrl[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 2,
                );
              },
              onPageChanged: (index) {
                _currentIndex.value = index;
              },
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: ValueListenableBuilder<int>(
                valueListenable: _currentIndex,
                builder: (context, currentIndex, child) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: colorBlack,
                      ),
                      child: Text(
                        '${currentIndex + 1} / ${widget.modelReview.listImgUrl.length}',
                        style: TS.s18w600(colorWhite),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
