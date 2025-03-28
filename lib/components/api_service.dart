import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymemo_app/models/note_class.dart';

const String url = 'https://backend-catatan-production.up.railway.app';

// Register
Future<String> registerUser(
  String username,
  String password,
  String email,
) async {
  final response = await http.post(
    Uri.parse('$url/api/register'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "username": username,
      "password": password,
      "email": email,
    }),
  );

  if (response.statusCode == 201) {
    return "Registrasi berhasil!";
  } else if (response.statusCode == 400) {
    return "Password harus memiliki huruf Kapital, Angka dan Simbol";
  } else {
    return "Registrasi gagal!";
  }
}

// Login
Future<String> loginUser(
  String email,
  String password,
  BuildContext context,
) async {
  final response = await http.post(
    Uri.parse('$url/api/login'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    String token = responseData['token'];
    String username = responseData['username'];

    await saveToken(token);
    await saveUserData(username);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return "Login berhasil!";
  } else {
    print("Error ${response.statusCode}: ${response.body}");
    return "Login gagal! Periksa email dan password.";
  }
}

// User data storage
Future<void> saveUserData(String username) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
}

class UserData {
  static Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username;
  }
}

// Token Storage
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

// Ambil Token
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  print("$token");
  return token;
}

class StatusUser {
  // save login status
  Future<void> saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  // clear login status
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

//Get notes
class ApiService {
  static Future<List<Note>> getNotes() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse("$url/api/notes"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> jsonData = jsonResponse["data"];
      List<Note> posts = jsonData.map((data) => Note.fromJson(data)).toList();
      print(posts);
      print("Data berhasil di ambil");
      return posts;
    } else {
      print(response);
      throw (response.statusCode);
    }
  }

  // Add notes
  static Future<void> createNotes(String title, String body) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse("$url/api/add/notes"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"title": title, "body": body}),
    );

    if (response.statusCode == 200) {
      print("Note berhasil ditambahkan");
    } else {
      print(response.statusCode);
    }
  }

  // Update Notes
  static Future<void> updateNotes(int id, String title, String body) async {
    final token = await getToken();
    final response = await http.patch(
      Uri.parse("$url/api/update/notes/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"title": title, "body": body}),
    );

    if (response.statusCode == 200) {
      print("Note sudah di update");
    } else {
      var debug = response.statusCode;
      print("note gagal di update, status code $debug");
    }
  }

  // Delete Notes
  static Future<void> deleteNotes(int id) async {
    final token = await getToken();
    final response = await http.delete(
      Uri.parse("$url/api/delete/notes/$id"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      print("Note has ben deleted");
    } else {
      print(response.statusCode);
    }
  }
}
