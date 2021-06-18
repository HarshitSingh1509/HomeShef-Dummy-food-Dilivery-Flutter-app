import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_chef/Screens/SignUp_Screen.dart';
import 'package:home_chef/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SignUp_Screen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            child: Image.asset("assets/new logo.png"),
          ),
          Column(
            children: [
              Text(
                'Home food made',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A5397)),
              ),
              Text('by Home Chefs',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A5397))),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(15),
                height: 3,
                width: 70,
                color: Color(0xFF4A5397),
              )
            ],
          )
        ],
      )),
    );
  }
}
