import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:home_chef/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'Widgets/models/userdetail.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  var chefNameController = TextEditingController();
  var chefAboutController = TextEditingController();
  var chefEmailController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  var colour = Colors.white;
  @override
  void initState() {
    chefNameController = TextEditingController();
    chefAboutController = TextEditingController();
    chefEmailController = TextEditingController();
    super.initState();
  }

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
        actions: <Widget>[
          PopupButton1(),
          Padding(padding: EdgeInsets.all(10)),
          PopupButton2(),
          Padding(padding: EdgeInsets.all(10))
        ],
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
              const Text("Profile",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
              const SizedBox(
                height: 20,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
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
              const SizedBox(
                height: 5,
              ),
              Center(
                  child: Text(
                "Chef Photo",
                style: TextStyle(color: Colors.black),
              )),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            TextField(
                              controller: chefNameController,
                              decoration: const InputDecoration(
                                hintText: "Chef Name",

                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                                // ignore: sized_box_for_whitespace
                              ),
                            ),
                            Divider(
                              height: 0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            TextField(
                              controller: chefAboutController,
                              decoration: const InputDecoration(
                                hintText: "About Chef",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                                // ignore: sized_box_for_whitespace
                              ),
                            ),
                            Divider(
                              height: 0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            TextField(
                              controller: chefEmailController,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                                // ignore: sized_box_for_whitespace
                              ),
                            ),
                            Divider(
                              height: 0,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            String? token =
                                Provider.of<UserDetail>(context, listen: false)
                                    .userget['token'];
                            String uid =
                                Provider.of<UserDetail>(context, listen: false)
                                    .userget['userid']
                                    .toString();
                            var headers = {
                              'Authorization': 'Token $token',
                            };
                            var request = http.MultipartRequest(
                                'PUT',
                                Uri.parse(
                                    'http://homeshef-test.herokuapp.com/userinfo/profile/$uid/'));
                            request.fields.addAll({
                              'name': chefNameController.text,
                              'email': chefEmailController.text
                            });

                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();

                            if (response.statusCode == 200) {
                              Navigator.pop(context);
                              print(await response.stream.bytesToString());
                            } else {
                              print(response.reasonPhrase);
                            }
                          })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
