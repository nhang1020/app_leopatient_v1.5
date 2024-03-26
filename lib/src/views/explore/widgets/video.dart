import 'dart:async';

import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

class VideoPLay extends StatefulWidget {
  const VideoPLay({super.key});

  @override
  State<VideoPLay> createState() => _VideoPLayState();
}

class _VideoPLayState extends State<VideoPLay> {
  late ChewieController _chewieController;
  VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/6217721225381087223.mp4");
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController
        ..initialize().then((_) {
          setState(() {});
        }),
      // autoInitialize: true,
      materialProgressColors:
          ChewieProgressColors(playedColor: myColor, handleColor: Colors.white),
      draggableProgressBar: true,
      allowPlaybackSpeedChanging: true,

      // cupertinoProgressColors: ChewieProgressColors()
    );
  }

  // tua(Offset position) {
  //   setState(() {
  //     _width = screen(context).width / 4;
  //   });
  //   if (position.dx < screen(context).width / 2) {
  //     _videoPlayerController.seekTo(
  //       Duration(seconds: _videoPlayerController.value.position.inSeconds - 5),
  //     );
  //     setState(() {
  //       _opacityLeft = 1;
  //     });
  //     Timer(Duration(milliseconds: 800), () {
  //       setState(() {
  //         _opacityLeft = 0;
  //         _width = 0;
  //       });
  //     });
  //   } else {
  //     _videoPlayerController.seekTo(
  //       Duration(seconds: _videoPlayerController.value.position.inSeconds + 5),
  //     );
  //     setState(() {
  //       _opacityRight = 1;
  //     });
  //     Timer(Duration(milliseconds: 800), () {
  //       setState(() {
  //         _opacityRight = 0;
  //         _width = 0;
  //       });
  //     });
  //   }
  // }

  // double _opacityLeft = 0;
  // double _opacityRight = 0;
  // double _width = 0;
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      height: 230,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          // color: Theme.of(context).cardColor,
          ),
      child: GestureDetector(
        onDoubleTapDown: (details) {
          // tua(details.globalPosition);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.symmetric(vertical: 10),
              width: screen(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // color: myColor.withOpacity(.1),
              ),
              child: _videoPlayerController.value.isInitialized
                  ? CarouselSlider(
                      items: [
                        Stack(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              // height: 400,
                              // margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: Chewie(controller: _chewieController),
                              ),
                            ),
                          ],
                        )
                      ],
                      options: CarouselOptions(
                        // height: 300,

                        // aspectRatio: 16 / 5,
                        viewportFraction: isSmallScreen(context) ? .7 : .4,
                        initialPage: 0,
                        disableCenter: false,
                        enableInfiniteScroll: true,
                        reverse: false,
                        
                        // autoPlay: true,
                        // autoPlayInterval: Duration(seconds: 3),
                        scrollPhysics: BouncingScrollPhysics(),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: .4,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : Loading(),
            ),
          ],
        ),
      ),
    );
  }
}
 // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     AnimatedOpacity(
                      //       duration: Duration(milliseconds: 800),
                      //       opacity: _opacityLeft,
                      //       child: Container(
                      //         width: _width,
                      //         height: 300,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white24,
                      //           borderRadius: BorderRadius.horizontal(
                      //             right: Radius.elliptical(100, 150),
                      //           ),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Icon(Icons.fast_rewind_rounded,
                      //                 color: Colors.white),
                      //             Text(
                      //               "  -5 giây",
                      //               style: TextStyle(color: Colors.white),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     AnimatedOpacity(
                      //       duration: Duration(milliseconds: 800),
                      //       opacity: _opacityRight,
                      //       child: Container(
                      //         width: _width,
                      //         height: 300,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white24,
                      //           borderRadius: BorderRadius.horizontal(
                      //             left: Radius.elliptical(100, 150),
                      //           ),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               "5 giây  ",
                      //               style: TextStyle(color: Colors.white),
                      //             ),
                      //             Icon(Icons.fast_forward_rounded,
                      //                 color: Colors.white),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )