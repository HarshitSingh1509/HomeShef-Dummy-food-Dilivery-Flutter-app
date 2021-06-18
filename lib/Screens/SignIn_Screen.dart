import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_chef/Screens/Kitchenname.dart';
import 'package:home_chef/Screens/Widgets/models/Kitchen.dart';
import 'package:home_chef/Screens/Widgets/models/kitchenaddress.dart';
import 'package:home_chef/Screens/Widgets/models/userdetail.dart';
import 'package:home_chef/Screens/appknowledge_screen1.dart';
import 'package:home_chef/Screens/locationpage.dart';
import 'package:home_chef/Screens/locationpageinitial.dart';
import 'package:home_chef/utils/comman.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/res.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Widgets/models/Category.dart';

class SignIn_Screen extends StatefulWidget {
  @override
  _SignIn_ScreenState createState() => _SignIn_ScreenState();
}

class _SignIn_ScreenState extends State<SignIn_Screen> {
  final emailorphone = TextEditingController();
  final password = TextEditingController();
  Future<void> signinreq(String emailorphone, String password) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://homeshef-test.herokuapp.com/account/login/'));
    request.fields.addAll(
        {'phone': emailorphone, 'password': password, 'vendor': 'vendor'});
    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response1.statusCode == 200) {
      var userdata = json.decode(response.body) as Map<String, dynamic>;

      Provider.of<UserDetail>(context, listen: false).setuserauth(
          token: userdata['token'].toString(),
          phone: userdata['user']['phone'],
          userid: userdata['user']['id'].toString());
      bool kitchenavailable = await Provider.of<Kitchen>(context, listen: false)
          .searchandsetkitchen(
              uid: userdata['user']['id'].toString(),
              token: userdata['token'].toString());
      var kitchendata = Provider.of<Kitchen>(context, listen: false).kitchenget;

      bool kitchenaddressstat =
          await Provider.of<KitchenAddress>(context, listen: false)
              .searchandsetkitchenaddress(
                  token: userdata['token'].toString(),
                  kitchen: kitchendata['id'].toString());

      var kitchenaddressdata =
          Provider.of<KitchenAddress>(context, listen: false).kitchenaddressget;

      kitchenavailable
          ? kitchenaddressstat
              ? Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => LocationPageInitial()),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => LocationPage()),
                )
          : Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => KitchenName()),
            );

// await Provider.of<KitchenAddress>(context, listen: false)
//               .searchandsetkitchenaddress(
//                   kitchen: kitchendata['id'],
//                   token: userdata['token'].toString()) ?
      // Navigator.push(
      //   context,
      //   MaterialPageRoute<void>(
      //       builder: (BuildContext context) => LocationPage(
      //           phno: emailorphone,
      //           id: userdata['user']['id'].toString(),
      //           token: userdata['token'],
      //           phone: userdata['user']['phone'],
      //           type: userdata['user']['type'])),
      //   );
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Kitchen>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Comman.sizeBoxheight(150),
                  _signInText(),
                  Comman.sizeBoxheight(20),
                  _signInPasswordLayout(),
                  Comman.sizeBoxheight(30),
                  _signInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // SignIn text
  _signInText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        Constants.signInText,
        style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: FontFamily.OpenSansRegular,
            fontWeight: FontWeight.w700,
            fontSize: Comman.displayWidth(context) * 0.07),
      ),
    );
  }

  // Enter mail id or input phone number / Password Layout
  _signInPasswordLayout() {
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
          Comman.sizeBoxheight(10),
          _mailAndPhoneNumberInputField(),
          Comman.sizeBoxheight(25),
          _passwordInputField(),
          Comman.sizeBoxheight(10),
          _forgotPassText(),
        ],
      ),
    );
  }

  // mail and phone number input field
  _mailAndPhoneNumberInputField() {
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
      controller: emailorphone,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLength: 29,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintStyle:
            TextStyle(fontFamily: FontFamily.OpenSansRegular, fontSize: 17),
        hintText: 'Enter mail ID or Phone number',
        counterText: '',
        prefixIcon: IconButton(
          icon: Image.asset(Imgs.userIcon),
          iconSize: 20,
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

  // password input field
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
      controller: password,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLength: 29,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintStyle:
            TextStyle(fontFamily: FontFamily.OpenSansRegular, fontSize: 17),
        hintText: 'Password',
        counterText: '',
        prefixIcon: IconButton(
          icon: Image.asset(Imgs.lockIcon),
          iconSize: 22,
          onPressed: () {},
        ),
        suffixIcon: IconButton(
          icon: Image.asset(
            Imgs.lockOpenIcon,
            height: 20,
          ),
          onPressed: () {},
          iconSize: 18,
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

  // forgot text
  _forgotPassText() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        Constants.forgotPassText,
        style: TextStyle(
            color: AppColors.dark_grey,
            fontFamily: FontFamily.OpenSansRegular,
            fontWeight: FontWeight.w400,
            fontSize: Comman.displayWidth(context) * 0.04),
      ),
    );
  }

  // sign in button
  _signInButton() {
    return MaterialButton(
      elevation: 5.0,
      color: AppColors.primaryColor,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(50),
      ),
      height: Comman.displayHeight(context) * 0.09,
      minWidth: Comman.displayWidth(context) * 1,
      onPressed: () {
        signinreq(emailorphone.text, password.text);
      },
      child: Text(
        Constants.signInText,
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
