import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef/Screens/Cardthing.dart';
import 'package:home_chef/Screens/InformationPage.dart';
import 'package:home_chef/Screens/Widgets/models/Category.dart';
import 'package:home_chef/Screens/cardthingtakeaway.dart';
import 'package:home_chef/Screens/menu%20(2).dart';
import 'package:home_chef/size.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'Cardthinghistory.dart';
import 'Widgets/models/Categoryitems.dart';
import 'Widgets/models/userdetail.dart';
import 'category_screen.dart';
import 'package:http/http.dart' as http;

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final List<Map<String, String>> data = [
    {
      'name': 'Delivery',
      'date': 'Thu 24 Oct 8:00PM',
    }
  ];

  void initState() {
    futureAlbum = fetchAlbum();
    futureAlbum1 = fetchAlbum1();
    futureAlbum2 = fetchAlbum2();
    super.initState();
  }

  String? token;
  List<dynamic>? menuitem = [];

  Future<List<dynamic>> fetchAlbum() async {
    token = Provider.of<UserDetail>(context, listen: false).userget['token'];
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'http://homeshef-test.herokuapp.com/order/order-history/today_order/'));
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
  Future<List<dynamic>> fetchAlbum1() async {
    token = Provider.of<UserDetail>(context, listen: false).userget['token'];
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'http://homeshef-test.herokuapp.com/order/order-history/today_order/'));
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

  late Future<List<dynamic>>? futureAlbum1;
  Future<List<dynamic>> fetchAlbum2() async {
    token = Provider.of<UserDetail>(context, listen: false).userget['token'];
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'http://homeshef-test.herokuapp.com/order/order-history/today_order/'));
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

  late Future<List<dynamic>>? futureAlbum2;

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
          'Orders',
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
        length: 3,
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
                height: 50,
                child: TabBar(
                  labelColor: Color(0xFF4A5397),
                  labelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                  tabs: [
                    Tab(
                      text: 'Todays',
                    ),
                    Tab(
                      text: 'Future',
                    ),
                    Tab(text: 'History'),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      Container(
                        child: FutureBuilder<List<dynamic>>(
                            future: futureAlbum,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            CardThing(
                                              address: 'Address',
                                              orderid: '25',
                                              paymenttype: 'Cash',
                                              status: 'Accepted',
                                              totalamt: 1000,
                                              username: 'username',
                                              items: {},
                                            )
                                            // CardThing(address: '', orderid: '', paymenttype: '', status: '', totalamt: 100, username: '',),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                      );
                                    });
                              } else {
                                return Container(
                                  child: Text("No Items Yet"),
                                );
                              }
                            }),
                      ),
                      Container(
                        child: FutureBuilder<List<dynamic>>(
                            future: futureAlbum1,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            CardThing(
                                              address: 'Address',
                                              orderid: '25',
                                              paymenttype: 'Cash',
                                              status: 'Accepted',
                                              totalamt: 1000,
                                              username: 'username',
                                              items: {},
                                            )
                                            // CardThing(address: '', orderid: '', paymenttype: '', status: '', totalamt: 100, username: '',),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                      );
                                    });
                              } else {
                                return Container(
                                  child: Text("No Items Yet"),
                                );
                              }
                            }),
                      ),
                      Container(
                        child: FutureBuilder<List<dynamic>>(
                            future: futureAlbum2,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            CardThingHistory(
                                              address: 'Address',
                                              orderid: '25',
                                              paymenttype: 'Cash',
                                              status: 'Accepted',
                                              totalamt: 1000,
                                              username: 'username',
                                              items: {},
                                            )
                                            // CardThing(address: '', orderid: '', paymenttype: '', status: '', totalamt: 100, username: '',),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                      );
                                    });
                              } else {
                                return Container(
                                  child: Text("No Items Yet"),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
