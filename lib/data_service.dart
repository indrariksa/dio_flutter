import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class DataService {
  final Dio dio = Dio();
  final String _baseUrl = 'https://reqres.in';
  Future getUsers() async {
    try {
      final response = await dio.get('$_baseUrl/api/users');

      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        return response.data;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Future postUser(String name, String job) async {
  Future<UserCreate?> postUser(UserCreate user) async {
    try {
      final response = await dio.post(
        '$_baseUrl/api/users',
        // data: {'name': name, 'job': job},
        data: user.toMap(),
      );
      if (response.statusCode == 201) {
        // return response.data;
        return UserCreate.fromJson(response.data);
        // CUSTOM RESPONSE
        // final name = response.data['name'];
        // final job = response.data['job'];
        // return {'namez': name, 'jobx': job};
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future putUser(String idUser, String name, String job) async {
    try {
      final response = await Dio().put(
        '$_baseUrl/api/users/$idUser',
        data: {'name': name, 'job': job},
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteUser(String idUser) async {
    try {
      final response = await Dio().delete('$_baseUrl/api/users/$idUser');
      if (response.statusCode == 204) {
        return 'Delete user success';
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<Iterable<User>?> getUserModel() async {
    try {
      var response = await dio.get('$_baseUrl/api/users');

      if (response.statusCode == 200) {
        final users = (response.data['data'] as List)
            .map((user) => User.fromJson(user))
            .toList();

        return users;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
