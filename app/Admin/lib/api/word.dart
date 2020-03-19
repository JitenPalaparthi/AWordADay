import 'dart:convert';
import 'dart:io';
import 'package:Admin/models/word.dart' as word_model;
import 'package:Admin/models/response.dart';
import 'package:Admin/models/requestWord.dart' as requestWord_model;
import 'package:http/http.dart' as http;

import '../models/response.dart';

class Word {
  final String BASE_URL =
      "http://localhost:50051/v1/";
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

  Future<List<word_model.Word>> getWords(int skip, limit) async {
    try {
      var url = "http://localhost:50051/v1/word/get/" +
          skip.toString() +
          "/" +
          limit.toString();
      final response = await http.get(url);
      // headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        if (l != null) {
          List<word_model.Word> list =
              l.map((model) => word_model.Word.fromJson(model)).toList();
          return list;
        } else {
          return null;
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load the data');
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
  Future<GeneralResponse> updateWord(String token,id, Map<String,dynamic> body)async{
    String url="http://localhost:50051/v1/word/update/"+id;
    var response = await http.put(url,body: json.encode(body), headers: {
      "accept": "application/json",
      "content-type": "application/json",
      // HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return GeneralResponse.fromJson(
        json.decode(response.body), response.statusCode);
  }

   Future<GeneralResponse> deleteWord(String token,word)async{
    String url="http://localhost:50051/v1/word/"+word;
    var response = await http.delete(url, headers: {
      "accept": "application/json",
      "content-type": "application/json",
      // HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return GeneralResponse.fromJson(
        json.decode(response.body), response.statusCode);
  }
}
