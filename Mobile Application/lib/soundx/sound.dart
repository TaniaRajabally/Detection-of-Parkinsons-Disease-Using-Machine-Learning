import 'package:drawx/results.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'dart:async';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../style/theme.dart' as Themes;



class Sound extends StatelessWidget {
  var result = "";
  Sound(this.result);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Audio Recorder Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Test 2: Speech', result: this.result),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.result}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String result;
  @override
  _MyHomePageState createState() => _MyHomePageState(result);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.result);
  final String result;
  FlutterAudioRecorder _recorder;
  Recording _recording;
  Timer _t;
  Widget _buttonIcon = Icon(Icons.do_not_disturb_on);
  String _alert;
  String customPath = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _prepare();
    });
  }

  void _opt() async {
    switch (_recording.status) {
      case RecordingStatus.Initialized:
        {
          await _startRecording();
          break;
        }
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          break;
        }
      case RecordingStatus.Stopped:
        {
          await _prepare();
          break;
        }

      default:
        break;
    }

    // 刷新按钮
    setState(() {
      _buttonIcon = _playerIcon(_recording.status);
    });
  }

  Future _init() async {
    customPath = '/flutter_audio_recorder_';
    io.Directory appDocDirectory;
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }

    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString();

    // .wav <---> AudioFormat.WAV
    // .mp4 .m4a .aac <---> AudioFormat.AAC
    // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.

    _recorder = FlutterAudioRecorder(customPath,
        audioFormat: AudioFormat.WAV, sampleRate: 22050);
    await _recorder.initialized;
  }

  Future _prepare() async {
    var hasPermission = await FlutterAudioRecorder.hasPermissions;
    if (hasPermission) {
      await _init();
      var result = await _recorder.current();
      setState(() {
        _recording = result;
        _buttonIcon = _playerIcon(_recording.status);
        _alert = "";
      });
    } else {
      setState(() {
        _alert = "Permission Required.";
      });
    }
  }

  Future _startRecording() async {
    await _recorder.start();
    var current = await _recorder.current();
    setState(() {
      _recording = current;
    });

    _t = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {
      var current = await _recorder.current();
      setState(() {
        _recording = current;
        _t = t;
      });
    });
  }

  Future _stopRecording() async {
    print(customPath);
    customPath = customPath + ".wav";
    print(customPath);
    var result = await _recorder.stop();
    _t.cancel();

    setState(() {
      _recording = result;
    });

  }

  void _play() {
    AudioPlayer player = AudioPlayer();
    player.play(_recording.path, isLocal: true);
  }
  void upload_recording() async {
        var uri = Uri.parse("http://9ba96a819dff.ngrok.io/sound");

    print("connection established.");
    var request = http.MultipartRequest('POST', uri);
  request.files.add(
    await http.MultipartFile.fromPath(
      'sound',
      customPath
    )
      );
    // var request = new http.MultipartRequest("POST", uri);
    //                   var multipartFile = http.MultipartFile.fromPath( 'image', customPath
    //                   );
    //                   //contentType: MediaType(‘image’, ‘png’));
    //                   request.files.add(await multipartFile);

    //                   var response = await request.send();
    //                   print(response.statusCode);
                      
    
  var res = await request.send();
  print(res);
  print(res.statusCode);
  final x = await res.stream.bytesToString();
                            print("Response :  $x");
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Results(this.result, {'Control': '0.5666'}.toString())));

  }
  Widget _playerIcon(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.Initialized:
        {
          return Icon(Icons.fiber_manual_record);
        }
      case RecordingStatus.Recording:
        {
          return Icon(Icons.stop);
        }
      case RecordingStatus.Stopped:
        {
          return Icon(Icons.replay);
        }
      default:
        return Icon(Icons.do_not_disturb_on);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: 
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Themes.Colors.loginGradientStart,
              Themes.Colors.loginGradientEnd
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
      
      child:
      Center(
        child: 
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
          padding: const EdgeInsets.only(left:40.0, right: 40.0, top: 40.0 ),
          child:
              Text(
                'Record yourself making "aaa" sound in a quiet environment for 10 seconds',
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.justify,
              ),),
              SizedBox(
                height: 15,
              ),
              // Text(
              //   '${_recording?.path ?? "-"}',
              //   style: Theme.of(context).textTheme.body1,
              // ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Duration',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${_recording?.duration ?? "-"}',
                style: Theme.of(context).textTheme.body1,
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   'Metering Level - Average Power',
              //   style: Theme.of(context).textTheme.title,
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Text(
              //   '${_recording?.metering?.averagePower ?? "-"}',
              //   style: Theme.of(context).textTheme.body1,
              // ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   'Status',
              //   style: Theme.of(context).textTheme.title,
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Text(
              //   '${_recording?.status ?? "-"}',
              //   style: Theme.of(context).textTheme.body1,
              // ),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: double.infinity,
                child:
                RaisedButton(
                color: Colors.lightBlue[300],
                child: Text('Play'),
                disabledTextColor: Colors.white,
                disabledColor: Colors.grey.withOpacity(0.5),
                onPressed: _recording?.status == RecordingStatus.Stopped
                    ? _play
                    : null,
              ),

              ),
              
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                child: Text('Upload'),
                color: Colors.lightBlue[300],
                disabledTextColor: Colors.white,
                disabledColor: Colors.grey.withOpacity(0.5),
                onPressed: _recording?.status == RecordingStatus.Stopped
                    ? upload_recording
                    : null,
              ),
              ),
              
              Text(
                '${_alert ?? ""}',
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.red),
              ),
            ],
          ),
        
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _opt,
        child: _buttonIcon,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
