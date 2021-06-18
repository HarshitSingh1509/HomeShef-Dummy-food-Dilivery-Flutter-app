import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:home_chef/Screens/Widgets/models/userdetail.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Item with ChangeNotifier {
  Map<String, dynamic> item = {};
  Map<String, dynamic> get items {
    return item;
  }

  Future<dynamic> fetchAndSetitem(
      {required String token, required int itemid}) async {
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://homeshef-test.herokuapp.com/home-kitchen/item/$itemid/'));

    request.headers.addAll(headers);
    Map<String, dynamic> loadedproduct = {};
    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      item = data;
      notifyListeners();
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }
}
