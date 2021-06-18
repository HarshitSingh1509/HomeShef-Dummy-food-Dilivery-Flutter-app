import 'package:flutter/material.dart';
import 'package:home_chef/Screens/InformationPage.dart';
import 'package:home_chef/Screens/Widgets/Button.dart';
import 'package:home_chef/Screens/Widgets/models/Kitchen.dart';
import 'package:home_chef/Screens/otpvalidation.dart';
import 'package:home_chef/constants.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Widgets/models/userdetail.dart';

class LocationPage extends StatefulWidget {
  // final String phno;
  // final String token;
  // final String id;
  // final String phone;
  // final String type;
  // LocationPage(
  //     {required this.phno,
  //     required this.token,
  //     required this.id,
  //     required this.phone,
  //     required this.type});
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _formKey = GlobalKey<FormState>();
  final emailorphone = TextEditingController();
  final kitchenname = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final pincode = TextEditingController();
  final country = TextEditingController();
  final house = TextEditingController();
  final landmark = TextEditingController();
  bool enable = true;
  String? token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Kitchen>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Address',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const InformationPage(),
                      ),
                    ),
                child: Text(
                  'SKIP',
                  style: TextStyle(fontSize: 20, color: Color(0xFF4A5397)),
                ))
          ],
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                padding: EdgeInsets.all(25),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xFF4A5397),
                        ),
                        Text(
                          'Locate Address on Map',
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 20,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Or Enter Manually',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 2,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 25, right: 25),
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
                                        controller: address,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        maxLength: 29,
                                        style: TextStyle(color: Colors.black),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  FontFamily.OpenSansRegular,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          hintText: 'Adress Line 1 and 2',
                                          counterText: '',

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
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 25, right: 25),
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
                                        controller: city,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        maxLength: 29,
                                        style: TextStyle(color: Colors.black),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  FontFamily.OpenSansRegular,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          hintText: 'City',
                                          counterText: '',

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
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 110,
                                          padding: EdgeInsets.only(
                                              left: 25, right: 10),
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
                                            controller: state,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            maxLength: 29,
                                            style:
                                                TextStyle(color: Colors.black),
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: FontFamily
                                                      .OpenSansRegular,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              hintText: 'State',
                                              counterText: '',

                                              // contentPadding: EdgeInsets.only(left: 0.0),
                                              border: _enableBorder,
                                              focusedBorder: _enableBorder,
                                              errorBorder: _enableBorder,
                                              focusedErrorBorder: _enableBorder,
                                              disabledBorder: _enableBorder,
                                              enabledBorder: _enableBorder,
                                              fillColor: Color.fromRGBO(
                                                      70, 70, 90, 0.10)
                                                  .withOpacity(0.0),
                                              filled: true,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 110,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
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
                                            controller: pincode,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            maxLength: 29,
                                            style:
                                                TextStyle(color: Colors.black),
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: FontFamily
                                                      .OpenSansRegular,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              hintText: 'Postal Code',
                                              counterText: '',

                                              // contentPadding: EdgeInsets.only(left: 0.0),
                                              border: _enableBorder,
                                              focusedBorder: _enableBorder,
                                              errorBorder: _enableBorder,
                                              focusedErrorBorder: _enableBorder,
                                              disabledBorder: _enableBorder,
                                              enabledBorder: _enableBorder,
                                              fillColor: Color.fromRGBO(
                                                      70, 70, 90, 0.10)
                                                  .withOpacity(0.0),
                                              filled: true,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 110,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 25),
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
                                            controller: country,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            maxLength: 29,
                                            style:
                                                TextStyle(color: Colors.black),
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: FontFamily
                                                      .OpenSansRegular,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              hintText: 'Country',
                                              counterText: '',

                                              // contentPadding: EdgeInsets.only(left: 0.0),
                                              border: _enableBorder,
                                              focusedBorder: _enableBorder,
                                              errorBorder: _enableBorder,
                                              focusedErrorBorder: _enableBorder,
                                              disabledBorder: _enableBorder,
                                              enabledBorder: _enableBorder,
                                              fillColor: Color.fromRGBO(
                                                      70, 70, 90, 0.10)
                                                  .withOpacity(0.0),
                                              filled: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            elevation: 2,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 25, right: 25),
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
                                      controller: house,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 29,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily:
                                                FontFamily.OpenSansRegular,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        hintText:
                                            '   House/Flat Number/ Street',
                                        counterText: '',

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
                                    padding:
                                        EdgeInsets.only(left: 25, right: 25),
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
                                      controller: landmark,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 29,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily:
                                                FontFamily.OpenSansRegular,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        hintText: 'LandMark/Society/Sector',
                                        counterText: '',

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
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ])),
              ),
              SizedBox(
                height: 20,
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
                          if (_formKey.currentState!.validate()) {
                            Map<String, String> userdetail =
                                Provider.of<UserDetail>(context, listen: false)
                                    .userget;
                            Map<String, String?> kitchen =
                                Provider.of<Kitchen>(context, listen: false)
                                    .kitchenget;
                            token = userdetail['token'];
                            String kitchennametxt = kitchenname.text;
                            var headers = {
                              'Authorization': 'Token $token',
                            };
                            print(kitchen['id']);
                            var request = http.MultipartRequest(
                                'POST',
                                Uri.parse(
                                    'http://homeshef-test.herokuapp.com/home-kitchen/kitchenaddress/'));
                            request.fields.addAll({
                              'pincode': pincode.text,
                              'complete_address': address.text,
                              'city': city.text,
                              // 'area': house.text + landmark.text,
                              'kitchen': kitchen['id'] ?? '',
                            });

                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();
                            print(token);
                            if (response.statusCode == 201) {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      InformationPage(),
                                ),
                              );
                              print(await response.stream.bytesToString());
                            } else {
                              print(response.reasonPhrase);
                            }
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
