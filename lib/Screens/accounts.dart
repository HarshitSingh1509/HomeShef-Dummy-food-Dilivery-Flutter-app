import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/SignUp_Screen.dart';
import 'package:home_chef/Screens/gallery.dart';
import 'package:home_chef/Screens/refer.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'InformationPage.dart';
import 'Widgets/models/userdetail.dart';
import 'category_screen.dart';
import 'contactus.dart';
import 'edit_profile.dart';
import 'feedback.dart';
import 'kitchen_profile.dart';
import 'setting.dart';
import 'wallet.dart';
import 'package:http/http.dart' as http;

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
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
        centerTitle: true,
        actions: <Widget>[
          PopupButton1(),
          Padding(padding: EdgeInsets.all(10)),
          PopupButton2(),
          Padding(padding: EdgeInsets.all(10))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("Account Settings"),
            ),

            // Material(
            //   padding: const EdgeInsets.all(20),
            //   margin: const EdgeInsets.all(20),
            //   elevation: 5,
            //   child:
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(),
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/carbon_user.svg"),
                    tileColor: Colors.white,
                    title: Text(
                      "Edit Profile",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const EditProfile(),
                      ),
                    ),
                  ),
                ),
                newDivider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/kitchen.svg"),
                    tileColor: Colors.white,
                    title: Text(
                      "Edit Kitchen Profile",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const KitchenProfile(),
                      ),
                    ),
                  ),
                ),
                newDivider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/edit-gallery.svg"),
                    tileColor: Colors.white,
                    title: Text(
                      "Edit Gallery  (Coming Soon)",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const GalleryView(),
                      ),
                    ),
                  ),
                ),
                newDivider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/gift-card.svg"),
                    tileColor: Colors.white,
                    title: Text(
                      "Refer a friend CashBack",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Refer(),
                      ),
                    ),
                  ),
                ),
                newDivider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/uil_setting.svg"),
                    tileColor: Colors.white,
                    title: Text(
                      "Setting",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Settings(),
                      ),
                    ),
                  ),
                ),
                newDivider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/wallet.svg"),
                    tileColor: Colors.white,
                    title: Text(
                      "Wallet ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Wallet(),
                      ),
                    ),
                  ),
                ),
                newDivider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/call.svg"),
                    tileColor: Colors.white,
                    title: Text(
                      "Contact us",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const ContactUS(),
                      ),
                    ),
                  ),
                ),
                newDivider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/feedback.svg"),
                    tileColor: Colors.white,
                    title: Text(
                      "FeedBack",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const FeedBack(),
                      ),
                    ),
                  ),
                ),
                newDivider(),
              ]),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(28)),
            ),

            GestureDetector(
              onTap: () async {
                Map<String, String> userdetail =
                    Provider.of<UserDetail>(context, listen: false).userget;
                print(userdetail);
                String? token = userdetail['token'];
                var headers = {
                  'Authorization': 'Token $token',
                };
                var request = http.Request(
                    'POST',
                    Uri.parse(
                        'http://homeshef-test.herokuapp.com/account/logout/'));

                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 204) {
                  pushNewScreenWithRouteSettings(context,
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                      withNavBar: false,
                      screen: SignUp_Screen(),
                      settings: RouteSettings(name: '/', arguments: null));
                  // Navigator.of(context, rootNavigator: false)
                  //     .pushAndRemoveUntil<void>(
                  //   MaterialPageRoute<void>(
                  //       builder: (BuildContext context) => SignUp_Screen()),
                  //   ModalRoute.withName('/'),
                  // );
                  print(await response.stream.bytesToString());
                } else {
                  print(response.reasonPhrase);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 40, right: 40, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sign Out",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SvgPicture.asset("assets/images/sign-out.svg")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Divider newDivider() {
    return Divider(
      height: 0,
      thickness: 3,
      color: HexColor("#4A5397"),
    );
  }
}
