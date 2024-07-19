import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speechtotext/Constants/colors.dart';
import 'package:speechtotext/Network/apis.dart';
import 'package:speechtotext/main.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              APIs.saveToFirebase(_text);
            }
          }),
        );
      } else {
        setState(() => _isListening = false);
        _speech!.stop();
      }
    } else {
      await _stopListening();
    }
  }

  Future<void> _stopListening() async {
    if (_isListening) {
      setState(() => _isListening = false);
      await _speech!.stop();
      await APIs.saveToFirebase(_text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Speech to Text',
          style: TextStyle(
              color: AppColors.background, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.appBarBackground,
        actions: [
          IconButton(
            icon: Icon(
              Icons.list,
              color: AppColors.background,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/recordings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height * 0.5,
              padding: EdgeInsets.all(16),
              child: Column(children: [
                Container(
                  height: 50,
                  width: size.width,
                  color: AppColors.appBarBackground,
                  child: Center(
                    child: Text(
                      "Recognized Text",
                      style: TextStyle(color: AppColors.background),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Container(
                  color: AppColors.containerBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        _text,
                        style: TextStyle(color: AppColors.background),
                      ),
                    ),
                  ),
                ))
              ]),
            ),
            SizedBox(height: 20),
            FloatingActionButton.extended(
              backgroundColor: AppColors.appBarBackground,
              label: _isListening
                  ? Text(
                      "Stop Recording",
                      style: TextStyle(
                        color: AppColors.background,
                      ),
                    )
                  : Text(
                      "Start Recording",
                      style: TextStyle(
                        color: AppColors.background,
                      ),
                    ),
              onPressed: _listen,
            ),
          ],
        ),
      ),
    );
  }
}
