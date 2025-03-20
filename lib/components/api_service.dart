import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymemo_app/models/note_class.dart';

const String url = 'https://backend-catatan-production.up.railway.app';


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
    final token = await getToken();
    print(token);
    Navigator.push(
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
    Uri.parse("$url/api/notes"),
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
