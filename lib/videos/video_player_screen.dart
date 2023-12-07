

import 'package:fitness_app_flutter/videos/videos_search.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:async';



class VideoPlayerScreen extends StatefulWidget {
  final VideoData videoData;

  VideoPlayerScreen({required this.videoData});


  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  double _currentVolume = 1.0; // Initialize volume to max (1.0)
   bool _isFullScreen = false;
   

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoData.videoUrl)
      ..addListener(() {
        setState(() {
          if (!_controller.value.isPlaying && _controller.value.isInitialized) {
            _isPlaying = false;
          }
        });
      });

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.setVolume(_currentVolume); // Set initial volume
    });
  }
  void videoPlayerListener() {
    if (_controller.value.hasError) {
      // Handle error
    } else if (_controller.value.isInitialized) {
      if (_controller.value.isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(videoPlayerListener);
    _controller.dispose();
    super.dispose();
  }

   

  @override
  Widget build(BuildContext context) {
    if (_isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.videoData.title),
      ),
      body: SingleChildScrollView(
        
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      if(!_isPlaying)  
                      Image.network(widget.videoData.previewImageUrl,
                      fit: BoxFit.cover,
                      height: 300,
                      width: double.infinity,
                      ),
                      if(_isPlaying)
                      Center(
                      child:_controller.value.isInitialized ? AspectRatio(aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                      ) 
                      :Container()
                      //: Image.network(widget.videoData.previewImageUrl,fit: BoxFit.cover,),

                      //  AspectRatio(
                      //   aspectRatio: _controller.value.aspectRatio,
                      //   child: VideoPlayer(_controller),
                      // ),
                    ),
                     if (!_controller.value.isInitialized)
            Center(
              child: CircularProgressIndicator(),
            ),
                  
                  Positioned(
                     bottom: 0,
            left: 0,
            right: 0,
                    // bottom:  ,
                    child: Visibility(
                       visible: _controller.value.isInitialized && !_isPlaying,
                      child: Slider(
                        
                        activeColor: Color.fromARGB(255, 163, 172, 224),
                        inactiveColor: Colors.black,
                                  value: _controller.value.position.inMilliseconds.toDouble(),
                                  min: 0,
                                  max: _controller.value.duration.inMilliseconds.toDouble(),
                                  onChanged: (newValue) {
                                    _controller.seekTo(Duration(milliseconds: newValue.toInt()));
                                  },
                                ),
                    ),
                  ),
                ],),
                ],
              );
            } 
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     IconButton(
          //       onPressed: () {
                  
          //       },
          //       icon: Icon(
          //         _isPlaying
          //             ? Icons.pause_circle_filled
          //             : Icons.play_circle_filled,
          //         size: 50,
          //       ),
          //     ),
              // IconButton(
              //   onPressed: () {
              //     _showSeekDialog(context, _controller);
              //   },
              //   icon: Icon(
              //     Icons.replay_10,
              //     size: 40,
              //   ),
              // ),
          //   ],
          // ),
          FloatingActionButton(elevation: 26,
          backgroundColor: Colors.black,
            onPressed: (){setState(() {
                    if (_isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                    _isPlaying = !_isPlaying;
                  },
                  );},
                  child: Icon(  _isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  size: 50,),
                  ),
                  SizedBox(height: 16,),
          FloatingActionButton(
            elevation: 46,
            backgroundColor: Colors.black,
           // foregroundColor: Color.fromRGBO(239, 239, 85, 1),
            onPressed: () {
              setState(() {
                if (_controller.value.volume == 0) {
                  _controller.setVolume(_currentVolume);
                } else {
                  _controller.setVolume(0);
                }
              });
            },
            child: Icon(
              
              _controller.value.volume == 0
                  ? Icons.volume_off
                  : Icons.volume_up,
                  size: 36,
                  shadows: [BoxShadow(blurRadius: 36)],
            ),
          ),
          SizedBox(height: 16),
          // FloatingActionButton(
          //   onPressed: () {
          //     SystemChrome.setPreferredOrientations([
          //       DeviceOrientation.landscapeLeft,
          //       DeviceOrientation.landscapeRight,
          //     ]);
          //   },
          //   child: Icon(Icons.rotate_90_degrees_ccw),
          // ),
          FloatingActionButton(
            elevation: 46,backgroundColor: Colors.black,
                onPressed: () { 
                  setState(() {
                    _isFullScreen = !_isFullScreen;
                  });
                },
                child: Icon(
                  
                  _isFullScreen
                      ? Icons.fullscreen_exit
                      : Icons.fullscreen,
                      size: 40,
                      shadows: [BoxShadow(blurRadius: 15.0)],
                ),
              ),
        ],
      ),
    );
  }



// class _ControlsOverlay extends StatelessWidget {
//   final VideoPlayerController controller;

//   _ControlsOverlay({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withOpacity(0.4),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   // Toggle volume on/off
//                   double newVolume = controller.value.volume > 0 ? 0 : 1.0;
//                   controller.setVolume(newVolume);
//                 },
//                 icon: Icon(
//                   controller.value.volume > 0
//                       ? Icons.volume_up
//                       : Icons.volume_off,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }




//  void _showSeekDialog(BuildContext context, VideoPlayerController controller) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         int seekValue = 10;
//         return AlertDialog(
//           title: Text('Seek Forward'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Seek by seconds:'),
//               SizedBox(height: 10),
//               TextField(
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   seekValue = int.tryParse(value) ?? 10;
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 controller.seekTo(
//                   Duration(
//                     seconds: controller.value.position.inSeconds + seekValue,
//                   ),
//                 );
//               },
//               child: Text('Seek'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
}







  // void _showSeekDialog(BuildContext context, VideoPlayerController controller) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       int seekValue = 10;
  //       return AlertDialog(
  //         title: Text('Seek Forward'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text('Seek by seconds:'),
  //             SizedBox(height: 10),
  //             TextField(
  //               keyboardType: TextInputType.number,
  //               onChanged: (value) {
  //                 seekValue = int.tryParse(value) ?? 10;
  //               },
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               controller.seekTo(
  //                 Duration(
  //                   seconds: controller.value.position.inSeconds + seekValue,
  //                 ),
  //               );
  //             },
  //             child: Text('Seek'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  









// class VideoListItem extends StatelessWidget {
//   final VideoData videoData;

//   VideoListItem({required this.videoData});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(videoData.title),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => VideoPlayerScreen(videoData: videoData),
//           ),
//         );
//       },
//     );
//   }
// }
// class _ControlsOverlay extends StatelessWidget {
//   const _ControlsOverlay({required this.controller});

//   static const List<Duration> _exampleCaptionOffsets = <Duration>[
//     Duration(seconds: -10),
//     Duration(seconds: -3),
//     Duration(seconds: -1, milliseconds: -500),
//     Duration(milliseconds: -250),
//     Duration.zero,
//     Duration(milliseconds: 250),
//     Duration(seconds: 1, milliseconds: 500),
//     Duration(seconds: 3),
//     Duration(seconds: 10),
//   ];
//   static const List<double> _examplePlaybackRates = <double>[
//     0.25,
//     0.5,
//     1.0,
//     1.5,
//     2.0,
//     3.0,
//     5.0,
//     10.0,
//   ];

//   final VideoPlayerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 50),
//           reverseDuration: const Duration(milliseconds: 200),
//           child: controller.value.isPlaying
//               ? const SizedBox.shrink()
//               : Container(
//                   color: Colors.black26,
//                   child: const Center(
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 100.0,
//                       semanticLabel: 'Play',
//                     ),
//                   ),
//                 ),
//         ),
//         GestureDetector(
//           onTap: () {
//             controller.value.isPlaying ? controller.pause() : controller.play();
//           },
//         ),
//         Align(
//           alignment: Alignment.topLeft,
//           child: PopupMenuButton<Duration>(
//             initialValue: controller.value.captionOffset,
//             tooltip: 'Caption Offset',
//             onSelected: (Duration delay) {
//               controller.setCaptionOffset(delay);
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuItem<Duration>>[
//                 for (final Duration offsetDuration in _exampleCaptionOffsets)
//                   PopupMenuItem<Duration>(
//                     value: offsetDuration,
//                     child: Text('${offsetDuration.inMilliseconds}ms'),
//                   )
//               ];
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 // Using less vertical padding as the text is also longer
//                 // horizontally, so it feels like it would need more spacing
//                 // horizontally (matching the aspect ratio of the video).
//                 vertical: 12,
//                 horizontal: 16,
//               ),
//               child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: PopupMenuButton<double>(
//             initialValue: controller.value.playbackSpeed,
//             tooltip: 'Playback speed',
//             onSelected: (double speed) {
//               controller.setPlaybackSpeed(speed);
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuItem<double>>[
//                 for (final double speed in _examplePlaybackRates)
//                   PopupMenuItem<double>(
//                     value: speed,
//                     child: Text('${speed}x'),
//                   )
//               ];
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 // Using less vertical padding as the text is also longer
//                 // horizontally, so it feels like it would need more spacing
//                 // horizontally (matching the aspect ratio of the video).
//                 vertical: 12,
//                 horizontal: 16,
//               ),
//               child: Text('${controller.value.playbackSpeed}x'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
