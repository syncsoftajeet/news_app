import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices{
  @override
  Future getApi(String url) async{

    dynamic responseJson;

    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    }on SocketException{
      throw InternetException("No InterNet");
    }on RequestTimeOut{
      throw TimeoutException("Time Out");
    }

    return responseJson;

  }


  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw InvalidUrlException("Invalid Url Exception");

      default:
        throw FetchDataException("");
    }
  }

  @override
  Future postApi( data, String url) async {

    dynamic jsonResponse;

    try{
      final response = await http.post(Uri.parse(url),body: data
      ).timeout(const Duration(seconds: 20));
      jsonResponse = returnResponse(response);
    }on SocketException{
      throw InternetException("");
    }on RequestTimeOut{
      throw RequestTimeOut("");
    }

    return jsonResponse;

  }

}