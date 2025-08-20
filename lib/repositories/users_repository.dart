import 'dart:convert';

import 'package:flutterapp/core/constants.dart';
import 'package:flutterapp/models/user_model.dart';
import 'package:http/http.dart' as http;

class UsersRepository {
  final urlBaseApi = "${baseURLMockApi}users";

  Future <List<UserModel>> getUsers() async {
    List<UserModel> usersList = [];

    final response = await http.get(Uri.parse(urlBaseApi));
    if (response.statusCode == 200){
      // converter string para json
      final List<dynamic> usersJson = jsonDecode(response.body);
      // converter json para objeto
      for (var user in usersJson) {
        usersList.add(UserModel.fromJson(user));
      }
    }
    return usersList; 
  }
}