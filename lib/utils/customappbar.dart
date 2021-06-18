import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:home_chef/utils/theme.dart';

class Custom_App_Bar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool isBackBtn;

  Custom_App_Bar({
    required this.isBackBtn,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: AppColors.white,
        elevation: 8.0,
        centerTitle: true,
        leading: isBackBtn
            ? IconButton(
                onPressed: () {
                  _focusRemove(context);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                ),
              )
            : SizedBox(),
        title: Text(
          title,
          style: _titlTextStyle(context),
        ),
      ),
    );
  }

  _titlTextStyle(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontFamily: FontFamily.OpenSansRegular,
      fontWeight: FontWeight.w500,
      fontSize: MediaQuery.of(context).size.height * 0.025,
    );
  }

  TextStyle clearAll = const TextStyle(
    color: AppColors.black,
    fontFamily: FontFamily.OpenSansRegular,
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  );
  //removeFocus
  _focusRemove(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    //hasPrimaryFocus is necessary to prevent Flutter from
    // throwing an exception when trying to unfocus the node at the top of the tree
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(55);
}
