import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_chef/Screens/Kitchenname.dart';
import 'package:home_chef/constants.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/res.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:http/http.dart' as http;

class DetailFillPage extends StatefulWidget {
  final String phno;
  DetailFillPage({required this.phno});

  @override
  _DetailFillPageState createState() => _DetailFillPageState();
}

class _DetailFillPageState extends State<DetailFillPage> {
  String phno1 = '';
  bool texttype0 = true;
  bool texttype1 = true;
  TextEditingController? emailorphone;
  TextEditingController? password = TextEditingController();
  TextEditingController? confirmpassword = TextEditingController();
  TextEditingController? name = TextEditingController();
  TextEditingController? email = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  void initState() {
    phno1 = widget.phno;
    emailorphone = TextEditingController(text: widget.phno);
    super.initState();
  }

  void toggle() {
    setState(() {
      texttype0 = !texttype0;
    });
  }

  void toggle1() {
    setState(() {
      texttype1 = !texttype1;
    });
  }

  Future<void> requestgenerator(String text, String text2) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://homeshef-test.herokuapp.com/account/register/'));
    request.fields.addAll({
      'phone': text,
      'password': text2,
      'user_type': "vendor",
      'vendor': 'vendor'
    });
    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response1.statusCode == 200) {
      var userdata = json.decode(response.body) as Map<String, dynamic>;
      print(userdata['user']['id']);
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => KitchenName(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '    Register As a',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5397),
                height: 1.5,
              ),
            ),
            Text(
              '    Home Master Chef',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5397),
                height: 1.5,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _form,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 2,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
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
                                    hintStyle: TextStyle(
                                        fontFamily: FontFamily.OpenSansRegular,
                                        fontSize: 17),
                                    hintText: 'Enter mail ID or Phone number',
                                    counterText: '',

                                    prefixIcon: IconButton(
                                      icon:
                                          Image.asset('assets/imgs/phone.png'),
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
                                    // fillColor: Color.fromRGBO(70, 70, 90, 0.10)
                                    //     .withOpacity(0.0),
                                    // filled: true,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 15, left: 15, top: 15, bottom: 10),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return 'Empty';
                                    else if (!validateStructure(val)) {
                                      return 'Not Strong Enough';
                                    }
                                    return null;
                                  },
                                  controller: password,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 29,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontFamily: FontFamily.OpenSansRegular,
                                        fontSize: 17),
                                    hintText: 'Password',
                                    counterText: '',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.visibility,
                                        color: Color(0xFF4A5397),
                                      ),
                                      iconSize: 20,
                                      onPressed: () => toggle(),
                                    ),
                                    prefixIcon: IconButton(
                                      icon: Image.asset(Imgs.lockIcon),
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
                                    fillColor: Color.fromRGBO(70, 70, 90, 0.10)
                                        .withOpacity(0.0),
                                    filled: true,
                                  ),
                                  obscureText: texttype0,
                                ),
                              ),
                              Text(
                                'Minimum 6 characters A-Z, 0-9, !@#%^&*',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) return 'Empty';
                                    if (val != password!.text)
                                      return 'Not Match';
                                    return null;
                                  },
                                  controller: confirmpassword,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 29,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontFamily: FontFamily.OpenSansRegular,
                                        fontSize: 17),
                                    hintText: ' Confirm Password',
                                    counterText: '',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.visibility,
                                        color: Color(0xFF4A5397),
                                      ),
                                      iconSize: 20,
                                      onPressed: () => toggle1(),
                                    ),
                                    prefixIcon: IconButton(
                                      icon: Image.asset(Imgs.lockIcon),
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
                                    fillColor: Color.fromRGBO(70, 70, 90, 0.10)
                                        .withOpacity(0.0),
                                    filled: true,
                                  ),
                                  obscureText: texttype1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.circle_outlined,
                          color: Color(0xFF4A5397),
                        ),
                        Text(
                          'Accept Terms & Condition',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 15,
                              color: Color(0xFF4A5397)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: kPrimaryColor,
                        ),
                        child: TextButton(
                            child: Center(
                              child: Text(
                                'Save & Continue',
                                style: const TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            onPressed: () async {
                              if (_form.currentState!.validate()) {
                                _form.currentState!.save();
                                await requestgenerator(
                                    emailorphone!.text, password!.text);
                              }
                            }))
                  ]),
            )
          ],
        )));
  }

  // var _disableBorder = UnderlineInputBorder(
  //   borderSide: BorderSide(
  //     color: Colors.grey,
  //     width: 1.0,
  //   ),
  // );

  var _enableBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
  );
}
