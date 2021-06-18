import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'Widgets/models/Kitchen.dart';
import 'Widgets/models/kitchenaddress.dart';
import 'Widgets/models/userdetail.dart';
import 'package:http/http.dart' as http;

class KitchenProfile extends StatefulWidget {
  const KitchenProfile({Key? key}) : super(key: key);

  @override
  _KitchenProfileState createState() => _KitchenProfileState();
}

class _KitchenProfileState extends State<KitchenProfile> {
  Object? value;
  int? selectedRadio;

  get end => null;
  @override
  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }

  final _formKey = GlobalKey<FormState>();

  String token = '';
  var kitchenNameController;
  var kitchenAboutController;
  var address;
  TextEditingController freeController = TextEditingController();
  TextEditingController percentage1Controller = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  void initState() {
    var kitchenaddressdata =
        Provider.of<KitchenAddress>(context, listen: false).kitchenaddressget;
    var kitchendata = Provider.of<Kitchen>(context, listen: false).kitchenget;
    print(kitchendata);
    kitchenNameController = TextEditingController(text: kitchendata['name']);
    address = TextEditingController(text: kitchenaddressdata['address']);
    kitchenAboutController = TextEditingController(text: kitchendata['about']);
    selectedRadio = 0;
    super.initState();
  }

  File? _image;
  final picker = ImagePicker();
  var colour = Colors.white;
  Future imagefromcamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future imagefromgallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () {
                    imagefromgallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imagefromcamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  TimeOfDay starttime = TimeOfDay.now();
  TimeOfDay? pickedStart;
  TimeOfDay endTime = TimeOfDay(hour: 21, minute: 00);
  TimeOfDay? pickedEnd;
  selectStartTime(BuildContext context) async {
    pickedStart =
        (await showTimePicker(context: context, initialTime: starttime))!;
    setState(() {
      starttime = pickedStart!;
    });
  }

  selectEndTime(BuildContext context) async {
    pickedEnd = (await showTimePicker(context: context, initialTime: endTime))!;
    setState(() {
      endTime = pickedEnd!;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    var kitchenaddressdata =
        Provider.of<KitchenAddress>(context, listen: false).kitchenaddressget;
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kitchen Profile",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _image!,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Stack(
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                  Positioned(
                                      bottom: -7,
                                      right: -7,
                                      child: IconButton(
                                          iconSize: 25,
                                          highlightColor: Colors.grey,
                                          autofocus: true,
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                          ))),
                                  Positioned(
                                      bottom: -6,
                                      right: -6,
                                      child: IconButton(
                                          iconSize: 25,
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
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child: Text(
                      "Kitchen Photo",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      // height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              child: TextField(
                                controller: kitchenNameController,
                                decoration: const InputDecoration(
                                  hintText: "Kitchen Name",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                controller: kitchenAboutController,
                                decoration: const InputDecoration(
                                  hintText: "About Kitchen",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                controller: address,
                                decoration: const InputDecoration(
                                  hintText: "Kitchen Address",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              child: Text(
                                "Kitchen Timing",
                                style: TextStyle(
                                    color: HexColor("#4A5397"), fontSize: 18),
                              ),
                            ),
                            Container(
                              height: 30,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "From",
                                      style:
                                          TextStyle(color: HexColor("#4A5397")),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: HexColor("#4A5397"),
                                              width: 2)),
                                      color: Colors.white,
                                      onPressed: () {
                                        selectStartTime(context);
                                      },
                                      child: Text(
                                          "${starttime.hour} : ${starttime.minute}"),
                                    ),
                                    Text(
                                      "To",
                                      style:
                                          TextStyle(color: HexColor("#4A5397")),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: HexColor("#4A5397"),
                                              width: 2)),
                                      color: Colors.white,
                                      onPressed: () {
                                        selectEndTime(context);
                                      },
                                      child: Text(
                                          "${endTime.hour} : ${endTime.minute}"),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 30,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "From",
                                      style:
                                          TextStyle(color: HexColor("#4A5397")),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: HexColor("#4A5397"),
                                              width: 2)),
                                      color: Colors.white,
                                      onPressed: () {
                                        selectStartTime(context);
                                      },
                                      child: Text(
                                          "${starttime.hour} : ${starttime.minute}"),
                                    ),
                                    Text(
                                      "To",
                                      style:
                                          TextStyle(color: HexColor("#4A5397")),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: HexColor("#4A5397"),
                                              width: 2)),
                                      color: Colors.white,
                                      onPressed: () {
                                        selectEndTime(context);
                                      },
                                      child: Text(
                                          "${endTime.hour} : ${endTime.minute}"),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Type of Delivery",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Radio(
                                      fillColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor("#4A5397")),
                                      value: 3,
                                      groupValue: selectedRadio,
                                      onChanged: (val) {
                                        setSelectedRadio(val);
                                      }),
                                  const Text("Delivery"),
                                  Radio(
                                      fillColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor("#4A5397")),
                                      value: 1,
                                      groupValue: selectedRadio,
                                      onChanged: (val) {
                                        setSelectedRadio(val);
                                      }),
                                  const Text("Takeaway"),
                                  Radio(
                                      fillColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor("#4A5397")),
                                      value: 2,
                                      groupValue: selectedRadio,
                                      onChanged: (val) {
                                        setSelectedRadio(val);
                                      }),
                                  const Text("Both")
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Set Discount",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Free Delivery on order worth "),
                                  SizedBox(width: 15),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/rupee.svg",
                                        height: 20,
                                        color: HexColor("#4A5397"),
                                      ),
                                      Container(
                                        width: 70,
                                        height: 30,
                                        child: TextField(
                                          //  controller: kitchenNameController,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF4A5397),
                                                    width: 2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            hintText: "1000.00",
                                            hintStyle: TextStyle(
                                                inherit: true,
                                                fontSize: 10,
                                                color: Color(0xFF4A5397),
                                                fontWeight: FontWeight.bold),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // ignore: sized_box_for_whitespace
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      // ignore: sized_box_for_whitespace
                                      Container(
                                        width: 40,
                                        height: 30,
                                        child: TextField(
                                          //   controller: kitchenNameController,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF4A5397),
                                                    width: 2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            hintText: "05",
                                            hintStyle: TextStyle(
                                                inherit: true,
                                                fontSize: 10,
                                                color: Color(0xFF4A5397),
                                                fontWeight: FontWeight.bold),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          "%",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: HexColor("#4A5397")),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  const Text("Off on order worth "),
                                  SizedBox(width: 15),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/rupee.svg",
                                        height: 20,
                                        color: HexColor("#4A5397"),
                                      ),
                                      // ignore: sized_box_for_whitespace
                                      Container(
                                        width: 70,
                                        height: 30,
                                        child: TextField(
                                          //  controller: kitchenNameController,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF4A5397),
                                                    width: 2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            hintText: "1500.00",
                                            hintStyle: TextStyle(
                                                inherit: true,
                                                fontSize: 10,
                                                color: Color(0xFF4A5397),
                                                fontWeight: FontWeight.bold),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                                Map<String, String> userdetail =
                                    Provider.of<UserDetail>(context,
                                            listen: false)
                                        .userget;
                                Map<String, String?> kitchen =
                                    Provider.of<Kitchen>(context, listen: false)
                                        .kitchenget;
                                Map<String, dynamic> kitchenaddress =
                                    Provider.of<KitchenAddress>(context,
                                            listen: false)
                                        .kitchenaddressget;
                                token = userdetail['token'] ?? '';

                                String? kitchenid = kitchen['id'];
                                String? kitchenaddressid = kitchenaddress['id'];
                                var headers = {
                                  'Authorization': 'Token $token',
                                };
                                print(kitchen['id']);
                                String delivery, takeaway;
                                if (selectedRadio == 3 || selectedRadio == 2) {
                                  delivery = 'true';
                                } else {
                                  delivery = 'false';
                                }
                                if (selectedRadio == 1 || selectedRadio == 2) {
                                  takeaway = 'true';
                                } else {
                                  takeaway = 'false';
                                }
                                String closeTime = endTime.toString();
                                var request = http.MultipartRequest(
                                    'PUT',
                                    Uri.parse(
                                        'http://homeshef-test.herokuapp.com/home-kitchen/kitchen/$kitchenid/'));
                                request.fields.addAll({
                                  'kitchen_name': kitchenNameController.text,
                                  'about': kitchenAboutController.text,
                                  // "opening_time": '10:00',
                                  //   "closing_time": closeTime,
                                  //     json.encode(endTime.toString()),
                                  "delivery": delivery,
                                  "takeaway": takeaway,
                                });

                                request.headers.addAll(headers);

                                http.StreamedResponse response =
                                    await request.send();
                                print(token);
                                if (response.statusCode == 200) {
                                  var headers = {
                                    'Authorization': 'Token $token',
                                  };
                                  print(kitchen['id']);

                                  var request = http.MultipartRequest(
                                      'PUT',
                                      Uri.parse(
                                          'http://homeshef-test.herokuapp.com/home-kitchen/kitchenaddress/$kitchenaddressid/'));
                                  request.fields.addAll({
                                    'address': address.text,
                                    'kitchen': kitchenaddressdata['kitchen'],
                                    'pincode': kitchenaddressdata['pin']
                                  });

                                  request.headers.addAll(headers);

                                  http.StreamedResponse response =
                                      await request.send();
                                  if (response.statusCode == 200) {
                                    final snackBar =
                                        SnackBar(content: Text('Done'));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  print(await response.stream.bytesToString());
                                } else {
                                  print(response.reasonPhrase);
                                }
                              }
                            })),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}
