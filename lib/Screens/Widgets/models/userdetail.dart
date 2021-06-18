import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserDetail with ChangeNotifier {
  Map<String, String> user = {};
  Map<String, String> get userget {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return user;
  }

  void setuserauth({
    required String token,
    required String userid,
    required String phone,
  }) {
    user = {"token": token, "userid": userid, "phone": phone};
    notifyListeners();
  }
  // Future<void> fetchAndSet() async {
  //   var headers = {
  //     'Authorization':
  //         'Token 5a272dec02d8584413ec19c02e648ada5fbc7530cdabb16e57bdef9692b1e1a3',
  //     'Cookie':
  //         'csrftoken=RgxTfyuljwXmqCIxX6hiT4CQ661889Wc7ok1DJ3dJyvjfitkowTwY0ruXy1ACvpN; sessionid=5eb6np4fu3v0n6ugbm5ldgzq3tbbefwr'
  //   };
  //   var request = http.Request(
  //       'GET',
  //       Uri.parse(
  //           'http://homeshef-test.herokuapp.com/home-kitchen/categorytags/?q='));

  //   request.headers.addAll(headers);
  //   Map<String, dynamic> loadedproduct = {};
  //   http.StreamedResponse response1 = await request.send();
  //   var response = await http.Response.fromStream(response1);

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body) as Map<String, dynamic>;

  //     loadedproduct = data;
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   category = loadedproduct;
  //   notifyListeners();
  // }
}
