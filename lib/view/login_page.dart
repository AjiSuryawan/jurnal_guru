import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jurnal_guru/config/service_config.dart';
import 'package:jurnal_guru/reusable/custom_button.dart';
import 'package:jurnal_guru/reusable/custom_error_dialog.dart';
import 'package:jurnal_guru/reusable/custom_password_text_field.dart';
import 'package:jurnal_guru/reusable/custom_text_field.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  final ServiceConfig serviceConfig = ServiceConfig();

  void _login(String username, String password) async {
    if (username != "" && password != "") {
      setState(() => _isLoading = true);

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      Map<String, dynamic> body = {
        "username": username,
        "password": password,
        "grant_type": "password",
        "imei": "admin@gmail.com",
      };

      try {
        final res = await http.post(
          Uri.parse("${ServiceConfig.baseUrl}token"),
          headers: headers,
          encoding: Encoding.getByName('utf-8'),
          body: body,
        );

        if (res.statusCode == 200) {
          print("login success");
          print(res.body);

          serviceConfig.setLoginStatus(true);
          serviceConfig.setUsernameAndPassword(username, password);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          print("login failed: " + res.statusCode.toString());
          var response = jsonDecode(res.body);
          setState(() {
            _isLoading = false;
            _showErrorDialog("Gagal", response['error_description']);
          });
        }
      } catch (e) {
        print(e.toString());
        setState(() {
          _isLoading = false;
          _showErrorDialog("Error", "Terjadi kesalahan");
        });
      }
    } else {
      _showErrorDialog("Gagal", "Ketikkan email dan password pada kolom yang tersedia");
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(context: context, builder: (context) {
      return CustomErrorDialog(title, content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jurnal Guru",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  Text(
                    'Masuk untuk melanjutkan',
                    style: TextStyle(fontSize: 14.0, color: Color(0xFF6B6B6B)),
                  ),
                  SizedBox(height: 35.0),
                  CustomTextField("Email", TextInputType.emailAddress, _emailController),
                  SizedBox(height: 10.0),
                  CustomPasswordTextField("Password", _passwordController),
                  SizedBox(height: 35.0),
                  CustomButton("Masuk", Color(0xFF38A3A5),
                          () => _login(_emailController.text, _passwordController.text)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
