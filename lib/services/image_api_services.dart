import 'dart:convert';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:http/http.dart' as http;
import 'dart:math';


class ImageApiServices extends ChangeNotifier{
  static int randomNumber = Random().nextInt(500);
  static const String _clientID = 'WRTYVI37kTEWHdcw2TPwS-to4o93BmBI71pIaUJu-Jk';
  List? imageList;
  List? searchList;

  Future<List?> fetchImage() async {
    try{
      final String endPoint = 'https://api.unsplash.com/photos?page=$randomNumber&per_page=50&client_id=$_clientID';
      var uri = Uri.parse(endPoint);
      var response = await http.get(uri);
      print(response.statusCode);
      if(response.statusCode == 200){
        imageList = jsonDecode(response.body);
      }
    }catch (e){
      print(e.toString());
    }
    notifyListeners();
    return imageList;
  }

  // Future<dynamic> searchImage() async {
  //   var queryParameters = {
  //     'query': 'indonesia',
  //     'client_id' : _clientID,
  //   };
  //   try{
  //     var uri = Uri.https('api.unsplash.com', '/search/photos/', queryParameters);
  //     var response = await http.get(uri);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       final json = "[" + response.body + "]";
  //       searchList = jsonDecode(json) as List <dynamic>;
  //       for(var i = 0; i < searchList!.length; i++){
  //         imgUlr.add(searchList!.elementAt(i)['urls']['regular']);
  //       }
  //       print(imgUlr);
  //     }
  //   }catch (e) {
  //     print(e.toString());
  //   }
  //   notifyListeners();
  // }

}