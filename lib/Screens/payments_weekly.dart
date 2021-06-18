import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:home_chef/Screens/InformationPage.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class WeeklyPayments extends StatefulWidget {
  const WeeklyPayments({Key? key}) : super(key: key);

  @override
  _WeeklyPaymentsState createState() => _WeeklyPaymentsState();
}

class _SalesMonthlyData {
  _SalesMonthlyData(this.year, this.sales);

  final String year;
  final double sales;
}

class _SalesWeeklyData {
  _SalesWeeklyData(this.year, this.sales);

  final String year;
  final double sales;
}

class _WeeklyPaymentsState extends State<WeeklyPayments> {
  String? _chosenValue = 'Weekly';
  List<_SalesMonthlyData> data = [
    _SalesMonthlyData('Jan', 35),
    _SalesMonthlyData('Feb', 28),
    _SalesMonthlyData('Mar', 34),
    _SalesMonthlyData('Apr', 32),
    _SalesMonthlyData('May', 40),
    _SalesMonthlyData('Jun', 35),
    _SalesMonthlyData('Jul', 28),
    _SalesMonthlyData('Aug', 34),
    _SalesMonthlyData('Sep', 32),
    _SalesMonthlyData('Oct', 40),
    _SalesMonthlyData('Nov', 32),
    _SalesMonthlyData('Dec', 40),
  ];
  List<_SalesWeeklyData> data1 = [
    _SalesWeeklyData("M", 25),
    _SalesWeeklyData("Tu", 26),
    _SalesWeeklyData("W", 24),
    _SalesWeeklyData("Th", 20),
    _SalesWeeklyData("F", 28),
    _SalesWeeklyData("Sa", 23),
    _SalesWeeklyData("Su", 21),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DDDFEC"),
      appBar: AppBar(
        backgroundColor: HexColor("#DDDFEC"),
        title: const Text(
          "Payment",
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
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ignore: deprecated_member_use
                newRaisedButton("Previous"),
                DropdownButton<String>(
                  focusColor: Colors.white,
                  value: _chosenValue,
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: HexColor("#4A5397"),
                  ),
                  elevation: 5,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: <String>['Weekly', 'Monthly']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                ),
                // ignore: deprecated_member_use
                newRaisedButton("Next"),
              ],
            ),
            _chosenValue == "Weekly"
                ? Card(
                    elevation: 5,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      color: Colors.white,
                      child: SfCartesianChart(
                          primaryYAxis: NumericAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            axisLine: const AxisLine(width: 0),
                          ),
                          primaryXAxis: CategoryAxis(),
                          title: ChartTitle(text: '16 Oct -22 Oct'),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesWeeklyData, String>>[
                            ColumnSeries<_SalesWeeklyData, String>(
                              dataSource: data1,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                              xValueMapper: (_SalesWeeklyData sales, _) =>
                                  sales.year,
                              yValueMapper: (_SalesWeeklyData sales, _) =>
                                  sales.sales,
                              name: 'Sales',
                            )
                          ]),
                    ),
                  )
                : Card(
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: SfCartesianChart(
                          backgroundColor: Color(0xFF4A5397),
                          plotAreaBorderColor: Color(0xFF4A5397),
                          plotAreaBackgroundColor: Color(0xFF4A5397),
                          primaryYAxis: NumericAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            //Hide the axis line of x-axis
                            axisLine: const AxisLine(width: 0),
                          ),
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(text: '2020-2021'),
                          // Enable legend
                          // legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesMonthlyData, String>>[
                            BarSeries(
                              dataSource: data,
                              color: const Color(0xFF4A5397),
                              borderColor: Color(0xFF4A5397),
                              xValueMapper: (_SalesMonthlyData sales, _) =>
                                  sales.year,
                              yValueMapper: (_SalesMonthlyData sales, _) =>
                                  sales.sales,
                              name: 'Sales',
                              // Enable data label
                              // dataLabelSettings: DataLabelSettings(isVisible: true))<_SalesMonthlyData, String>(
                            )
                          ]),
                    ),
                  ),
            const SizedBox(
              height: 5,
            ),
            Card(
              elevation: 5,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.94,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: [
                    newEntry(context, "Sales", " 27000.00"),
                    newEntry(context, "Delivery Fees", " 1000.00"),
                    newEntry(context, "Total Payments", " 28000.00"),
                    newEntry(context, "Online Payments", " 19000.00"),
                    newEntry(context, "Cash Payments", " 8000.00"),
                    newEntry(context, "Takeaway Payments", " 1000.00"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              newRaisedButton("Order History"),
              newRaisedButton("Balance"),
            ])
          ],
        ),
      ),
    );
  }

  // ignore: deprecated_member_use
  ButtonTheme newRaisedButton(text) {
    // ignore: deprecated_member_use
    return ButtonTheme(
      height: 25,
      minWidth: 100,
      child: RaisedButton(
        color: HexColor("#DDDFEC"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: HexColor("#4A5397"),
            )),
        onPressed: () {},
        highlightColor: Colors.blue,
        child: Text(
          text,
          style: TextStyle(
            color: HexColor("#4A5397"),
          ),
        ),
      ),
    );
  }

  Container newEntry(BuildContext context, type, amount) {
    return Container(
      margin: const EdgeInsets.all(2.5),
      padding: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.050,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Open Sans',
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/images/rupee.svg",
                height: 20,
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Open Sans',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
