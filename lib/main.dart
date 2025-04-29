
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyGameApp());
}

class MyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int lives = 3;
  int secondsLeft = 30;
  Timer? _timer;
  bool showEffect = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() => secondsLeft--);
      } else {
        _timer?.cancel();
      }
    });
  }

  void loseLife() {
    if (lives > 0) {
      setState(() => lives--);
      if (lives == 0) _timer?.cancel();
    }
  }

  void triggerEffect() {
    setState(() => showEffect = true);
    Future.delayed(Duration(seconds: 1), () {
      setState(() => showEffect = false);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Time!")),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lives: $lives", style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                Text("Time left: $secondsLeft", style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loseLife,
                  child: Text("Lose Life"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: triggerEffect,
                  child: Text("Special Effect"),
                ),
              ],
            ),
          ),
          if (showEffect)
            Container(
              color: Colors.blue.withOpacity(0.5),
              child: Center(
                child: Text(
                  "💥 EFFECT! 💥",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
