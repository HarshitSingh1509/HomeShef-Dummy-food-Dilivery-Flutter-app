import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_chef/Screens/appknowledge_Screen2.dart';
import 'package:home_chef/utils/comman.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/customappbar.dart';
import 'package:home_chef/utils/theme.dart';

class AppKnowledgeScreen1 extends StatelessWidget {
  final String phno;
  AppKnowledgeScreen1({required this.phno});
  // final String token;
  // final String id;
  // final String phone;
  // final String type;
  // AppKnowledgeScreen1(
  //     {required this.token,
  //     required this.id,
  //     required this.phone,
  //     required this.type});

  @override
  Widget build(BuildContext context) {
    var appBar = Custom_App_Bar(isBackBtn: true, title: '');
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(16),
        height: Comman.displayHeight(context) * 1,
        width: Comman.displayWidth(context) * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _knowledgeLayout(context),
              Comman.sizeBoxheight(20),
              _nextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // knowledge layout
  _knowledgeLayout(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: Comman.displayHeight(context) * 0.7,
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
        child: Column(children: [
          Text(
            Constants.knowledgeText1,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: FontFamily.OpenSansRegular,
                fontWeight: FontWeight.w700,
                fontSize: Comman.displayWidth(context) * 0.05),
          ),
          Text(
            Constants.knowledgeText2,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: FontFamily.OpenSansRegular,
                fontWeight: FontWeight.w700,
                fontSize: Comman.displayWidth(context) * 0.05),
          ),
          Comman.sizeBoxheight(12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Constants.knowledgeText3,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w700,
                      fontSize: Comman.displayWidth(context) * 0.07),
                ),
                Text(
                  Constants.knowledgeText4,
                  style: TextStyle(
                      color: AppColors.black,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: Comman.displayWidth(context) * 0.055),
                ),
                Text(
                  Constants.knowledgeText5,
                  style: TextStyle(
                      color: AppColors.black,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: Comman.displayWidth(context) * 0.055),
                ),
                Text(
                  Constants.knowledgeText6,
                  style: TextStyle(
                      color: AppColors.black,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: Comman.displayWidth(context) * 0.055),
                ),
                Text(
                  Constants.knowledgeText7,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w700,
                      fontSize: Comman.displayWidth(context) * 0.07),
                ),
                Text(
                  Constants.knowledgeText8,
                  style: TextStyle(
                      color: AppColors.black,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: Comman.displayWidth(context) * 0.055),
                ),
                Text(
                  Constants.knowledgeText9,
                  style: TextStyle(
                      color: AppColors.black,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: Comman.displayWidth(context) * 0.055),
                ),
                Text(
                  Constants.knowledgeText10,
                  style: TextStyle(
                      color: AppColors.black,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: Comman.displayWidth(context) * 0.055),
                ),
                Text(
                  Constants.knowledgeText11,
                  style: TextStyle(
                      color: AppColors.black,
                      fontFamily: FontFamily.OpenSansRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: Comman.displayWidth(context) * 0.055),
                ),
              ],
            ),
          ),
        ]));
  }

  // Next in button
  _nextButton(BuildContext context) {
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppKnowledgeScreen2(
                      phno: phno,
                    )));
      },
      child: Text(
        Constants.nextText,
        style: TextStyle(
            color: AppColors.white,
            fontFamily: FontFamily.OpenSansRegular,
            fontWeight: FontWeight.w400,
            fontSize: Comman.displayWidth(context) * 0.06),
      ),
    );
  }
}
