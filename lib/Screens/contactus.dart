import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:home_chef/utils/theme.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  _ContactUSState createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
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
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
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
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Contact us",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: FontFamily.OpenSansBold),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Card(
                  color: Colors.transparent,
                  elevation: 5,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.07,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              color: HexColor("#4A5397"),
                              shape: const StadiumBorder(),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Frequently Asked Questions",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Contact Us",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "You can connect with HomeShefs ",
                            style: TextStyle(fontSize: 20),
                          ),
                          const Text(
                            "Anytime",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Get in Touch with HomeShef",
                            style: TextStyle(fontSize: 20),
                          ),
                          newDetail("assets/images/location.svg",
                              "Broing Road, Patna, Bihar(India)"),
                          newDetail("assets/images/phone.svg", "+916206550977"),
                          newDetail(
                              "assets/images/whatsapp.svg", "+919992396301"),
                          newDetail("assets/images/mail.svg",
                              "helphomeshefhelp@gmail.com"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  newDetail(ima, tex) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SvgPicture.asset(
          ima,
          color: HexColor("#4A5397"),
        ),
        Text(tex, style: TextStyle(fontSize: 18))
      ],
    );
  }
}
