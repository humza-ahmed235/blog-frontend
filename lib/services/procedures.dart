import 'dart:convert';
import 'dart:html';

import 'package:blog_frontend/services/networking.dart';

void postLoginSetup(String resBody) {
  var resObject = jsonDecode(resBody);
  print("Yo below");
  print(resObject.runtimeType);

  window.localStorage['user_id'] = resObject['user_id'];
  window.localStorage['token'] = resObject['token'];
  window.localStorage['name'] = resObject['name'];
}

// getBlogsObject() async {
//   var blogJsonString =
//       await getUserBlogsRequest(window.localStorage['user_id']);
//   print(blogJsonString);
//   return jsonDecode(blogJsonString);
// }

Future getBlogsObject() async {
  var blogJsonString =
      await getUserBlogsRequest(window.localStorage['user_id']);
  //print(blogJsonString);
  return jsonDecode(blogJsonString);
}
