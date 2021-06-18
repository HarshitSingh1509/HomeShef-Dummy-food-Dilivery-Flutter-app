import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:home_chef/Screens/Widgets/models/userdetail.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CategoryItem with ChangeNotifier {
  List<dynamic> categoryitem = [];
  List<dynamic> get items {
    return categoryitem;
  }

  Future<dynamic> fetchAndSetcategoeyitem(
      {required String token, required int categoryid}) async {
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://homeshef-test.herokuapp.com/home-kitchen/kitchen/$categoryid/items_in_kitchen/'));

    request.headers.addAll(headers);
    List<dynamic> loadedproduct = [];
    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      categoryitem = data;
      notifyListeners();
      print(data);
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }
}
