import 'package:flutter/material.dart';

class QuestionSection extends StatelessWidget {
  final String _heading;
  final String _body;
  static const double _hPad = 16.0;

  QuestionSection(this._heading, this._body);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad, 32.0, _hPad, 4.0),
          child: Text(_heading, style: TextStyle(fontSize: 26.0)),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad, 10.0, _hPad, _hPad),
          child: Text(_body, style: TextStyle(fontSize: 16.0)),
        ),
      ],
    );
  }
}
