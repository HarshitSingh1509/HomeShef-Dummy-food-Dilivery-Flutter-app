import 'package:flutter/material.dart';
import 'package:home_chef/Screens/Widgets/models/Category.dart';
import 'package:home_chef/Screens/Widgets/models/Categoryitems.dart';
import 'package:home_chef/Screens/Widgets/models/kitchenaddress.dart';
import 'package:home_chef/Screens/Widgets/models/userdetail.dart';
import 'package:home_chef/Screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'Screens/Widgets/models/Items.dart';
import 'Screens/Widgets/models/Kitchen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Category>(create: (_) => Category()),
      ChangeNotifierProvider<UserDetail>(create: (_) => UserDetail()),
      ChangeNotifierProvider<Kitchen>(create: (_) => Kitchen()),
      ChangeNotifierProvider<KitchenAddress>(
        create: (_) => KitchenAddress(),
      ),
      ChangeNotifierProvider<CategoryItem>(create: (_) => CategoryItem()),
      ChangeNotifierProvider<Item>(create: (_) => Item())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
