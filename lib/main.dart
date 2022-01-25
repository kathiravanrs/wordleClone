import 'dart:math';

import 'package:GuessTheWord/letter.dart';
import 'package:GuessTheWord/wordList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'keyboard.dart';

enum LetterState { perfect, near, wrong, blank }

final entries = ValueNotifier("");
int pos = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Guess The Word",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Guess The Word'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int row = 6;
  int length = 5;
  int guesses = 0;
  bool isGameOver = false;

  String answer = wordList[Random().nextInt(wordList.length)];

  String guess = "";
  List<String> words = [
    "     ",
    "     ",
    "     ",
    "     ",
    "     ",
    "     ",
  ];

  // for (int i = 0; i < row; i++) {
  // words.add(" " * length);
  // }

  @override
  Widget build(BuildContext context) {
    // words[0] = "earth";
    var _controller = TextEditingController();
    Set<String> excluded = {};

    if (kDebugMode) {
      print(words);
      print(answer);
    }

    Column columns = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: words.map((f) {
        String e = f.toUpperCase();
        List<Widget> letters = [];
        for (int j = 0; j < length; j++) {
          LetterState state;
          if (answer.toUpperCase().contains(e[j]) &&
              answer.toUpperCase()[j] != e[j]) {
            state = LetterState.near;
          } else if (answer.toUpperCase()[j] == e[j]) {
            state = LetterState.perfect;
          } else if (e[j] == " ") {
            state = LetterState.blank;
          } else {
            excluded.add(e[j]);
            state = LetterState.wrong;
          }
          letters.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Letter(e[j], state),
          ));
        }

        Row rows = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: letters,
        );
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: rows,
        );
      }).toList(),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xff050505),
                  title: const Center(
                    child: Text(
                      'How To Play',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Guess the word in 6 tries.\n\nEach guess must be a valid 5 letter word.\n\nAfter each guess, the color of the tiles will change to show how close your guess was to the word.",
                        style: TextStyle(color: Colors.white),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                      const Text(
                        'Examples',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Letter("W", LetterState.perfect),
                          Letter("H", LetterState.near),
                          Letter("E", LetterState.wrong),
                          Letter("E", LetterState.wrong),
                          Letter("L", LetterState.wrong),
                        ],
                      ),
                      const Text(
                        'The letter W is in the word and in the correct spot.',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'The letter H is in the word but in the wrong spot.',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'The letters E and L are not in the word in any spot.',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                      const Text(
                        'Correct Answer',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Letter("W", LetterState.perfect),
                          Letter("R", LetterState.perfect),
                          Letter("A", LetterState.perfect),
                          Letter("T", LetterState.perfect),
                          Letter("H", LetterState.perfect),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
        backgroundColor: Colors.black,
        title: Center(child: Text(widget.title)),
      ),
      body: ValueListenableBuilder<String>(
          valueListenable: entries,
          builder: (context, snapshot, child) {
            String ltr = entries.value;
            List ltrs = [];
            for (int i = 0; i < ltr.length; i++) {
              ltrs.add(ltr[i]);
            }
            while (ltrs.length < 5) {
              ltrs.add(" ");
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Divider(
                  height: 20,
                  thickness: 1,
                  endIndent: 0,
                  color: Colors.white,
                ),
                columns,
                const Divider(
                  height: 20,
                  thickness: 1,
                  endIndent: 0,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ltrs.map((e) {
                    LetterState state = LetterState.blank;
                    if (e == " ") state = LetterState.wrong;
                    return Letter(e, state);
                  }).toList(),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: SizedBox(
                //     width: 200,
                //     child: TextField(
                //       textInputAction: TextInputAction.go,
                //       decoration: const InputDecoration(
                //           fillColor: Colors.grey,
                //           filled: true,
                //           hintText: 'Enter a 5 letter word',
                //           contentPadding: EdgeInsets.symmetric(
                //               horizontal: 4.0, vertical: 1.0)),
                //       controller: _controller,
                //       keyboardType: TextInputType.visiblePassword,
                //       autocorrect: false,
                //       enableSuggestions: false,
                //       onChanged: (text) {
                //         guess = text.toLowerCase();
                //       },
                //     ),
                //   ),
                // ),

                if (!isGameOver) KeyBoard(excluded),
                if (!isGameOver)
                  ElevatedButton(
                      onPressed: () {
                        _controller.clear();
                        if (words.contains(guess)) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("You already guessed that word!"),
                          ));
                        } else {
                          if (guess == answer) {
                            setState(() {
                              List<String> after = [...words];
                              after[guesses] = guess;
                              guesses++;
                              words = after;
                            });
                            isGameOver = true;
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Congratulations'),
                                content: Text('You Guessed the word in ' +
                                    (guesses).toString() +
                                    " tries"),
                              ),
                            );
                          } else {
                            if (guess.length != 5 || guess == "     ") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Please enter a 5 letter word!"),
                              ));
                            } else {
                              if (wordList.contains(guess)) {
                                setState(() {
                                  List<String> after = [...words];
                                  after[guesses] = guess;
                                  // print("Guess" + guess);
                                  guesses++;
                                  words = after;
                                });
                                setState(() {
                                  if (guesses == 6) {
                                    isGameOver = true;
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text(
                                            'Oops, You used your 6 tries!'),
                                        content: Text('The correct answer is ' +
                                            answer.toUpperCase()),
                                      ),
                                    );
                                  }
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Oops! That word is not in my dictionary")));
                              }
                            }
                          }
                          guess = "";
                        }
                      },
                      child: const Text("Check")),
                // if (!isGameOver) Spacer(),
                // if (!isGameOver)
                //   ElevatedButton(
                //       onPressed: () {
                //
                //       },
                //       child: const Text(
                //         "Give Up",
                //         style: TextStyle(
                //           color: Colors.red,
                //           fontSize: 14,
                //         ),
                //       )),
                // if (!isGameOver)
                //   const SizedBox(
                //     height: 16,
                //   ),
                if (isGameOver)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isGameOver = false;
                          pos = 0;
                          entries.value = "";
                          answer = wordList[Random().nextInt(wordList.length)];
                          guess = "";
                          guesses = 0;
                          words = [
                            "     ",
                            "     ",
                            "     ",
                            "     ",
                            "     ",
                            "     "
                          ];
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Start New Game",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                      ))
              ],
            );
          }),
    );
  }
}
