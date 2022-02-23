import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_utils/file_utils.dart';

class VideoPlay extends StatefulWidget {
  final String video;
  final String url;
  const VideoPlay({Key? key, required this.video, required this.url})
      : super(key: key);

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController _controller;
  late bool fileExists;
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  Future<bool> checkFile() async {
    if (Platform.isAndroid) {
      var dirloc = "/sdcard/download/";
      fileExists = await File(dirloc + widget.video).exists();
    } else {
      var dirloc = (await getApplicationDocumentsDirectory()).path;

      fileExists = await File(dirloc + widget.video).exists();
    }

    return fileExists;
  }

  Future<void> downloadFile(String pdfUrl) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    Dio dio = Dio();

    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      var savepath = dirloc + widget.video;

      try {
        FileUtils.mkdir([dirloc]);
        var response = await dio.download(pdfUrl, savepath,
            onReceiveProgress: (receivedBytes, totalBytes) {
          print('here 1');
          setState(() {
            downloading = true;
            progress =
                ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
            print(progress);
          });
          print('here 2');
        });
        result['isSuccess'] = response.statusCode == 200;
        result['filePath'] = savepath;
      } catch (e) {
        print('catch catch catch');
        result['error'] = e.toString();
        print(e);
      } finally {}

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        path = savepath;
      });
      print(path);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Download Complete'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonBtn(
                          height: 40,
                          borderRadius: 5,
                          width: 90,
                          textSize: 12,
                          s: 'Close',
                          bgcolor: apptealColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Pop(context);
                          }),
                      commonBtn(
                          height: 40,
                          textSize: 12,
                          borderRadius: 5,
                          width: 90,
                          s: 'ok',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ],
              ));
      print('here give alert-->completed');
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile(pdfUrl);
        };
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkFile().then((value) async {
      if (value) {
        if (Platform.isAndroid) {
          setState(() {
            _controller = VideoPlayerController.file(
                File("/sdcard/download/" + widget.video))
              ..initialize().then((value) {
                setState(() {});
              });
          });
        } else {
          var dirloc = (await getApplicationDocumentsDirectory()).path;
          setState(() {
            _controller =
                VideoPlayerController.file(File(dirloc + widget.video))
                  ..initialize().then((value) {
                    setState(() {});
                  });
          });
        }
      } else {
        downloadFile(widget.url).then((value) async {
          if (Platform.isAndroid) {
            setState(() {
              _controller = VideoPlayerController.file(
                  File("/sdcard/download/" + widget.video))
                ..initialize().then((value) {
                  setState(() {});
                });
            });
          } else {
            var dirloc = (await getApplicationDocumentsDirectory()).path;
            setState(() {
              _controller =
                  VideoPlayerController.file(File(dirloc + widget.video))
                    ..initialize().then((value) {
                      setState(() {});
                    });
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (downloading)
        ? Scaffold(
            body: Center(
              child: Text('Downloading' + progress),
            ),
          )
        : Scaffold(
            body: Center(
                child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller))),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
