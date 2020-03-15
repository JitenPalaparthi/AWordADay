import 'dart:convert';
import 'dart:io';
import 'package:AWordADay/models/word.dart' as word_model;
import 'package:AWordADay/models/response.dart';
import 'package:AWordADay/models/requestWord.dart'as requestWord_model;
import 'package:http/http.dart' as http;

class Word {
  Future<word_model.Word> getMagicWord(String url) async {
    try {
      
      final response = await http.get(url);
      // headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      if (response.statusCode == 200) {
        return word_model.Word.fromJson(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to fetch data');
      }
    } on HttpException catch (e) {
      print(e);
      return null;
    }
  }

 Future<GeneralResponse> addWord(
      String url, token, word_model.Word body) async {
    var response = await http.post(url, body: json.encode(body), headers: {
      "accept": "application/json",
      "content-type": "application/json",
     // HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return GeneralResponse.fromJson(
        json.decode(response.body), response.statusCode);
  }

   Future<GeneralResponse> requestAWord(
      String url, token, requestWord_model.RequestWord body) async {
    var response = await http.post(url, body: json.encode(body), headers: {
      "accept": "application/json",
      "content-type": "application/json",
     // HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return GeneralResponse.fromJson(
        json.decode(response.body), response.statusCode);
  }
}
