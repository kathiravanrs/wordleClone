import 'package:GuessTheWord/keyboard_letter.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class KeyBoard extends StatefulWidget {
  Set<String> excluded;
  List<String> line1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"];
  List<String> line2 = [" ", "A", "S", "D", "F", "G", "H", "J", "K", "L", " "];
  List<String> line3 = [" ", "Z", "X", "C", "V", "B", "N", "M", " "];

  KeyBoard(this.excluded, {Key? key}) : super(key: key);

  @override
  _KeyBoardState createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  @override
  Widget build(BuildContext context) {
    Row row1 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.line1.map((f) {
        List<Widget> letters = [];
        LetterState state;

        if (widget.excluded.contains(f)) {
          state = LetterState.wrong;
        } else {
          state = LetterState.perfect;
        }
        letters.add(KeyboardLetter(f, state, 1));

        Row rows = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: letters,
        );
        return rows;
      }).toList(),
    );
    Row row2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.line2.map((f) {
        int flex = 2;
        if (f == " ") flex = 1;
        List<Widget> letters = [];
        LetterState state;
        if (f == " ") {
          state = LetterState.blank;
        } else if (widget.excluded.contains(f)) {
          state = LetterState.wrong;
        } else {
          state = LetterState.perfect;
        }
        letters.add(KeyboardLetter(f, state, flex));

        Row rows = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: letters,
        );
        return rows;
      }).toList(),
    );
    Row row3 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.line3.map((f) {
        List<Widget> letters = [];
        LetterState state;
        if (f == " ") {
          state = LetterState.blank;
        } else if (widget.excluded.contains(f)) {
          state = LetterState.wrong;
        } else {
          state = LetterState.perfect;
        }
        letters.add(KeyboardLetter(f, state, 1));

        Row rows = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: letters,
        );
        return rows;
      }).toList(),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        row2,
        row1,
        row3,
      ],
    );
  }
}
