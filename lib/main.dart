import 'package:flutter/material.dart';
import 'dart:developer' as dev;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Game(),
    );
  }
}

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool? winner;
  bool jogador = false;
  List<List<bool?>> board = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...[
            for (var i = 0; i < 3; i++)
              Row(
                children: [
                  for (var j = 0; j < 3; j++)
                    GestureDetector(
                      child: Container(
                        color: selectColor(i, j),
                        margin: const EdgeInsets.all(8),
                        height: 50,
                        width: 50,
                      ),
                      onTap: () => handleTap(i, j),
                    ),
                ],
              ),
          ],
          Visibility(
              visible: winner != null,
              replacement: Container(),
              child: Text("Ganhador ${winner}"))
        ],
      ),
    );
  }

  Color selectColor(int i, int j) {
    return board[i][j] == null
        ? Colors.black
        : board[i][j] == true
            ? Colors.blue
            : Colors.green;
  }

  void handleTap(int i, int j) {
    dev.log("clicou [${i},${j}]", name: 'click: ');
    if (board[i][j] == null && winner == null) {
      board[i][j] = jogador;
      jogador = !jogador;
      if (checkIfBlueWon()) {
        winner = true;
      } else if (checkIfGreenWon()) {
        winner = false;
      }
      setState(() {});
    }
  }

  bool checkIfBlueWon() {
    for (var r in board) {
      if (r.every((element) => element == true)) {
        return true;
      }
    }

    for (var i = 0; i < 3; i++) {
      var player = true;

      for (var j = 0; j < 3; j++) {
        player = player & (board[j][i] == true);
      }

      if (player == true) {
        return true;
      }
    }

    if ([for (var i = 0; i < 3; i++) board[i][i]]
        .every((element) => element == true)) {
      return true;
    }

    if ([for (var i = 0; i < 3; i++) board[i][3 - i - 1]]
        .every((element) => element == true)) {
      return true;
    }

    return false;
  }

  bool checkIfGreenWon() {
    for (var r in board) {
      if (r.every((element) => element == false)) {
        return true;
      }
    }

    for (var i = 0; i < 3; i++) {
      var player = true;

      for (var j = 0; j < 3; j++) {
        player = player & (board[j][i] == false);
      }

      if (player == true) {
        return true;
      }
    }

    if ([for (var i = 0; i < 3; i++) board[i][i]]
        .every((element) => element == false)) {
      return true;
    }

    if ([for (var i = 0; i < 3; i++) board[i][3 - i - 1]]
        .every((element) => element == false)) {
      return true;
    }

    return false;
  }
}
