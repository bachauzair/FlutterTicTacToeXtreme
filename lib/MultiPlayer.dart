import 'package:flutter/material.dart';

import 'TicTacToe Game Screen.dart';

class MultiplayerScreen extends StatefulWidget {
  @override
  _MultiplayerScreenState createState() => _MultiplayerScreenState();
}

class _MultiplayerScreenState extends State<MultiplayerScreen> {
  late List<List<Player>> _board;
  late bool _isPlayer1Turn;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initBoard();
  }

  void _initBoard() {
    _board = List.generate(3, (_) => List.filled(3, Player.none));
    _isPlayer1Turn = true;
    _gameOver = false;
  }

  void _makeMove(int row, int col) {
    if (!_gameOver && _board[row][col] == Player.none) {
      setState(() {
        _board[row][col] = _isPlayer1Turn ? Player.player1 : Player.player2;
        if (_checkWinner(row, col)) {
          _showResultDialog(_isPlayer1Turn ? 'Player 1 wins!' : 'Player 2 wins!');
        } else if (_checkDraw()) {
          _showResultDialog('It\'s a draw!');
        } else {
          _isPlayer1Turn = !_isPlayer1Turn;
        }
      });
    }
  }

  bool _checkWinner(int row, int col) {
    Player symbol = _board[row][col];
    // Check row
    if (_board[row].every((element) => element == symbol)) {
      return true;
    }
    // Check column
    if (_board.every((row) => row[col] == symbol)) {
      return true;
    }
    // Check diagonal (if applicable)
    if ((row == col || row + col == 2) &&
        (_board[0][0] == symbol && _board[1][1] == symbol && _board[2][2] == symbol ||
            _board[0][2] == symbol && _board[1][1] == symbol && _board[2][0] == symbol)) {
      return true;
    }
    return false;
  }

  bool _checkDraw() {
    for (var row in _board) {
      for (var cell in row) {
        if (cell == Player.none) {
          return false;
        }
      }
    }
    return true;
  }

  void _showResultDialog(String result) {
    _gameOver = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(result),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
              child: const Text('New Game'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      _initBoard();
      _gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiplayer Tic Tac Toe'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Set background color
                  border: Border.all(color: Colors.black),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0, // Add grid lines
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () {
                        _makeMove(row, col);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: _buildSymbol(_board[row][col]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildSymbol(Player player) {
    switch (player) {
      case Player.player1:
        return const Icon(Icons.close, size: 50, color: Colors.blue);
      case Player.player2:
        return const Icon(Icons.circle, size: 50, color: Colors.red);
      default:
        return const SizedBox.shrink();
    }
  }
}
