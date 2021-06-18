import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class KitchenAddress with ChangeNotifier {
  Map<String, dynamic> kitchenaddress = {};
  Map<String, dynamic> get kitchenaddressget {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return kitchenaddress;
  }

  void setkitchenaddress(
      {required String kitchenaddressid,
      required String kitchen,
      required String pin,
      required String address}) {
    kitchenaddress = {
      'id': kitchenaddressid,
      "kitchen": kitchen,
      'pin': pin,
      'address': address
    };
    notifyListeners();
  }

  Future<bool> searchandsetkitchenaddress(
      {required String kitchen, required String token}) async {
    var headers = {
      'Authorization': 'Token $token',
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'http://homeshef-test.herokuapp.com/home-kitchen/kitchenaddress/'));

    request.headers.addAll(headers);

    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);

    if (response.statusCode == 200) {
      var allkitchen = json.decode(response.body) as Map<String, dynamic>;

      int c = 0;
      for (int i = 0; i < allkitchen['results'].length; i++) {
        if (allkitchen['results'][i]['kitchen'].toString() == kitchen) {
          c++;

          setkitchenaddress(
              kitchenaddressid: allkitchen['results'][i]['id'].toString(),
              address: allkitchen['results'][i]['address'] ?? '',
              kitchen: allkitchen['results'][i]['kitchen'].toString(),
              pin: allkitchen['results'][i]['pincode'] ?? '');
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
