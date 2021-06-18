import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/Widgets/models/Category.dart';
import 'package:home_chef/Screens/Widgets/models/Categoryitems.dart';
import 'package:home_chef/Screens/menu%20(2).dart';
import 'package:home_chef/utils/constants.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'Widgets/models/Category.dart' as category1;
import 'Widgets/models/Category.dart';
import 'Widgets/models/Items.dart';
import 'Widgets/models/userdetail.dart';

class MenuEdit extends StatefulWidget {
  int itemid;
  int categoryid;
  MenuEdit({required this.itemid, required this.categoryid});

  @override
  _MenuEditState createState() => _MenuEditState();
}

class _MenuEditState extends State<MenuEdit> {
  var name;
  var description;
  var ingredients;
  var veg = TextEditingController();
  var cost;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  int itemid = 0;
  int categoryid = 0;
  int? selectedRadio;
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
  @override
  void initState() {
    itemid = widget.itemid;
    categoryid = widget.categoryid;
    String? token =
        Provider.of<UserDetail>(context, listen: false).userget['token'];

    item = Provider.of<Item>(context, listen: false).items;
    print(item);
    name = TextEditingController(text: item['name']);
    description = TextEditingController(text: item['desc']);
    ingredients = TextEditingController(text: item['ingredients']);
    cost = TextEditingController(text: item['cost']);
    img = Image.network((item['image']));
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }

  var item;
  @override
  Widget build(BuildContext context) {
    String? token =
        Provider.of<UserDetail>(context, listen: false).userget['token'];
    Provider.of<CategoryItem>(context, listen: false)
        .fetchAndSetcategoeyitem(token: token ?? '', categoryid: categoryid);
    item = Provider.of<Item>(context, listen: false).items;

    return Scaffold(
      backgroundColor: Color(0xFFDDDFEC),
      appBar: AppBar(
        backgroundColor: Color(0xFFDDDFEC),
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
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
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Type of Dish",
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
                  height: 5,
                ),
                fields(context, "Name of Dish", item['name'], name),
                fields(context, "About Dish", item['desc'], description),
                fields(context, "Ingredients used in dish", item['ingredients'],
                    ingredients),
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
                fields(context, "Price of Dish", item['cost'] ?? '0', cost),
                Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Color(0xFF4A5397),
                      shape: const StadiumBorder(),
                      onPressed: () async {
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();
                          Map<String, String> userdetail =
                              Provider.of<UserDetail>(context, listen: false)
                                  .userget;

                          String? token = userdetail['token'];
                          String id = item['id'].toString();

                          var headers = {
                            'Authorization': 'Token $token',
                          };

                          var request = http.MultipartRequest(
                              'PUT',
                              Uri.parse(
                                  'http://homeshef-test.herokuapp.com/home-kitchen/item/$id/'));

                          request.fields.addAll({
                            'name': name.text,
                            'cost': cost.text,
                            'ingredients': ingredients.text
                          });
                          print(_imageFile!.path);

                          print(item['name']);
                          if (_imageFile != null)
                            request.files.add(await http.MultipartFile.fromPath(
                                'image', _imageFile!.path));

                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200) {
                            String? token =
                                Provider.of<UserDetail>(context, listen: false)
                                    .userget['token'];
                            await Provider.of<Item>(context, listen: false)
                                .fetchAndSetitem(
                                    token: token ?? '', itemid: item['id'])
                                .then((value) async =>
                                    await Provider.of<CategoryItem>(context,
                                            listen: false)
                                        .fetchAndSetcategoeyitem(
                                            categoryid: item['category'],
                                            token: token ?? '')
                                        .then((value) => {}));
                          } else {
                            print(response.reasonPhrase);
                          }

                          // await requestgenerator(
                          //     name!.text,
                          //     description!.text,
                          //     ingredients!.text,
                          //     cost!.text,
                          //     menuitem['results'][categoryid]
                          //             ["items_in_category"][itemid]['id']
                          //         .toString());
                        }
                      },
                      child: const Text(
                        "Edit",
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

  Padding fields(BuildContext context, title, description, control) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(title),
                  TextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return Constants.nameblank;
                      } else if (value.trim().length >= 30) {
                        return 'Name should not be more then 30 characters.';
                      } else {
                        return null;
                      }
                    },
                    controller: control,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 29,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontFamily: FontFamily.OpenSansRegular, fontSize: 17),
                      counterText: '',
                      border: _enableBorder,
                      focusedBorder: _enableBorder,
                      errorBorder: _enableBorder,
                      focusedErrorBorder: _enableBorder,
                      disabledBorder: _enableBorder,
                      enabledBorder: _enableBorder,
                      fillColor:
                          Color.fromRGBO(70, 70, 90, 0.10).withOpacity(0.0),
                      filled: true,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  var _enableBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
  );
  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
