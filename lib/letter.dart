import 'package:GuessTheWord/main.dart';
import 'package:flutter/material.dart';

class Letter extends StatefulWidget {
  String letter;
  LetterState state;

  Letter(this.letter, this.state, {Key? key}) : super(key: key);

  @override
  State<Letter> createState() => _LetterState();
}

class _LetterState extends State<Letter> {
  @override
  Widget build(BuildContext context) {
    Color background;
    if (widget.state == LetterState.wrong) {
      background = const Color(0xff650006);
    } else if (widget.state == LetterState.near) {
      background = const Color(0xffb59f3b);
    } else if (widget.state == LetterState.perfect) {
      background = const Color(0xff538d4e);
    } else {
      background = Colors.black;
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.white,
      )),
      child: Container(
        color: background,
        height: 50,
        width: 50,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              widget.letter,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
