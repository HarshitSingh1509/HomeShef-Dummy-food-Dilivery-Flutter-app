import 'package:flutter/material.dart';
import 'package:home_chef/size.dart';

double kHeight10 = 10.0;
SizedBox inputHeight(double kHeight10) {
  return SizedBox(
    height: kHeight10,
  );
}

const kPrimaryColor = Color(0xFF4A5397);
const kSecondaryColor = Color(0xFFFFFFFF);
const kTextColor = Color(0xFF000000);

const normal16primary = TextStyle(
  fontSize: 16,
  color: kPrimaryColor,
);
const bold18primary = TextStyle(
  fontSize: 18,
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
);

const bold16black = TextStyle(
  color: kTextColor,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const bold14black = TextStyle(
  color: kTextColor,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);
const bold12black = TextStyle(
  color: kTextColor,
  fontSize: 12,
  fontWeight: FontWeight.bold,
);

const kAnimationDuration = Duration(milliseconds: 200);

TextStyle headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Color(0xFF4A5397),
  height: 1.5,
);

final kRoundedBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: kSecondaryColor,
  boxShadow: [
    BoxShadow(
      blurRadius: 5,
      spreadRadius: 2,
      color: Colors.black.withOpacity(0.12),
    ),
  ],
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

InputDecoration kTextFieldDeco = InputDecoration(
  labelStyle: TextStyle(color: kPrimaryColor, fontSize: 15),
  focusColor: kPrimaryColor,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.transparent),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: kPrimaryColor),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: kPrimaryColor),
  ),
  fillColor: Colors.white,
);
InputDecoration kOtpTF = InputDecoration(
    contentPadding: const EdgeInsets.all(4),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ));
