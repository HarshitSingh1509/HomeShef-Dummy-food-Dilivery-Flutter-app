import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_chef/Screens/SignIn_Screen.dart';
import 'package:home_chef/Screens/appknowledge_Screen2.dart';
import 'package:home_chef/Screens/otpvalidation.dart';
import 'package:home_chef/utils/comman.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/res.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'appknowledge_screen1.dart';

class SignUp_Screen extends StatefulWidget {
  @override
  _SignUp_ScreenState createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  final emailorphone = TextEditingController();
  Future<void> signinreq(String emailorphone) async {
    var request = http.Request('POST',
        Uri.parse('http://homeshef-test.herokuapp.com/account/sendotp/'));
    request.bodyFields = {'phone': emailorphone};
    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);
    print(response1.statusCode);
    if (response1.statusCode == 200) {
      // var userdata = json.decode(response.body);
      await Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                AppKnowledgeScreen1(phno: emailorphone),
          ));
      // print(response.body);
    } else {
      final snackBar = SnackBar(content: Text('Number already in use'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // print(response.reasonPhrase);
    }
  }

  var refcode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Comman.sizeBoxheight(60),
                _signUpText(),
                Comman.sizeBoxheight(25),
                _phoneNumberLayout(),
                Comman.sizeBoxheight(30),
                _signUpButton(),
                Comman.sizeBoxheight(50),
                _alreadySignUpText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SignIn text
  _signUpText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Constants.welcomeText,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: FontFamily.OpenSansRegular,
                fontWeight: FontWeight.w700,
                fontSize: Comman.displayWidth(context) * 0.09),
          ),
          Comman.sizeBoxheight(20),
          Text(
            Constants.signUpText,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: FontFamily.OpenSansRegular,
                fontWeight: FontWeight.w700,
                fontSize: Comman.displayWidth(context) * 0.07),
          ),
        ],
      ),
    );
  }

  // Enter phone number
  _phoneNumberLayout() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: Comman.displayHeight(context) * 0.25,
      width: Comman.displayWidth(context) * 1,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Comman.sizeBoxheight(20),
          _numberInputField(),
          Comman.sizeBoxheight(25),
          _passwordInputField()
        ],
      ),
    );
  }

  _passwordInputField() {
    return TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty) {
          return Constants.nameblank;
        } else if (value.trim().length >= 30) {
          return 'Name should not be more then 30 characters.';
        } else {
          return null;
        }
      },
      controller: refcode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLength: 29,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintStyle:
            TextStyle(fontFamily: FontFamily.OpenSansRegular, fontSize: 17),
        hintText: 'Refferal code(if any)',
        counterText: '',
        prefixIcon: IconButton(
          icon: SvgPicture.asset("assets/images/refer-bonus.svg"),
          iconSize: 22,
          onPressed: () {},
        ),

        // contentPadding: EdgeInsets.only(left: 0.0),
        border: _enableBorder,
        focusedBorder: _enableBorder,
        errorBorder: _enableBorder,
        focusedErrorBorder: _enableBorder,
        disabledBorder: _enableBorder,
        enabledBorder: _enableBorder,
        fillColor: Color.fromRGBO(70, 70, 90, 0.10).withOpacity(0.0),
        filled: true,
      ),
    );
  }

  // Number input field
  _numberInputField() {
    return TextFormField(
      validator: (value) {
        String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regExp = new RegExp(patttern);
        if (value!.length == 0) {
          return 'Please enter mobile number';
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter valid mobile number';
        }
        return null;
      },
      controller: emailorphone,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLength: 29,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintStyle:
            TextStyle(fontFamily: FontFamily.OpenSansRegular, fontSize: 17),
        hintText: 'Enter your Phone Number',
        counterText: '',
        prefixIcon: IconButton(
          icon: Image.asset(Imgs.phoneIcon),
          iconSize: 22,
          onPressed: () {},
        ),
        // contentPadding: EdgeInsets.only(left: 0.0),
        border: _enableBorder,
        focusedBorder: _enableBorder,
        errorBorder: _enableBorder,
        focusedErrorBorder: _enableBorder,
        disabledBorder: _enableBorder,
        enabledBorder: _enableBorder,
        fillColor: Color.fromRGBO(70, 70, 90, 0.10).withOpacity(0.0),
        filled: true,
      ),
    );
  }

  // already  signUp text
  _alreadySignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Constants.alreadySignUpText,
          style: TextStyle(
              color: AppColors.dark_grey,
              fontFamily: FontFamily.OpenSansRegular,
              fontWeight: FontWeight.w400,
              fontSize: Comman.displayWidth(context) * 0.045),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignIn_Screen()));
          },
          child: Text(
            '\t' + Constants.signInText,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: FontFamily.OpenSansRegular,
                fontWeight: FontWeight.w400,
                fontSize: Comman.displayWidth(context) * 0.045),
          ),
        ),
      ],
    );
  }

  // sign in button
  _signUpButton() {
    return MaterialButton(
      elevation: 5.0,
      color: AppColors.primaryColor,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(50),
      ),
      height: Comman.displayHeight(context) * 0.09,
      minWidth: Comman.displayWidth(context) * 1,
      onPressed: () async {
        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'https://homeshef-test.herokuapp.com/account/referred_by/'));
        request.fields.addAll({'ref_code': '9c74ed090aa7'});
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var request = http.Request('POST',
              Uri.parse('http://homeshef-test.herokuapp.com/account/sendotp/'));
          request.bodyFields = {'phone': emailorphone.text};
          http.StreamedResponse response1 = await request.send();
          var response = await http.Response.fromStream(response1);

          if (response1.statusCode == 201) {
            // var userdata = json.decode(response.body);
            final snackBar = SnackBar(
              content: Text('Otp Sent Successfully'),
              duration: Duration(seconds: 2),
            );
            await ScaffoldMessenger.of(context).showSnackBar(snackBar);
            await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      AppKnowledgeScreen1(phno: emailorphone.text),
                ));
            print(response.body);
          } else {
            if (response1.statusCode == 409) {
              final snackBar = SnackBar(content: Text('User Already Exist'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (response1.statusCode == 500) {
              final snackBar =
                  SnackBar(content: Text('Phone Number not valid'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            print(response1.reasonPhrase);
          }
          print("referral added");
        } else {
          print(response.reasonPhrase);
        }
      },
      child: Text(
        Constants.signUpText,
        style: TextStyle(
            color: AppColors.white,
            fontFamily: FontFamily.OpenSansRegular,
            fontWeight: FontWeight.w400,
            fontSize: Comman.displayWidth(context) * 0.06),
      ),
    );
  }

  var _disableBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.0,
    ),
  );

  var _enableBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
  );
}
