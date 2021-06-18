import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_chef/Screens/otpvalidation.dart';
import 'package:home_chef/utils/comman.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/customappbar.dart';
import 'package:home_chef/utils/theme.dart';

class AppKnowledgeScreen2 extends StatelessWidget {
  final String phno;
  AppKnowledgeScreen2({required this.phno});
  @override
  Widget build(BuildContext context) {
    var appBar = Custom_App_Bar(isBackBtn: true, title: '');
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(16),
        height: Comman.displayHeight(context) * 1,
        width: Comman.displayWidth(context) * 1,
        child: Column(
          children: [
            _knowledgeLayout(context),
            Comman.sizeBoxheight(20),
            _nextButton(context),
          ],
        ),
      ),
    );
  }

  // knowledge layout
  _knowledgeLayout(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Constants.knowledgeText12,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: FontFamily.OpenSansRegular,
                    fontWeight: FontWeight.w700,
                    fontSize: Comman.displayWidth(context) * 0.07),
              ),
              Text(
                Constants.knowledgeText13,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.black,
                    fontFamily: FontFamily.OpenSansRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: Comman.displayWidth(context) * 0.055),
              ),
              Text(
                Constants.knowledgeText14,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.black,
                    fontFamily: FontFamily.OpenSansRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: Comman.displayWidth(context) * 0.055),
              ),
              Text(
                Constants.knowledgeText15,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.black,
                    fontFamily: FontFamily.OpenSansRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: Comman.displayWidth(context) * 0.055),
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
            MaterialPageRoute<void>(
              builder: (BuildContext context) => OtpScreen(
                phoneNumber: phno,
              ),
            ));
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
