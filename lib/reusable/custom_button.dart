import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String _text;
  final Color _color;
  final VoidCallback _action;

  const CustomButton(this._text, this._color, this._action);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _action,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_color),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ))),
      child: Text(_text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
