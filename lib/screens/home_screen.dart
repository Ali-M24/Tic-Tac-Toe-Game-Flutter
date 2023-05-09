import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool turnO = true;
  List<String> xOroList = ["", "", "", "", "", "", "", "", ""];
  int filledBox = 0;
  bool gameHasResault = false;
  int ScoreX = 0;
  int ScoreO = 0;
  String winnerTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Tic Tac Toe'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () {
                filledBox = 0;
                clearGame();
              },
              child: Icon(
                Icons.refresh,
                size: 28.0,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 32.0,
            ),
            _getScoreBoard(),
            SizedBox(
              height: 32.0,
            ),
            _getResaultButton(),
            SizedBox(
              height: 32.0,
            ),
            _getGridview(),
            _getTurnText(),
            SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getResaultButton() {
    return Visibility(
      visible: gameHasResault,
      child: OutlinedButton(
        onPressed: () {
          gameHasResault = false;
          clearGame();
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: Text(
          '$winnerTitle, play again!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _getTurnText() {
    return Text(
      turnO ? "Turn O" : "Turn X",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    );
  }

  void tapped(int index) {
    if (gameHasResault) {
      return;
    }
    if (xOroList[index].length == 0) {
      setState(() {
        if (turnO) {
          xOroList[index] = 'O';
          filledBox = filledBox + 1;
        } else {
          xOroList[index] = 'X';
          filledBox = filledBox + 1;
        }
        turnO = !turnO;
        checkWinner();
      });
    }
  }

  void clearGame() {
    setState(() {
      xOroList = ["", "", "", "", "", "", "", "", ""];
    });
  }

  void setResault(String winner, String title) {
    setState(() {
      gameHasResault = true;
      winnerTitle = title;
      if (winner == 'X') {
        ScoreX = ScoreX + 1;
      } else if (winner == 'O') {
        ScoreO = ScoreO + 1;
      } else {
        ScoreX = ScoreX + 1;
        ScoreO = ScoreO + 1;
      }
    });
  }

  void checkWinner() {
    if (xOroList[0] == xOroList[1] &&
        xOroList[0] == xOroList[2] &&
        xOroList[0] != "") {
      setResault(xOroList[0], 'Winner is ' + xOroList[0]);
      return;
    }
    if (xOroList[3] == xOroList[4] &&
        xOroList[3] == xOroList[5] &&
        xOroList[3] != "") {
      setResault(xOroList[3], 'Winner is ' + xOroList[3]);
      return;
    }
    if (xOroList[6] == xOroList[7] &&
        xOroList[6] == xOroList[8] &&
        xOroList[6] != "") {
      setResault(xOroList[6], 'Winner is ' + xOroList[6]);
      return;
    }
    if (xOroList[0] == xOroList[3] &&
        xOroList[0] == xOroList[6] &&
        xOroList[0] != "") {
      setResault(xOroList[0], 'Winner is ' + xOroList[0]);
      return;
    }
    if (xOroList[1] == xOroList[4] &&
        xOroList[1] == xOroList[7] &&
        xOroList[1] != "") {
      setResault(xOroList[1], 'Winner is ' + xOroList[1]);
      return;
    }
    if (xOroList[2] == xOroList[5] &&
        xOroList[2] == xOroList[8] &&
        xOroList[2] != "") {
      setResault(xOroList[2], 'Winner is ' + xOroList[2]);
      return;
    }
    if (xOroList[0] == xOroList[4] &&
        xOroList[0] == xOroList[8] &&
        xOroList[0] != "") {
      setResault(xOroList[0], 'Winner is ' + xOroList[0]);
      return;
    }
    if (xOroList[2] == xOroList[4] &&
        xOroList[2] == xOroList[6] &&
        xOroList[2] != "") {
      setResault(xOroList[2], 'Winner is ' + xOroList[2]);
      return;
    }
    if (filledBox == 9) {
      setResault('', 'Draw');
    }
  }

  Widget _getGridview() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    xOroList[index],
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: xOroList[index] == "X" ? Colors.white : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player O',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$ScoreO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$ScoreX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
