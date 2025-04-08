import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';

class RoutePicture extends StatefulWidget {
  final int pictureNumber;

  const RoutePicture({
    required this.pictureNumber,
    super.key,
  });

  @override
  State<RoutePicture> createState() => _RoutePictureState();
}

class _RoutePictureState extends State<RoutePicture> {
  late final ValueNotifier<int> _currentIndex = ValueNotifier<int>(widget.pictureNumber);
  late final PageController _pageController = PageController(initialPage: widget.pictureNumber);

  final List<String> images = [
    'assets/image/program_card_image1.png',
    'assets/image/program_card_image2.png',
    'assets/image/program_card_image3.png',
    'assets/image/program_card_image4.png',
  ];

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
              itemCount: images.length,
              pageController: _pageController,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(images[index]),
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
                        '${currentIndex + 1} / ${images.length}',
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
