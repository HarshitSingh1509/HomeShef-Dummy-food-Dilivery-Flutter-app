import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:home_chef/Screens/menu%20(2).dart';
import "package:image_picker/image_picker.dart";
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Widgets/models/userdetail.dart';

class MenuAdd extends StatefulWidget {
  int categoryid;
  MenuAdd({required this.categoryid});

  @override
  _MenuAddState createState() => _MenuAddState();
}

class _MenuAddState extends State<MenuAdd> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController nameCategoryController = TextEditingController();
  TextEditingController aboutCategoryController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController portionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Object? value;
  int? selectedRadio;
  @override
  int categoryid = 0;
  void initState() {
    categoryid = widget.categoryid;
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }

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
      img == null;
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
        ;
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
  File? _image;
  final picker = ImagePicker();
  var colour = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DDDFEC"),
      appBar: AppBar(
        backgroundColor: HexColor("#DDDFEC"),
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.black),
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
          ),
        ),
        centerTitle: true,
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
                  const Text(
                    "Add New Dish",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
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
                      controller: nameCategoryController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: "Name of Dish ",
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
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: TextField(
                        controller: aboutCategoryController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: "About Dish",
                          hintStyle: TextStyle(
                            inherit: true,
                            fontSize: 18,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: ingredientsController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: "Ingredients Used in Dish ",
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
                      controller: portionController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: "Portion Size of Dish ",
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
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text("Dish Type"),
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: selectedRadio,
                                  onChanged: (val) {
                                    setSelectedRadio(val);
                                  }),
                              const Text("Veg"),
                              Radio(
                                  value: 2,
                                  groupValue: selectedRadio,
                                  onChanged: (val) {
                                    setSelectedRadio(val);
                                  }),
                              const Text("Non Veg")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: "Price of Dish",
                        hintStyle: const TextStyle(
                          inherit: true,
                          fontSize: 18,
                        ),
                        prefix: SvgPicture.asset(
                          "assets/images/rupee.svg",
                          height: 20,
                          width: 20,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // ignore: sized_box_for_whitespace
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
                          var userdetail =
                              Provider.of<UserDetail>(context, listen: false)
                                  .userget['token'];
                          var headers = {
                            'Authorization': 'Token $userdetail',
                          };
                          var request = http.MultipartRequest(
                              'POST',
                              Uri.parse(
                                  'https://homeshef-test.herokuapp.com/home-kitchen/item/'));
                          request.fields.addAll({
                            'name': nameCategoryController.text,
                            'cost': priceController.text,
                            'ingredients': ingredientsController.text,
                            "desc": aboutCategoryController.text,
                            'category': categoryid.toString()
                          });
                          if (_imageFile != null)
                            request.files.add(await http.MultipartFile.fromPath(
                                'image', _imageFile!.path));

                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();
                          print(response.statusCode);
                          if (response.statusCode == 201) {
                            print(await response.stream.bytesToString());
                            print(response.statusCode);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => Menu(
                                    categoryid: categoryid,
                                  ),
                                ));
                          } else {
                            print(response.reasonPhrase);
                          }
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ]),
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
