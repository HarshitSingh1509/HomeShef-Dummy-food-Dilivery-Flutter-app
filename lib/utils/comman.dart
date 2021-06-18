import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'theme.dart';

class Comman {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final addressCtrl = TextEditingController();
  late double latti, longgti;
  late String getAddress;

  //Sizebox for width
  static Widget sizeBoxwidth(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Widget sizeBoxheight(double height) {
    return SizedBox(
      height: height,
    );
  }

  static Size displaySize(BuildContext context) {
    //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    // debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  static double displayWidth(BuildContext context) {
    //debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  static Widget divider(Color color, double size) {
    return Divider(
      thickness: size,
      color: color,
    );
  }

  static removeFocus(BuildContext ctx) {
    //removeFocus
    FocusScopeNode currentFocus = FocusScope.of(ctx);
    //hasPrimaryFocus is necessary to prevent Flutter from
    // throwing an exception when trying to unfocus the node at the top of the tree
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  //hide keyboard
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Widget noitemfound_error() {
    return Center(
      child: new Text(
        'No Items Found.',
        style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'SFUI-Display-Regular',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  //Show Snakbar without key
  static showSnakbar(
      String message, BuildContext context, Color backgroundColor) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: backgroundColor,
        content: new Text(
          message,
          style: const TextStyle(
            fontFamily: 'SFUI-Display-Regular',
            fontSize: 16.0,
            color: Colors.white,
          ),
        )));
  }

  //show snakbar with global key
  static showSnakBarwithkey(
      String message, GlobalKey<ScaffoldState> _key, Color backgroundColor) {
//    _key.currentState.hideCurrentSnackBar();
    _key.currentState!.showSnackBar(new SnackBar(
      backgroundColor: backgroundColor,
      content: new Text(message,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: 'SFUI-Display-Regular',
          )),
      duration: Duration(seconds: 2),
    ));
  }

  //Loading indicator
  static Widget loadingIndicator(Color color) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Container(
            height: 25.0,
            width: 25.0,
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      color,
                    ),
                  ),
          )),
        ]);
  }

  //Show Dialog Popup
  static Future<void> show_dialog(BuildContext context, String message) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Platform.isIOS
              ? CupertinoAlertDialog(
                  title: Text('Alert',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold)),
                  content: Text(message),
                  actions: <Widget>[
                    Center(
                      child: FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                )
              : AlertDialog(
                  title: Text('Alert',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold)),
                  content: Text(message),
                  actions: <Widget>[
                    Center(
                      child: FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                );
        });
  }

  //get Device tyep
  static String getdeviceType() {
    return Platform.isIOS ? Constants.Ios : Constants.Android;
  }

  //Show loading dialog
  static showLoading(BuildContext ctx) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.15,
          //margin: const EdgeInsets.only(top: 100.0),
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor),
                          strokeWidth: 2.0,
                        ),
                  /*Platform.isAndroid
                      ? */
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                      Constants.pleasewaitTxt,
                      style: new TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  )
//                      : SizedBox(),
                ]),
          ),
        ));
      },
    );
  }

  //Hide loading dialog
  static hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
