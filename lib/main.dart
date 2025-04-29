import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Sederhana Lengkap',
      theme: ThemeData(primarySwatch: Colors.green),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int lives = 3;
  int timeLeft = 60;
  int score = 0;
  int level = 1;
  late Timer timer;
  bool isGameOver = false;
  bool showEffect = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    print("🎵 Musik latar dimulai (simulasi)");
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
          score += 10;
          if (score % 100 == 0) {
            level++;
          }
          if (timeLeft % 5 == 0) {
            showEffect = true;
            Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                showEffect = false;
              });
            });
          }
        } else {
          endGame();
        }
      });
    });
  }

  void loseLife() {
    setState(() {
      lives--;
      if (lives <= 0) {
        endGame();
      }
    });
  }

  void endGame() {
    timer.cancel();
    setState(() {
      isGameOver = true;
    });
  }

  void resetGame() {
    setState(() {
      lives = 3;
      timeLeft = 60;
      score = 0;
      level = 1;
      isGameOver = false;
      showEffect = false;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Lengkap')),
      body: Center(
        child: isGameOver
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Game Over!', style: TextStyle(fontSize: 24)),
                  Text('Score: \$score', style: TextStyle(fontSize: 20)),
                  ElevatedButton(onPressed: resetGame, child: Text('Restart'))
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Lives: \$lives', style: TextStyle(fontSize: 18)),
                  Text('Time Left: \$timeLeft', style: TextStyle(fontSize: 18)),
                  Text('Score: \$score', style: TextStyle(fontSize: 18)),
                  Text('Level: \$level', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: loseLife, child: Text('Take Damage')),
                  if (showEffect)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(10),
                      color: Colors.redAccent,
                      child: Text('🔥 Efek Spesial!',
                          style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                    )
                ],
              ),
      ),
    );
  }
}
