import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../auth/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FlutterTts? _flutterTts;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initTts();
    _startSplashScreen();
  }

  @override
  void dispose() {
    _flutterTts?.stop();
    _flutterTts = null;
    super.dispose();
  }

  Future<void> _initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts!.setLanguage("en-US");
  }

  Future<void> _speak(String text) async {
    if (!_isPlaying) {
      await _flutterTts?.speak(text);
      setState(() {
        _isPlaying = true;
      });
    }
  }

  _navigateToLogin() async {
    await _speak("Welcome to Doctor Care");
    await Future.delayed(Duration(seconds: 4));
    await _speak("Please wait we are moving to login!");
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> _startSplashScreen() async {
    await _speak("Welcome to my app");
    await Future.delayed(Duration(seconds: 3));
    await _speak("Loading content");
    await Future.delayed(Duration(seconds: 2));
    _navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(
              "assets/Splash.png",
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}