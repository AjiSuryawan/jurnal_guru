import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ServiceConfig {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static String baseUrl = "http://www.ecollectcpu.com:92/";

  void setLoginStatus(bool status) async {
    final SharedPreferences prefs = await _prefs;

    if (status) {
      String? imei = '-';
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      try {
        if (Platform.isAndroid) {
          var build = await deviceInfoPlugin.androidInfo;
          imei = build.androidId; //UUID for Android
        } else if (Platform.isIOS) {
          var data = await deviceInfoPlugin.iosInfo;
          imei = data.identifierForVendor; //UUID for iOS
        }
      } on PlatformException {
        print('Failed to get platform version');
      }
      await prefs.setString('imei', imei!);
    }

    prefs.setBool('loginStatus', status);
    print('LoginStatus has been set to $status');
  }

  void setUsernameAndPassword(String username, String password) async {
    final SharedPreferences prefs = await _prefs;

    String oldUsername = prefs.getString('oldUsername') ?? '-';
    print(oldUsername);
    print(username);
    if (username != oldUsername) {
      await prefs.remove('lastIn');
      await prefs.remove('lastOut');
    }

    prefs.setString('username', username);
    prefs.setString('oldUsername', username);
    prefs.setString('password', password);
  }


}
