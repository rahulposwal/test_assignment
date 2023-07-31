import 'dart:convert';
import 'package:assignment_project/model/ModelApiResponse.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  String userUrl = 'https://geek-jokes.sameerkumar.website/api?format=json';

  Future<Map<String,dynamic>> getUsers() async {
    var response = await http.get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      Map<String,dynamic> result = jsonDecode(response.body);
      return result;
      // return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}