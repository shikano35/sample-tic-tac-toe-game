import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  final List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  bool isTie = false;
  player(int index) {
    if (winner != '' || board[index] != '') {
      return;
    }
    setState(() {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      checkForWinner();
    });
  }

  checkForWinner() {
    List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> line in lines) {
      String player1 = board[line[0]];
      String player2 = board[line[1]];
      String player3 = board[line[2]];
      if (player1 == '' || player2 == '' || player3 == '') {
        continue;
      }
      if (player1 == player2 && player2 == player3) {
        setState(() {
          winner = player1;
        });
        return;
      }
    }

    if (!board.contains('')) {
      setState(() {
        isTie = true;
      });
    }
  }

  resetGame() {
    setState(() {
      board.fillRange(0, 9, '');
      currentPlayer = 'X';
      winner = '';
      isTie = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        currentPlayer == 'X'
                            ? Colors.amber
                            : Colors.transparent,
                  ),
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.person, color: Colors.white, size: 55),
                      SizedBox(height: 10),
                      Text(
                        "BOT 1",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "X",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.08),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        currentPlayer == 'O'
                            ? Colors.amber
                            : Colors.transparent,
                  ),
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.person, color: Colors.white, size: 55),
                      SizedBox(height: 10),
                      Text(
                        "BOT 2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "O",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          if (winner != "")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " WON!",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (isTie)
            Text(
              "It's a Tie!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: 9,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    player(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (winner != "" || isTie)
            ElevatedButton(onPressed: resetGame, child: Text("Play Again")),
        ],
      ),
    );
  }
}
