import 'dart:convert';
import 'package:fcm_app/responseModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FcmApi {

  final http.Client httpClient;
  FcmApi({required this.httpClient});

  final String baseUrl = '${dotenv.env['BASEURL']}';

  Future<ResponseModel> sendToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ResponseModel responseModel = ResponseModel();
    try {
      http.Response response = await httpClient.get(Uri.parse('$baseUrl/validateKey?key=${token}'));
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      responseMap['result'] = responseModel.result;
      responseMap['key'] = responseModel.key;
      return responseModel;
    } catch(e) {
      print(e);
      throw responseModel;
    }
  }
}