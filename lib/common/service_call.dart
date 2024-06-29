import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common/locator.dart';
import 'package:http/http.dart' as http;

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);
typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {
  static Map userPayload = {};

  static final NavigationService navigationService =
      locator<NavigationService>();

  static void post(
    Map<String, dynamic> parameter,
    String path, {
    bool isToken = false,
    ResSuccess? withSuccess,
    ResFailure? failure,
  }) {
    Future(() async {
      try {
        var headers = {
          'Content-Type': 'application/x-www-form-urlencoded',
        };

        // if(isToken){
        //   headers["token"] = "";
        // }

        var response =
            await http.post(Uri.parse(path), body: parameter, headers: headers);
        if (kDebugMode) {
          print(response.body);
        }

        if (response.statusCode == 200) {
          var jsonObj =
              json.decode(response.body) as Map<String, dynamic>? ?? {};
          if (withSuccess != null) withSuccess(jsonObj);
        } else {
          if (failure != null) failure('Server error: ${response.statusCode}');
        }
      } catch (err) {
        if (failure != null) failure(err.toString());
      }
    });
  }

  static logout() {
    Globs.udBoolSet(false, Globs.userLogin);
    userPayload = {};
    navigationService.navigateTo("welcome");
  }
}
