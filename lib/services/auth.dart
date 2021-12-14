import 'dart:html';

import 'package:blog_frontend/services/procedures.dart';

// print("Import check below");
// var result = window.localStorage['token'];
// print(result);

bool isAuth({bool admin = false}) {
  if (window.localStorage['token'] == null) {
    return false;
  }

  if (admin) {
    if (parseJwt(window.localStorage['token'])['isAdmin'] != true) {
      return false;
    }
  }

  return true;
}
