import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

import 'Widgets/models/userdetail.dart';

class Refer extends StatefulWidget {
  const Refer({Key? key}) : super(key: key);

  @override
  _ReferState createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  @override
  void initState() {
    getcode();
    super.initState();
  }

  String val = '';
  Future<void> getcode() async {
    String? token =
        Provider.of<UserDetail>(context, listen: false).userget['token'];
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://homeshef-test.herokuapp.com/moredata/customer_refferal_data/'));
    request.headers.addAll(headers);

    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body);
        val = data[0]['code'];
      });
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text("Refer",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width,
                  height: 430,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.12),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      children: [
                        // ignore: sized_box_for_whitespace
                        Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              'INVITE YOUR FRIENDS',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.bold,
                                color: HexColor("#4A5397"),
                              ),
                            ),
                          ),
                        ),
                        // ignore: sized_box_for_whitespace

                        Container(
                          height: 210,
                          child: const Center(
                            child: Text(
                              'Enroll your friends and they will get Rs. 50/- off on their Wallet. \n \nWhen your friend complete an order they will get Rs. 50/- in their wallet.\n \n T&C: When the kitchen are verified and the first order is recieved, the referral bonus will be credited to your waller, Referral Bonus will appear in your walllet in 2 days',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        // ignore: sized_box_for_whitespace
                        Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              'ENTER YOUR FRIENDS MOBILE PHONE NO.',
                              style: TextStyle(
                                fontSize: 15,
                                color: HexColor("#4A5397"),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Enter the number',
                            prefixIcon: Icon(
                              Icons.call_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 2,
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(18)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$val",
                            style: TextStyle(
                                fontSize: 20, color: HexColor("#4A5397")),
                          ),
                          const Text(
                            "Referral Code",
                            style: TextStyle(fontSize: 10),
                          )
                        ])),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Share.share('My Refer code is $val');
                  },
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 60,
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Share',
                          style: TextStyle(fontSize: 22.5),
                        ),
                        Icon(Icons.share)
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: HexColor("#4A5397")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
