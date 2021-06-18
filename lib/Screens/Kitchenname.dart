import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_chef/Screens/InformationPage.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:home_chef/Screens/locationpage.dart';
import 'package:home_chef/constants.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/res.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Widgets/models/Kitchen.dart';
import 'Widgets/models/userdetail.dart';

class KitchenName extends StatefulWidget {
  const KitchenName({Key? key}) : super(key: key);

  @override
  _KitchenNameState createState() => _KitchenNameState();
}

class _KitchenNameState extends State<KitchenName> {
  String phno1 = '';
  bool texttype0 = true;
  bool texttype1 = true;
  final kitchenname = TextEditingController();
  final aboutkitchen = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String? token = '';
  String? phno = '';
  String? id = '';
  String? phone = '';
  String? type = '';
  @override
  void initState() {
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

  // Future<void> requestgenerator(String text, String text2) async {
  //   Map<String, String> userdetail =
  //       Provider.of<UserDetail>(context, listen: false).userget;
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('http://homeshef-test.herokuapp.com/account/login/'));
  //   request.fields.addAll({'phone': text, 'password': text2});
  //   http.StreamedResponse response1 = await request.send();
  //   var response = await http.Response.fromStream(response1);

  //   if (response1.statusCode == 200) {
  //     var userdata = json.decode(response.body) as Map<String, dynamic>;
  //     print(userdata['user']['id']);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute<void>(
  //         builder: (BuildContext context) => LocationPage(
  //             phno: text,
  //             id: userdata['user']['id'].toString(),
  //             token: userdata['token'],
  //             phone: userdata['user']['phone'],
  //             type: userdata['user']['type']),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<Kitchen>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          actions: <Widget>[
            PopupButton1(),
            Padding(padding: EdgeInsets.all(10)),
            PopupButton2(),
            Padding(padding: EdgeInsets.all(10))
          ],
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                            iconSize: 35,
                            highlightColor: Colors.grey,
                            autofocus: true,
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ))),
                    Positioned(
                        bottom: 11,
                        right: 11,
                        child: IconButton(
                            iconSize: 35,
                            highlightColor: Colors.grey,
                            autofocus: true,
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black12,
                            )))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(25),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 2,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25, right: 25),
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
                          controller: kitchenname,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 29,
                          style: TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamily.OpenSansRegular,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            hintText: 'Name of Kitchen',
                            counterText: '',

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
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25, right: 25),
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
                          controller: aboutkitchen,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 29,
                          style: TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamily.OpenSansRegular,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            hintText: 'About Kitchen',
                            counterText: '',

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
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]))),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Container(
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
                          Map<String, String> userdetail =
                              Provider.of<UserDetail>(context, listen: false)
                                  .userget;
                          token = userdetail['token'];
                          print('$token');
                          String kitchennametxt = kitchenname.text;
                          String aboutchickentxt = aboutkitchen.text;
                          var headers = {'Authorization': 'Token $token'};
                          var request = http.MultipartRequest(
                              'POST',
                              Uri.parse(
                                  'http://homeshef-test.herokuapp.com/home-kitchen/kitchen/'));
                          request.fields.addAll({
                            'kitchen_name': '$kitchennametxt',
                            'about': '$aboutchickentxt'
                          });

                          request.headers.addAll(headers);

                          http.StreamedResponse response1 =
                              await request.send();
                          var response =
                              await http.Response.fromStream(response1);
                          if (response.statusCode == 201) {
                            var kitchen = json.decode(response.body)
                                as Map<String, dynamic>;
                            //  var kitchen = response.body;
                            Provider.of<Kitchen>(context, listen: false)
                                .setkitchenid(
                                    about: aboutchickentxt,
                                    kitchenid: kitchen['id'].toString(),
                                    name: kitchennametxt,
                                    userid: kitchen['user'].toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    LocationPage(),
                              ),
                            );
                          } else {
                            print(response.reasonPhrase);
                          }
                        }),
                  ))
            ])));
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
