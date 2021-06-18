import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/Widgets/models/userdetail.dart';
import 'package:home_chef/Screens/change_phone.dart';
import 'package:home_chef/constants.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/res.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  bool texttype0 = true;
  bool texttype1 = true;
  var phoneController;
  TextEditingController passWordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // bool validateStructure(String value) {
  //   String pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  //   RegExp regExp = new RegExp(pattern);
  //   return regExp.hasMatch(value);
  // }

  @override
  void initState() {
    var userdata = Provider.of<UserDetail>(context, listen: false).userget;
    phoneController = TextEditingController(text: userdata['phone']);
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetail>(context);
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
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Setting",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Card(
                          color: Colors.transparent,
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
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
                                      controller: phoneController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 29,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontFamily:
                                                FontFamily.OpenSansRegular,
                                            fontSize: 17),
                                        hintText: 'Phone Number',
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
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 15,
                                        left: 15,
                                        top: 0,
                                        bottom: 10),
                                    child: TextFormField(
                                      validator: (val) {
                                        if (val!.isEmpty) return 'Empty';
                                        // else if (!validateStructure(val)) {
                                        //   return 'Not Strong Enough';
                                        // }
                                        return null;
                                      },
                                      controller: passWordController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 29,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontFamily:
                                                FontFamily.OpenSansRegular,
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
                                        fillColor:
                                            Color.fromRGBO(70, 70, 90, 0.10)
                                                .withOpacity(0.0),
                                        filled: true,
                                      ),
                                      obscureText: texttype0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 15,
                                        left: 15,
                                        top: 10,
                                        bottom: 10),
                                    child: TextFormField(
                                      validator: (val) {
                                        if (val!.isEmpty) return 'Empty';
                                        // if (val != passWordController.text)
                                        //   return 'Not Match';
                                        return null;
                                      },
                                      controller: confirmController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 29,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontFamily:
                                                FontFamily.OpenSansRegular,
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
                                        fillColor:
                                            Color.fromRGBO(70, 70, 90, 0.10)
                                                .withOpacity(0.0),
                                        filled: true,
                                      ),
                                      obscureText: texttype1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ]),
                              ))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                          ),
                          child: TextButton(
                              child: Center(
                                child: Text(
                                  'Change Phone',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 25,
                                      color: HexColor("#4A5397"),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const ChangePhone(),
                                  ),
                                );
                              })),
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: kPrimaryColor,
                        ),
                        child: TextButton(
                            child: Center(
                              child: Text(
                                'Save',
                                style: const TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String? token = Provider.of<UserDetail>(context,
                                        listen: false)
                                    .userget['token'];
                                var headers = {
                                  'Authorization': 'Token $token',
                                };
                                var request = http.MultipartRequest(
                                    'PUT',
                                    Uri.parse(
                                        'http://homeshef-test.herokuapp.com/account/change-password/'));
                                request.fields.addAll({
                                  'old_password': passWordController.text,
                                  'new_password': confirmController.text
                                });

                                request.headers.addAll(headers);

                                http.StreamedResponse response =
                                    await request.send();

                                if (response.statusCode == 200) {
                                  print(await response.stream.bytesToString());
                                } else {
                                  print(response.reasonPhrase);
                                }
                              }
                            }),
                      )
                    ]),
                  ])),
        ));
  }

  var _enableBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
  );
}
