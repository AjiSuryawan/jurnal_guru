import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String _label;
  final TextInputType _inputType;
  final TextEditingController _controller;

  const CustomTextField(this._label, this._inputType, this._controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: _inputType,
      decoration: InputDecoration(
        labelText: _label,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF38A3A5), width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
