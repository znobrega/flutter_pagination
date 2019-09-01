import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:pagination/src/models/photo.dart';

class Controller {

  String url = "https://jsonplaceholder.typicode.com/photos";

  Future<List<Photo>> getPhotos(int albumId) async {
    
    var response = await http.get("$url?photos=$albumId");
    
    List jsonList = json.decode(response.body);


    return jsonList.map((photo) => Photo.fromJson(photo)).toList();
  }
}

