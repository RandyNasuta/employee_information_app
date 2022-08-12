import 'package:employee_information/models/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  String _url = 'https://62e5f347de23e26379250f80.mockapi.io/users';

  Future<List<Employee>> getAllData() async {
    var response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      List responseData = json.decode(response.body);
      return responseData.map((data) => Employee.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> postData(String name, String position, String avatar) async {
    var response = await http.post(Uri.parse(_url), body: {
      'name': name,
      'position': position,
      'avatar': avatar,
    });

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateData(String id, String name, String avatar, String position) async {
    var response = await http.put(Uri.parse('${_url}/$id'), body: {
      'id': id,
      'name' : name,
      'avatar' : avatar,
      'position' : position,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteData(String id) async {
    var response = await http.delete(Uri.parse('${_url}/$id'), body: {
      'id': id,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
