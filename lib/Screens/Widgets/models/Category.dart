import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:home_chef/Screens/Widgets/models/userdetail.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Category with ChangeNotifier {
  Map<String, dynamic> category = {};
  Map<String, dynamic> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return category;
  }

  Future<void> fetchAndSet({required String token}) async {
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://homeshef-test.herokuapp.com/home-kitchen/categorytags/?q='));

    request.headers.addAll(headers);
    Map<String, dynamic> loadedproduct = {};
    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as Map<String, dynamic>;

      loadedproduct = data;
    } else {
      print(response.reasonPhrase);
    }
    category = loadedproduct;
    notifyListeners();
  }
}
