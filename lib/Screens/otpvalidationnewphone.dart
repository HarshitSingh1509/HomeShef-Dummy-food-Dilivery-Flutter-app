import 'package:flutter/material.dart';
import 'package:home_chef/Screens/detailfillpage.dart';
import 'package:home_chef/Screens/locationpage.dart';
import 'package:home_chef/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../Screens/Widgets/TextFieldOtp.dart';
import '../size.dart';
import 'package:http/http.dart' as http;

import 'SignUp_Screen.dart';
import 'Widgets/models/userdetail.dart';

class OtpScreenNewScreen extends StatefulWidget {
  OtpScreenNewScreen({required this.phoneNumber});
  final String phoneNumber;
  static final routeName = '/routeName';
  @override
  _OtpScreenNewScreenState createState() => _OtpScreenNewScreenState();
}

class _OtpScreenNewScreenState extends State<OtpScreenNewScreen> {
  String verificationCode = "";
  String phno = '';
  String input1 = '';
  String input2 = '';
  String input3 = '';
  String input4 = '';

  final _input1 = FocusNode();
  final _input2 = FocusNode();
  final _input3 = FocusNode();
  final _input4 = FocusNode();
  @override
  void initState() {
    phno = widget.phoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    _input1.dispose();
    _input2.dispose();
    _input3.dispose();
    _input4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter',
                  style: headingStyle,
                ),
                Text(
                  'OTP',
                  style: headingStyle,
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You will shortly receive a message on ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '  ${widget.phoneNumber}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' with a code to proceed.',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 80,
                        width: 200,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFieldOtp(
                                focusNodeP: _input1,
                                focusNodeN: _input2,
                                onChanged: (v) {
                                  input1 = v;
                                  if (v.length == 1) {
                                    FocusScope.of(context)
                                        .requestFocus(_input2);
                                  }
                                },
                              ),
                              TextFieldOtp(
                                focusNodeP: _input2,
                                focusNodeN: _input3,
                                onChanged: (v) {
                                  input2 = v;
                                  if (v.length == 1) {
                                    FocusScope.of(context)
                                        .requestFocus(_input3);
                                  }
                                  if (v.length == 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                              ),
                              TextFieldOtp(
                                focusNodeP: _input3,
                                focusNodeN: _input4,
                                onChanged: (v) {
                                  input3 = v;
                                  if (v.length == 1) {
                                    FocusScope.of(context)
                                        .requestFocus(_input4);
                                  }
                                  if (v.length == 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                              ),
                              TextFieldOtp(
                                focusNodeP: _input4,
                                onChanged: (v) {
                                  input4 = v;

                                  if (v.length == 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectableText(
                            'Clear',
                            style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: kPrimaryColor,
                    ),
                    child: TextButton(
                        child: Center(
                          child: Text(
                            'Continue',
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        onPressed: () async {
                          if (input1 == null &&
                              input2 == null &&
                              input3 == null &&
                              input4 == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Enter code correctly',
                                style: TextStyle(fontSize: 15),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            String otp = input1 + input2 + input3 + input4;
                            print(otp);
                            print(phno);

                            var user =
                                Provider.of<UserDetail>(context, listen: false)
                                    .userget;
                            String? token = user['token'];
                            String id = user['userid'].toString();
                            print(id);
                            var headers = {
                              'Authorization': 'Token $token',
                            };
                            var request = http.MultipartRequest(
                                'PUT',
                                Uri.parse(
                                    'https://homeshef-test.herokuapp.com/account/user/$id/'));
                            request.fields
                                .addAll({'otp': otp, 'new_phone': phno});

                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();

                            if (response.statusCode == 200) {
                              pushNewScreenWithRouteSettings(context,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                  withNavBar: false,
                                  screen: SignUp_Screen(),
                                  settings: RouteSettings(
                                      name: '/', arguments: null));

                              print(await response.stream.bytesToString());
                            } else {
                              final snackBar = SnackBar(
                                content: Text('Invalid Otp'),
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              print(response.reasonPhrase);
                            }
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SelectableText(
                    'Resend OTP',
                    style: bold18primary,
                    onTap: () async {
                      var request = http.Request(
                          'POST',
                          Uri.parse(
                              'http://homeshef-test.herokuapp.com/account/sendotp/'));
                      request.bodyFields = {'phone': phno};
                      http.StreamedResponse response1 = await request.send();
                      var response = await http.Response.fromStream(response1);

                      if (response1.statusCode == 201) {
                        // var userdata = json.decode(response.body);
                        final snackBar = SnackBar(
                          content: Text('Otp Sent Successfully'),
                          duration: Duration(seconds: 2),
                        );
                        await ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget));
                        print(response.body);
                      } else {
                        if (response1.statusCode == 409) {
                          final snackBar =
                              SnackBar(content: Text('User Already Exist'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (response1.statusCode == 500) {
                          final snackBar =
                              SnackBar(content: Text('Phone Number not valid'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        print(response1.reasonPhrase);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
