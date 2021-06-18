import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Kitchen with ChangeNotifier {
  Map<String, String?> kitchen = {};
  Map<String, String?> get kitchenget {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return kitchen;
  }

  void setkitchenid(
      {required String kitchenid,
      required String userid,
      required String about,
      required String name}) {
    kitchen = {'id': kitchenid, "user": userid, 'name': name, 'about': about};
    notifyListeners();
  }

  Future<bool> searchandsetkitchen(
      {required String uid, required String token}) async {
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('http://homeshef-test.herokuapp.com/home-kitchen/kitchen/'));

    request.headers.addAll(headers);

    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response.statusCode == 200) {
      var allkitchen = json.decode(response.body) as List<dynamic>;

      int c = 0;
      for (int i = 0; i < allkitchen.length; i++) {
        if (allkitchen[i]['user'].toString() == uid) {
          c++;

          setkitchenid(
              kitchenid: allkitchen[i]['id'].toString(),
              userid: uid,
              about: allkitchen[i]['about'],
              name: allkitchen[i]['kitchen_name']);
          return true;
        }
      }
      if (c == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
