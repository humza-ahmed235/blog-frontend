import 'dart:convert';
import 'dart:html';
import 'package:blog_frontend/main.dart';
import 'package:blog_frontend/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/screens/profile.dart';

void postLoginSetup(String resBody) {
  var resObject = jsonDecode(resBody);

  print(resObject.runtimeType);

  window.localStorage['user_id'] = resObject['data']['user_id'];
  window.localStorage['token'] = resObject['data']['token'];
  window.localStorage['name'] = resObject['data']['name'];
}

// getBlogsObject() async {
//   var blogJsonString =
//       await getUserBlogsRequest(window.localStorage['user_id']);
//   print(blogJsonString);
//   return jsonDecode(blogJsonString);
// }

Future generateBlogsList(Function callbackUpdateBlogList) async {
  var blogJsonString =
      await getUserBlogsRequest(window.localStorage['user_id']);
  //print(blogJsonString);
  print(blogJsonString);
  var blogsObject = jsonDecode(blogJsonString);

  List<Widget> blogsListTemp = [];

  List blogJSONList = blogsObject['data']['blogList'];
  print(blogJSONList);

  blogJSONList.forEach((blog) {
    print(blog);
    //blogList2.add(Text("YUOHOH"));
    blogsListTemp.add(BlogCard(
      title: blog['blogtitle'],
      body: blog['blogbody'],
      date: blog['date'],
      blog_id: blog['_id'],
      likes: blog['likes']['count'].toString(),
      callbackUpdateBlogList: callbackUpdateBlogList,
    ));
  });

  return blogsListTemp;
}

logoutProcedure() {
  window.localStorage.clear();
  navigatorKey.currentState?.pushNamed('/login');
}
