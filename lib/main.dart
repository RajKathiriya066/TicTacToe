import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  bool _gameOver = false;
  String _winner = '';

  void _handleTap(int index) {
    if (_board[index] == '' && !_gameOver) {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWinner()) {
          _gameOver = true;
          _winner = _currentPlayer;
        } else if (_board.every((element) => element != '')) {
          _gameOver = true;
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner() {
    const winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combo in winningCombinations) {
      if (_board[combo[0]] == _board[combo[1]] &&
          _board[combo[1]] == _board[combo[2]] &&
          _board[combo[0]] != '') {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _gameOver = false;
      _winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBoard(),
          _buildResult(_gameOver),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _handleTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
                border: Border.all(color: Colors.blue),
              ),
              child: Center(
                child: Text(
                  _board[index],
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResult(bool _gameOver) {
    if(_gameOver) {
      return Text(
      _winner.isNotEmpty ? 'Player $_winner wins!' : 'It\'s a draw!',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
    } else{
      return Text(
        "Player $_currentPlayer's turn!",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }
  }
}
