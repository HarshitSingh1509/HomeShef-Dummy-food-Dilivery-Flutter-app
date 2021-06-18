import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/Widgets/models/Categoryitems.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:home_chef/Screens/view_dish.dart';
import 'package:home_chef/Screens/menu_add.dart';
import 'package:http/http.dart' as htttp;
import 'package:provider/provider.dart';

import 'InformationPage.dart';
import 'Widgets/models/Category.dart';
import 'Widgets/models/Items.dart';
import 'Widgets/models/userdetail.dart';

class Menu extends StatefulWidget {
  final int categoryid;
  Menu({required this.categoryid});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List nameDish = [
    "Breakfast",
    "Lunch",
    "Snacks",
    "Dinner",
    "Breakfast",
    "Lunch",
    "Snacks",
    "Dinner",
    "Add"
  ];
  int categoryid = 0;
  String? token;
  @override
  void initState() {
    futureAlbum = fetchAlbum();
    categoryid = widget.categoryid;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  List<dynamic>? menuitem = [];
  Future<List<dynamic>> fetchAlbum() async {
    token = Provider.of<UserDetail>(context, listen: false).userget['token'];
    await Provider.of<CategoryItem>(context, listen: false)
        .fetchAndSetcategoeyitem(token: token ?? '', categoryid: categoryid)
        .then((value) =>
            menuitem = Provider.of<CategoryItem>(context, listen: false).items);
    print(menuitem);
    return menuitem ?? [];
  }

  late Future<List<dynamic>>? futureAlbum;

  @override
  Widget build(BuildContext context) {
    // Provider.of<CategoryItem>(
    //   context,
    // );

    return Scaffold(
      backgroundColor: HexColor("#DDDFEC"),
      appBar: AppBar(
        backgroundColor: HexColor("#DDDFEC"),
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupButton1(),
          Padding(padding: EdgeInsets.all(10)),
          PopupButton2(),
          Padding(padding: EdgeInsets.all(10))
        ],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          color: Colors.black,
          onPressed: () => Navigator.pop(
            context,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Dish List",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF4A5397)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/download.jpg",
                              )),
                        ),
                      ),
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Main Course",
                              style: TextStyle(
                                  color: HexColor("#4A5397"), fontSize: 25),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const LimitedBox(
                            child: Text(
                                "A main course is the featured or primary dish in a meal consisting of several courses. It usually follows the entry course"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder<List<dynamic>?>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 8),
                      itemCount: snapshot.data!.length + 1,
                      itemBuilder: (context, index) {
                        // ignore: sized_box_for_whitespace
                        // NetworkImage img = NetworkImage(
                        //     'http://homeshef-test.herokuapp.com' +
                        //         (snapshot.data!["items_in_category"][index]
                        //             ['image']));

                        return (snapshot.data!.length > index)
                            ? GestureDetector(
                                onTap: () async {
                                  await Provider.of<Item>(context,
                                          listen: false)
                                      .fetchAndSetitem(
                                          token: Provider.of<UserDetail>(
                                                      context,
                                                      listen: false)
                                                  .userget['token'] ??
                                              '',
                                          itemid: snapshot.data![index]['id'])
                                      .then((value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MenuEdit(
                                                    categoryid: categoryid,
                                                    itemid: snapshot
                                                        .data![index]['id'],
                                                  ))));
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xFF4A5397)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            width: 50,
                                            height: 50,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                child: Image(
                                                    fit: BoxFit.fill,
                                                    image:
                                                        //  AssetImage(
                                                        //   "assets/images/download.jpg",
                                                        // )
                                                        NetworkImage(
                                                            "http://homeshef-test.herokuapp.com" +
                                                                (snapshot.data![
                                                                            index]
                                                                        [
                                                                        'image'] ??
                                                                    ''),
                                                            scale: 1))),
                                          ),
                                        ),

                                        // ignore: sized_box_for_whitespace
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  LimitedBox(
                                                    child: Text(
                                                      snapshot.data![index]
                                                              ['name']
                                                          .toString()
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#4A5397"),
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    width: 20,
                                                    child: PopupMenuButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .all(new Radius
                                                                        .circular(
                                                                    15))),
                                                        child: Icon(
                                                          Icons.more_vert,
                                                          color: Colors.grey,
                                                          size: 30,
                                                        ),
                                                        onSelected: (value) {},
                                                        itemBuilder:
                                                            (context) => [
                                                                  PopupMenuItem(
                                                                      value: 1,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                                                              ),
                                                                              Text(
                                                                                'Available',
                                                                                style: TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                                                                              ),

                                                                              //
                                                                            ],
                                                                          ),
                                                                          Divider(
                                                                            endIndent:
                                                                                100,
                                                                            color:
                                                                                Color(0xFF4A5397),
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                        ],
                                                                      )),
                                                                  PopupMenuItem(
                                                                      value: 2,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                                                              ),
                                                                              Text(
                                                                                'Tenporary Unavailable',
                                                                                style: TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                                                                              ),

                                                                              //
                                                                            ],
                                                                          ),
                                                                          Divider(
                                                                            endIndent:
                                                                                100,
                                                                            color:
                                                                                Color(0xFF4A5397),
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                        ],
                                                                      )),
                                                                  PopupMenuItem(
                                                                      value: 3,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                                                              ),
                                                                              Text(
                                                                                'Unavailable',
                                                                                style: TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                                                                              ),

                                                                              //
                                                                            ],
                                                                          ),
                                                                          Divider(
                                                                            endIndent:
                                                                                100,
                                                                            color:
                                                                                Color(0xFF4A5397),
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                        ],
                                                                      )),
                                                                ]),
                                                  )
                                                ],
                                              ),
                                              Row(children: [
                                                SvgPicture.asset(
                                                  "assets/images/rupee.svg",
                                                  height: 20,
                                                  width: 20,
                                                  color: Color(0xFF4A5397),
                                                ),
                                                Text(snapshot.data![index]
                                                        ['cost']
                                                    .toString()),
                                              ])
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MenuAdd(categoryid: categoryid)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, bottom: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    elevation: 2,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFF4A5397),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
                                            Icon(
                                              Icons.add,
                                              size: 55,
                                            ),
                                            Text("Add")
                                          ],
                                        )),
                                  ),
                                ),
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
            ))
          ],
        ),
      ),
    );
  }
}
