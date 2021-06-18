import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardThingTakeaway extends StatelessWidget {
  const CardThingTakeaway({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Takeaway',
                  style: TextStyle(
                      color: Color(0xFF4A5397),
                      fontFamily: 'Open Sans',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Thu 24 Oct 8:00 PM',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                )
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        'Accept',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: Color(0xFF4A5397)),
                      ),
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF4A5397)),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: Container(
                      padding: EdgeInsets.all(1),
                      child: Text(
                        'Ready',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: Color(0xFF2DD452)),
                      ),
                      height: 20,
                      width: 110,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF2DD452)),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: Container(
                      padding: EdgeInsets.all(1),
                      child: Text(
                        'Decline',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: Color(0xFFFF0000)),
                      ),
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFFF0000)),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () {},
                  )
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Pradeep R',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 15,
                  ),
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
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                'Address',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Open Sans',
                  fontSize: 15,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                'Paras Tierea Sector',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Open Sans',
                  fontSize: 15,
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                '137 Noida',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Open Sans',
                  fontSize: 15,
                ),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Item List',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Qty',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Butter Chicken',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                ),
                Text(
                  '1 No',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Veg Thali',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                ),
                Text(
                  '2 No',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total No of Item',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                ),
                Text(
                  '3 No',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                )
              ],
            ),
            Divider(
              thickness: 1.1,
              color: Color(0xFF4A5397),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Amont',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Payment Type',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Status',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 15,
                  width: 100,
                  child: Row(children: <Widget>[
                    SvgPicture.asset(
                      "assets/bx_bx-rupee.svg",
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      '490',
                      style: TextStyle(
                        color: Color(0xFF4A5397),
                        fontFamily: 'Open Sans',
                        fontSize: 12,
                      ),
                    ),
                  ]),
                ),
                Text(
                  '  Cash',
                  style: TextStyle(
                    color: Color(0xFF4A5397),
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Accepted',
                  style: TextStyle(
                    color: Color(0xFF4A5397),
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
