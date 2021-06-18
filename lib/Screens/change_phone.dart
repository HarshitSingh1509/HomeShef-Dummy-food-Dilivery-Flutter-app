import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:home_chef/Screens/otpvalidationnewphone.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Widgets/models/userdetail.dart';

class ChangePhone extends StatefulWidget {
  const ChangePhone({Key? key}) : super(key: key);

  @override
  _ChangePhoneState createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#DDDFEC"),
        appBar: AppBar(
          backgroundColor: HexColor("#DDDFEC"),
          title: const Text(
            "Account",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          centerTitle: true,
          actions: <Widget>[
            PopupButton1(),
            Padding(padding: EdgeInsets.all(10)),
            PopupButton2(),
            Padding(padding: EdgeInsets.all(10))
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Change Phone",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(children: <Widget>[
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return Constants.nameblank;
                                              } else if (value.trim().length >=
                                                  30) {
                                                return 'Name should not be more then 30 characters.';
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: phoneController,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            maxLength: 29,
                                            style:
                                                TextStyle(color: Colors.black),
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontFamily: FontFamily
                                                      .OpenSansRegular,
                                                  fontSize: 17),
                                              hintText: 'Current Phone',
                                              counterText: '',

                                              prefixIcon: IconButton(
                                                icon: Image.asset(
                                                    'assets/imgs/phone.png'),
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

                                        // ignore: avoid_unnecessary_containers
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return Constants.nameblank;
                                              } else if (value.trim().length >=
                                                  30) {
                                                return 'Name should not be more then 30 characters.';
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: phoneController1,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            maxLength: 29,
                                            style:
                                                TextStyle(color: Colors.black),
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontFamily: FontFamily
                                                      .OpenSansRegular,
                                                  fontSize: 17),
                                              hintText: 'New Phone',
                                              counterText: '',

                                              prefixIcon: IconButton(
                                                icon: Image.asset(
                                                    'assets/imgs/phone.png'),
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ]),
                          ])),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.07,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            color: HexColor("#4A5397"),
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var user = Provider.of<UserDetail>(context,
                                        listen: false)
                                    .userget;
                                String? token = user['token'];
                                String? id = user['id'];
                                var headers = {
                                  'Authorization': 'Token $token',
                                };
                                var request = http.MultipartRequest(
                                    'POST',
                                    Uri.parse(
                                        'http://homeshef-test.herokuapp.com/account/user/$id/changephoneotp/'));
                                request.fields.addAll(
                                    {'new_phone': phoneController1.text});

                                request.headers.addAll(headers);

                                http.StreamedResponse response =
                                    await request.send();

                                if (response.statusCode == 200) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          OtpScreenNewScreen(
                                        phoneNumber: phoneController1.text,
                                      ),
                                    ),
                                  );
                                  print(await response.stream.bytesToString());
                                } else {
                                  print(response.reasonPhrase);
                                }
                              }
                            },
                            child: const Text(
                              "Save",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ])),
          ),
        ));
  }

  var _enableBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
  );
}
