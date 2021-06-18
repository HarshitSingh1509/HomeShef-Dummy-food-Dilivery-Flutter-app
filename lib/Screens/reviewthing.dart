import 'package:flutter/material.dart';

class ReviewThing extends StatelessWidget {
  String? content;
  String timestamp;
  ReviewThing({required this.content, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Text(
                    '$content',
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Divider(
                  thickness: 1.5,
                  color: Color(0xFF4A5397),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$timestamp',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      'Order Id #24',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Pradeep R',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
