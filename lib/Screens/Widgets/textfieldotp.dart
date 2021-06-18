import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldOtp extends StatelessWidget {
  TextFieldOtp({this.focusNodeP, this.focusNodeN, required this.onChanged});

  final focusNodeP;
  final focusNodeN;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 80,
      padding: EdgeInsets.all(10),
      child: TextField(
        style: const TextStyle(
            color: Color(0xFF4A5397),
            fontSize: 25,
            fontWeight: FontWeight.bold),
        cursorColor: Color(0xFF4A5397),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            fillColor: Colors.black26,
            alignLabelWithHint: false,
            filled: false,
            enabled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            counterText: ''),
        // decoration: kOtpTF.copyWith(counterText: ''),
        focusNode: focusNodeP,
        maxLength: 1,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(focusNodeN);
        },
      ),
    );
  }
}
