import 'package:flutter/material.dart';
import 'package:home_chef/Screens/main.dart';
import 'package:home_chef/utils/res.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const MainScreen(),
                    ),
                  ),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              )),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Card(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Verification Via Visit',
                  style: TextStyle(
                      color: Color(0xFF4A5397),
                      fontFamily: 'Open Sans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Text('Our promise to Consumers is Trusted ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                    )),
                Text('& Verified Home Chefs. Our Team',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                    )),
                Text('Visits every  Home Chef house to',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                    )),
                Text(' check for  Hygiene and food quality.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                    )),
                Text('  They will be happy to share the ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                    )),
                Text('opportunity in person',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Email & Phone No.',
                  style: TextStyle(
                      color: Color(0xFF4A5397),
                      fontFamily: 'Open Sans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 30,
                        width: 30,
                        child: Image.asset(Imgs.userIcon)),
                    Text('homeshef13@gmail.com',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 30,
                        width: 30,
                        child: Image.asset(Imgs.phoneIcon)),
                    Text('+916206550977',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Register at',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontSize: 30,
                    )),
                Text('www.homeshef13.com',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontSize: 30,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
