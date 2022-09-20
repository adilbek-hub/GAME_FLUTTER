import 'package:flutter/material.dart';
import 'package:gametetris/score_board.dart';
import 'package:gametetris/utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // double screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyMemary(),
    );
  }
}

class MyMemary extends StatefulWidget {
  const MyMemary({super.key});

  @override
  State<MyMemary> createState() => _MyMemaryState();
}

class _MyMemaryState extends State<MyMemary> {
  Game _game = Game();
  //we will add the states vriables =>мы добавим переменные состояния
  int tries = 0;
  int score = 0;
  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    //we want that the board make a screen with * screen width size
    //let is get the screen width=>давайте получим ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffe55870),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Memory Game',
              style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              scoreBoard("tries", "$tries"),
              scoreBoard("score", "$score"),
            ],
          ),
          SizedBox(
            height: screenWidth,
            width: screenWidth,
            child: GridView.builder(
                itemCount: _game.gameImg!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0),
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        //here we are going to place all our game logic
                        // print(_game.cards_list[index]);
                        setState(() {
                          tries++;
                          _game.gameImg![index] = _game.cards_list[index];
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                        });
                        if (_game.matchCheck.length == 2) {
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            print('true');
                            score += 100;
                            _game.matchCheck.clear();
                          } else {
                            print(false);
                            Future.delayed(
                              Duration(milliseconds: 500),
                              () {
                                print(_game.gameImg);
                                setState(() {
                                  _game.gameImg![_game.matchCheck[0].keys
                                      .first] = _game.hiddenCardPath;

                                  _game.gameImg![_game.matchCheck[1].keys
                                      .first] = _game.hiddenCardPath;
                                  _game.matchCheck.clear();
                                });
                              },
                            );
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffff846a),
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image: AssetImage(_game.gameImg![index]),
                              fit: BoxFit.cover),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
