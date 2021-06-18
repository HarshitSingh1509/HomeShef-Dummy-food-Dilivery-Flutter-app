import 'package:flutter/material.dart';
import 'package:home_chef/constants.dart';
import 'package:home_chef/size.dart';

class Button extends StatelessWidget {
  Button({required this.text, required this.onPressed});
  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: kPrimaryColor,
      ),
      child: TextButton(
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
