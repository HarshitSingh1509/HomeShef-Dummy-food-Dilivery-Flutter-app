import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/InformationPage.dart';
import 'package:home_chef/Screens/Widgets/models/Category.dart';
import 'package:home_chef/Screens/category_add.dart';
import 'package:home_chef/Screens/kitchen_profile.dart';
import 'package:home_chef/Screens/menu (2).dart';
import 'package:home_chef/Screens/payments_weekly.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'Widgets/models/Categoryitems.dart';
import 'Widgets/models/userdetail.dart';

class Categorymenu extends StatefulWidget {
  const Categorymenu({Key? key}) : super(key: key);
  @override
  _CategorymenuState createState() => _CategorymenuState();
}

class _CategorymenuState extends State<Categorymenu> {
  int index = 0;

  void navbar(selectedindex) {
    setState(() {
      index = selectedindex;
    });
  }

  TextEditingController categorySearchController = TextEditingController();
  int screenshow = 0;
  final List nameCategory = [
    "Main Course",
    "Salads",
    "Combo Plan",
    "Roti",
    "Bakery",
    "Startes",
    "Soups",
    "Noodles",
    "Rice",
    "Starters",
    "Dals",
    "Add"
  ];
  void toggleScreen(int index) {
    setState(() {
      screenshow = index;
    });
  }

  void toggleMenuItem(int val) {
    setState(() {});
  }

  Map<String, dynamic> menuitem = {};
  String? token;
  Future<Map<String, dynamic>> fetchAlbum() async {
    token = Provider.of<UserDetail>(context, listen: false).userget['token'];
    await Provider.of<Category>(context, listen: false)
        .fetchAndSet(token: token ?? '')
        .then((value) =>
            menuitem = Provider.of<Category>(context, listen: false).items);
    print(menuitem);
    return menuitem;
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  late Future<Map<String, dynamic>> futureAlbum;
  @override
  build(BuildContext context) {
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
              pushNewScreen(
                context,
                screen: InformationPage(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            PopupButton1(),
            Padding(padding: EdgeInsets.all(10)),
            PopupButton2(),
            Padding(padding: EdgeInsets.all(10))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "View Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(0),
                    // padding: const EdgeInsets.only(
                    //     left: 50.0, right: 50, top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 300,
                          child: TextField(
                            //    controller: categorySearchController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 25, top: 25, bottom: 25, right: 25),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF4A5397),
                                size: 30,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35))),
                              hintText: "Search Category ",
                              hintStyle: TextStyle(
                                inherit: true,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffix: Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount:
                                  (snapshot.data!['results'] ?? []).length + 1,
                              itemBuilder: (context, index) {
                                // ignore: sized_box_for_whitespace
                                return ((snapshot.data!['results'] ?? [])
                                            .length >
                                        (index))
                                    ? GestureDetector(
                                        onTap: () async {
                                          await Provider.of<CategoryItem>(
                                                  context,
                                                  listen: false)
                                              .fetchAndSetcategoeyitem(
                                                  token: token ?? '',
                                                  categoryid:
                                                      snapshot.data!['results']
                                                          [index]['id'])
                                              .then((_) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Menu(
                                                        categoryid: snapshot
                                                                    .data![
                                                                'results']
                                                            [index]['id'])));
                                          });
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Color(0xFF4A5397),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          // shape: Border.all(
                                          //   color: Color(0xFF4A5397),
                                          // ),
                                          shadowColor: Colors.blueGrey,
                                          elevation: 2,
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.13,
                                                // width: MediaQuery.of(context)
                                                //     .size
                                                //     .width,
                                                // height: 100,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15)),
                                                  child: Image(
                                                      fit: BoxFit.fitWidth,
                                                      image: AssetImage(
                                                        "assets/images/cake.jpg",
                                                      )),
                                                ),
                                              ),
                                              // decoration: BoxDecoration(
                                              //     borderRadius:
                                              //         BorderRadius.circular(10.0),
                                              //     image: const DecorationImage(
                                              //         image: AssetImage(
                                              //           "assets/images/cake.jpg",
                                              //         ),
                                              //         fit: BoxFit.contain)),

                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Center(
                                                  child: Text(
                                                      snapshot.data!['results']
                                                              [index]
                                                          ["category_name"][0]),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoryAdd()));
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.add,
                                                  size: 55,
                                                ),
                                                Text("Add")
                                              ],
                                            )),
                                      );
                              });
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return Center(
                            child: Container(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator()));
                      },
                    ),
                  ),
                ])));
  }
}

class PopupButton2 extends StatefulWidget {
  const PopupButton2({
    Key? key,
  }) : super(key: key);

  @override
  _PopupButton2State createState() => _PopupButton2State();
}

class _PopupButton2State extends State<PopupButton2> {
  Widget child = SvgPicture.asset("assets/eva_radio-button-on-fill.svg");
  void togglechild(Object? value) {
    setState(() {
      if (value == 1) {
        child = SvgPicture.asset("assets/eva_radio-button-on-fill.svg");
      } else if (value == 2) {
        child = SvgPicture.asset("assets/eva_radio-button-on-fill-2.svg");
      } else if (value == 3) {
        child = SvgPicture.asset("assets/eva_radio-button-on-fill-1.svg");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(new Radius.circular(15))),
        offset: Offset(0, kToolbarHeight + 5),
        child: child,
        onSelected: (value) {
          togglechild(value);
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
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
                              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
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
                              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
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
            ]);
  }
}

class PopupButton1 extends StatefulWidget {
  const PopupButton1({
    Key? key,
  }) : super(key: key);

  @override
  _PopupButton1State createState() => _PopupButton1State();
}

class _PopupButton1State extends State<PopupButton1> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
                            padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          ),
                          InkWell(
                            child: Text(
                              'Delivering System',
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const KitchenProfile(),
                                ),
                              );
                            },
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
                            padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          ),
                          GestureDetector(
                            child: Text(
                              'Kitchen Timing',
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const KitchenProfile(),
                              ),
                            ),
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
                            padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          ),
                          GestureDetector(
                              child: Text(
                                'Payment Graph',
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () => pushNewScreen(
                                    context,
                                    screen: WeeklyPayments(),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  )),

                          //
                        ],
                      ),
                      Divider(
                        color: Color(0xFF4A5397),
                        thickness: 2,
                      ),
                    ],
                  )),
            ]);
  }
}
