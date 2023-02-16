import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_gallery/assets/consts.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'animation/timepainter.dart';
import 'localization/localizations.dart';
import 'styling.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key});

  @override
  PhotoGalleryState createState() => PhotoGalleryState();
}

class PhotoGalleryState extends State<PhotoGallery>
    with TickerProviderStateMixin {
  static String url = CONSTS.url;
  final int numberOfImages = CONSTS.numberOfImages;
  List<String> urlImages = [];

  @override
  void initState() {
    super.initState();
    setImagesList(urlImages, url, numberOfImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GalleryWidget(
      urlImages: urlImages,
      url: url,
      numberOfImages: numberOfImages,
    )));
  }

  // method we can use to start the gallery by tap on an element
  /*void openGallery() => Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GalleryWidget(
            urlImages: urlImages,
            url: url,
            numberOfImages: numberOfImages,
          )));*/
}

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<String> urlImages;
  final String url;
  final int numberOfImages;
  final int index;

  GalleryWidget(
      {super.key,
      required this.urlImages,
      required this.url,
      required this.numberOfImages,
      this.index = 0})
      : pageController = PageController(initialPage: index);

  @override
  GalleryWidgetState createState() => GalleryWidgetState();
}

class GalleryWidgetState extends State<GalleryWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late int index = widget.index;

  Timer? timer;

  String get timerString {
    Duration duration =
        animationController.duration! * animationController.value;
    return (duration.inSeconds + 1).toString().padLeft(1, '0');
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: CONSTS.numberOfMilliSeconds),
    );
  }

  void deletePicture(list, index) {
    list.removeWhere((str) => str == list[index]);
    setState(() {
      list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PhotoViewGallery.builder(
          pageController: widget.pageController,
          itemCount: widget.urlImages.length,
          builder: (context, index) {
            final urlImage = widget.urlImages[index];

            return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(urlImage));
          },
          onPageChanged: (index) => setState(() => this.index = index),
        ),
        widget.numberOfImages > widget.urlImages.length
            ? Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(0, xxlPadding, xlPadding, 0),
                  child: InkWell(
                    onTap: () => {
                      setImagesList(
                          widget.urlImages, widget.url, widget.numberOfImages),
                      setState(() {
                        widget.urlImages;
                      }),
                    },
                    child: Text(
                      AppLocalizations.reset,
                      style: smallTextStyle,
                    ),
                  ),
                ))
            : Container(),
        Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Container(
                    margin: const EdgeInsets.all(sPadding),
                    width: MediaQuery.of(context).size.width * .8,
                    child: InkWell(
                      onTap: () {
                        if (!animationController.isAnimating) {
                          var i = index;
                          timer = Timer(
                              const Duration(
                                  milliseconds: CONSTS.numberOfMilliSeconds),
                              () => deletePicture(widget.urlImages, i));

                          animationController.reverse(
                              from: animationController.value == 0.0
                                  ? 1.0
                                  : animationController.value);
                        } else {
                          timer?.cancel();
                          animationController.reset();
                        }
                      },
                      child: Container(
                        height:
                            45.0, // also better to place in styling.dart with the name f.e. 'buttonContainerHeight'
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(borderRadiusSmall),
                          color: AppColors.deepPurple,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                !animationController.isAnimating
                                    ? AppLocalizations.deletePhoto
                                    : AppLocalizations.cancel,
                                textAlign: TextAlign.center,
                                style: mediumTextStyle,
                              ),
                              animationController.isAnimating
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: mPadding),
                                      child: AspectRatio(
                                          aspectRatio: 1.0,
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  sPadding + 2 * xxsPadding),
                                              child: Stack(children: [
                                                Positioned.fill(
                                                    child: CustomPaint(
                                                  painter: TimerPainter(
                                                    animation:
                                                        animationController,
                                                    backgroundColor:
                                                        AppColors.deepPurple,
                                                    color: AppColors.white,
                                                  ),
                                                )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          mPadding,
                                                          2 * xxsPadding,
                                                          0,
                                                          0),
                                                  child: Text(
                                                    animationController
                                                            .isAnimating
                                                        ? timerString
                                                        : '',
                                                    style: mediumTextStyle,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ]))))
                                  : Container()
                            ]),
                      ),
                    ),
                  );
                }))
      ],
    ));
  }
}

List<String> setImagesList(List<String> imagesList, String url, int length) {
  for (var i = 1; i <= length; i++) {
    if (!imagesList.contains('$url?image=$i')) {
      imagesList.insert(i - 1, '$url?image=$i');
    }
  }

  return imagesList;
}
