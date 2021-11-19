import 'dart:html';

// print("Import check below");
// var result = window.localStorage['token'];
// print(result);

bool isAuth() {
  if (window.localStorage['token'] != null) {
    return true;
  }

  return false;
}
