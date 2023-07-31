import 'dart:convert';
import 'package:assignment_project/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<Map<String, dynamic>> getUsers() async {
    final queryParameters = {'format': 'json'};
    Uri uri = Uri.parse(Constants.baseUrl);
    final finalUri = uri.replace(queryParameters: queryParameters);
    var response = await http.get(finalUri);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
