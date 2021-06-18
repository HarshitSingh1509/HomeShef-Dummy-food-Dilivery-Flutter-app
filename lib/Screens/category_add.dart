import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'Widgets/models/Category.dart';
import 'Widgets/models/userdetail.dart';

class CategoryAdd extends StatefulWidget {
  // CategoryAdd({required this.categoryid});

  @override
  _CategoryAddState createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  var nameofCategoryController;
  var aboutofCategoryController;
  @override
  void initState() {
    nameofCategoryController = TextEditingController();
    aboutofCategoryController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  var colour = Colors.white;
  PickedFile? _imageFile;
  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
      print(pickedFile!.path);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Container(
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.file(File(_imageFile!.path)).image),
            borderRadius: BorderRadius.circular(50)),
        width: 100,
        height: 100,
        child: const Icon(
          Icons.camera_alt,
          color: Colors.grey,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      if (img != null) {
        return Container(
          alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
              image: DecorationImage(image: img!.image),
              borderRadius: BorderRadius.circular(50)),
          width: 100,
          height: 100,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.grey,
          ),
        );
      } else {
        return Container(
          alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
          width: 100,
          height: 100,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.grey,
          ),
        );
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Image? img;
  var menuitem;
  @override
  Widget build(BuildContext context) {
    String? token =
        Provider.of<UserDetail>(context, listen: false).userget['token'];
    Provider.of<Category>(context).fetchAndSet(token: token ?? '');
    menuitem = Provider.of<Category>(context, listen: false).items;
    return Scaffold(
      backgroundColor: HexColor("#DDDFEC"),
      appBar: AppBar(
        backgroundColor: HexColor("#DDDFEC"),
        centerTitle: true,
        title: const Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.all(new Radius.circular(15))),
              offset: Offset(0, kToolbarHeight + 5),
              child: SvgPicture.asset("assets/dashicons_dashboard.svg"),
              onSelected: (value) {},
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 1,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                ),
                                Text(
                                  'Delivering System',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold),
                                ),

                                //
                              ],
                            ),
                            Divider(
                              color: Color(0xFF4A5397),
                              thickness: 2,
                            ),
                          ],
                        )),
                    PopupMenuItem(
                        value: 2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                ),
                                Text(
                                  'Kitchen Timing',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold),
                                ),

                                //
                              ],
                            ),
                            Divider(
                              color: Color(0xFF4A5397),
                              thickness: 2,
                            ),
                          ],
                        )),
                    PopupMenuItem(
                        value: 3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                ),
                                Text(
                                  'Payment Graph',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold),
                                ),

                                //
                              ],
                            ),
                            Divider(
                              color: Color(0xFF4A5397),
                              thickness: 2,
                            ),
                          ],
                        )),
                  ]),
          Padding(padding: EdgeInsets.all(10)),
          PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.all(new Radius.circular(15))),
              offset: Offset(0, kToolbarHeight + 5),
              child: SvgPicture.asset("assets/eva_radio-button-on-fill.svg"),
              onSelected: (value) {},
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 1,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                    child: SvgPicture.asset(
                                        "assets/eva_radio-button-on-fill.svg")),
                                Text(
                                  'Open',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold),
                                ),

                                //
                              ],
                            ),
                          ],
                        )),
                    PopupMenuItem(
                        value: 2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                    child: SvgPicture.asset(
                                        "assets/eva_radio-button-on-fill-2.svg")),
                                Text(
                                  'Busy',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold),
                                ),

                                //
                              ],
                            ),
                          ],
                        )),
                    PopupMenuItem(
                        value: 3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                    child: SvgPicture.asset(
                                        "assets/eva_radio-button-on-fill-1.svg")),
                                Text(
                                  'Close',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold),
                                ),

                                //
                              ],
                            ),
                          ],
                        )),
                  ]),
          Padding(padding: EdgeInsets.all(10))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Add new Category",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                    },
                    child: (_previewImage()),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameofCategoryController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintText: "Name of Category ",
                      hintStyle: TextStyle(
                        inherit: true,
                        fontSize: 18,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: aboutofCategoryController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintText: "About this Category ",
                      hintStyle: TextStyle(
                        inherit: true,
                        fontSize: 18,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: HexColor("#4A5397"),
                      shape: const StadiumBorder(),
                      onPressed: () async {
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();
                          Map<String, String> userdetail =
                              Provider.of<UserDetail>(context, listen: false)
                                  .userget;
                          print(userdetail);
                          String? token = userdetail['token'];

                          var headers = {
                            'Authorization': 'Token $token',
                          };

                          var request = http.MultipartRequest(
                              'POST',
                              Uri.parse(
                                  'http://homeshef-test.herokuapp.com/home-kitchen/categorytags/'));
                          List name = [];
                          name.add(nameofCategoryController.text);
                          String nam2 = nameofCategoryController.text;
                          request.fields.addAll({
                            'category_name': '["$nam2"]',
                            'about': aboutofCategoryController.text
                          });

                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Categorymenu()));
                            print(await response.stream.bytesToString());
                          } else {
                            print(response.reasonPhrase);
                          }
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
