import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef/Screens/Cardthing.dart';
import 'package:home_chef/Screens/InformationPage.dart';
import 'package:home_chef/Screens/Widgets/models/Kitchen.dart';
import 'package:home_chef/Screens/reviewthing.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'Widgets/models/userdetail.dart';
import 'category_screen.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  void initState() {
    futureAlbum = fetchAlbum();

    super.initState();
  }

  String? token = '';
  Future<List<dynamic>> fetchAlbum() async {
    token = Provider.of<UserDetail>(context, listen: false).userget['token'];
    String id = Provider.of<Kitchen>(context, listen: false)
        .kitchenget['id']
        .toString();
    print(id);
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://homeshef-test.herokuapp.com/home-kitchen/kitchen/$id/comments/'));

    request.headers.addAll(headers);

    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return data;

      // print(await response.stream.bytesToString());
    } else {
      return [];
      print(response.reasonPhrase);
    }
  }

  late Future<List<dynamic>>? futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            color: Colors.black,
            onPressed: () => pushNewScreen(
                  context,
                  screen: InformationPage(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                )),
        title: Text(
          'Review',
          style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        actions: <Widget>[
          PopupButton1(),
          Padding(padding: EdgeInsets.all(10)),
          PopupButton2(),
          Padding(padding: EdgeInsets.all(10))
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFF4A5397).withOpacity(0.1),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFF4A5397).withOpacity(0.1),
          body: Container(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => Categorymenu(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Todays Menu Schedule',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 20,
                        color: Color(0xFF4A5397)),
                  ),
                  height: 40,
                  width: 250,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF4A5397)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Review',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  child: Container(
                    child: FutureBuilder<List<dynamic>>(
                        future: futureAlbum,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        ReviewThing(
                                          content: snapshot.data![index]
                                              ['content'],
                                          timestamp: snapshot.data![index]
                                              ['timestamp'],
                                        )
                                        // CardThing(address: '', orderid: '', paymenttype: '', status: '', totalamt: 100, username: '',),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(10),
                                  );
                                });
                          } else {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              ))
            ],
          )),
        ),
      ),
    );
  }
}
