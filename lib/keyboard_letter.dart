import 'package:GuessTheWord/main.dart';
import 'package:flutter/material.dart';

class KeyboardLetter extends StatefulWidget {
  int flex;
  String letter;
  LetterState state;

  KeyboardLetter(this.letter, this.state, this.flex, {Key? key})
      : super(key: key);

  @override
  State<KeyboardLetter> createState() => _KeyboardLetter();
}

class _KeyboardLetter extends State<KeyboardLetter> {
  @override
  Widget build(BuildContext context) {
    Color background;
    if (widget.state == LetterState.wrong) {
      background = const Color(0xff650006);
    } else if (widget.state == LetterState.blank) {
      background = const Color(0xff000000);
    } else {
      background = const Color(0xffffffff);
    }

    return Flexible(
      fit: FlexFit.loose,
      flex: widget.flex,
      child: GestureDetector(
        onTap: () {
          if (pos < 5) {
            entries.value = (widget.letter);
            pos++;
            print(entries.value);
          }
        },
        child: Container(
          constraints:
              const BoxConstraints(minHeight: 20, maxHeight: 50, maxWidth: 20),
          color: Colors.black,
          child: Center(
            child: Text(
              widget.letter,
              style: TextStyle(
                  color: background, fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
