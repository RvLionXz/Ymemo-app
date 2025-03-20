import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String API_URL = 'https://backend-catatan-production.up.railway.app';

//note class
class Note {
  final int? id;
  final String title;
  final String body;

  Note({this.id, required this.title, required this.body});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body};
  }
}

// Token Storage
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

// Register
Future<String> registerUser(
  String username,
  String password,
  String email,
) async {
  final response = await http.post(
    Uri.parse('$API_URL/api/register'),
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
    Uri.parse('$API_URL/api/login'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  if (response.statusCode == 200) {
    final token = await getToken();
    print(token);
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return "Login berhasil!";
  } else {
    print(response.statusCode);
    return "Login gagal! Periksa email dan password.";
  }
}

//Get notes
Future<List<Note>> fetchNotes() async {
  final token = await getToken();
  final response = await http.get(
    Uri.parse("$API_URL/api/notes"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );

    if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return jsonResponse.map((note) => Note.fromJson(note)).toList();
  } else {
    throw Exception('Gagal Menampilkan Notes');
  }
}
