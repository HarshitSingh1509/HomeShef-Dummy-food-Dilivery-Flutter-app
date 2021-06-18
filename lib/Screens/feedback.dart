import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:home_chef/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Widgets/models/userdetail.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  bool isPressed = false;
  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isPressed3 = false;
  bool isPressed4 = false;
  bool isPressed5 = false;
  var feedcontrol = TextEditingController();
  IconData? _selectedIcon;
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "FeedBack",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Open Sans'),
                  ),
                ),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Rate Your Experience",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Are you Satisfied with the Service? ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: HexColor("#4A5937")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: RatingBar.builder(
                                  itemSize: 30,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  glowColor: Colors.black,
                                  unratedColor: Colors.grey,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => SvgPicture.asset(
                                    "assets/images/filled-star.svg",
                                    height: 10,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Tell us what can be improved?"),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        print(isPressed);

                                        isPressed = !isPressed;
                                        setState(() {});
                                        print(isPressed);
                                      },
                                      shape: StadiumBorder(),
                                      color: isPressed
                                          ? HexColor("#4A5397")
                                          : Colors.white,
                                      child: isPressed
                                          ? const Text(
                                              "OverAll Service",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              "OverAll Service",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor("#4A5397")),
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        print(isPressed);

                                        isPressed1 = !isPressed1;
                                        setState(() {});
                                        print(isPressed);
                                      },
                                      shape: StadiumBorder(),
                                      color: isPressed1
                                          ? HexColor("#4A5397")
                                          : Colors.white,
                                      child: isPressed1
                                          ? const Text(
                                              "Customer Support",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              "Customer Support",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor("#4A5397")),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                Center(
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.transparent,
                      elevation: 5,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Card(
                            child: TextFormField(
                              controller: feedcontrol,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w300),
                                  hintText: " Tell us how can we improve"),
                            ),
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.07,
                    // ignore: deprecated_member_use
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: RaisedButton(
                      color: HexColor("#4A5397"),
                      shape: const StadiumBorder(),
                      onPressed: () async {
                        String? token =
                            Provider.of<UserDetail>(context, listen: false)
                                .userget['token'];
                        var headers = {
                          'Authorization': 'Token $token',
                        };
                        var request = http.MultipartRequest(
                            'POST',
                            Uri.parse(
                                'https://homeshef-test.herokuapp.com/moredata/feedback/'));
                        request.fields.addAll({'feedback': feedcontrol.text});

                        request.headers.addAll(headers);

                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 201) {
                          Navigator.pop(context);
                          final snackBar = SnackBar(
                              content: Text('Thanks for your feedback'));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          print(await response.stream.bytesToString());
                        } else {
                          print(response.reasonPhrase);
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontFamily: FontFamily.OpenSansBold,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}
