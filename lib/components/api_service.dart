import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home_page.dart';

// ignore: constant_identifier_names
const String API_URL = 'https://backend-catatan-production.up.railway.app';

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
  } else {
    return "Registrasi gagal!";
  }
}

// Login
Future<String> loginUser(String email, String password, BuildContext context) async {
  final response = await http.post(
    Uri.parse('$API_URL/api/login'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  if (response.statusCode == 200) {
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return "Login berhasil!";
  } else {
    return "Login gagal! Periksa email dan password.";
  }
}
