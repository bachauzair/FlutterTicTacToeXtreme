import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'Menu Screen.dart';
import 'MultiPlayer.dart';
import 'TicTacToe Game Screen.dart';

void main() {
  runApp(const TicTacToeApp());
}

enum Difficulty { easy, medium, hard }

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightGreen[200],

      ),
      home: const MenuScreen(),
    );
  }
}







