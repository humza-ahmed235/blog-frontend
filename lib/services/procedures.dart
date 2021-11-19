import 'dart:convert';
import 'dart:html';

import 'package:blog_frontend/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/screens/profile.dart';

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

Future generateBlogsList(Function callbackUpdateBlogList) async {
  var blogJsonString =
      await getUserBlogsRequest(window.localStorage['user_id']);
  //print(blogJsonString);
  var blogsObject = jsonDecode(blogJsonString);

  List<Widget> blogsListTemp = [];

  //print("NO");
  List blogJSONList = blogsObject['blogList'];
  blogJSONList.forEach((blog) {
    print("My man profile");
    print(blog);
    //blogList2.add(Text("YUOHOH"));
    blogsListTemp.add(BlogCard(
      title: blog['blogtitle'],
      body: blog['blogbody'],
      date: blog['date'],
      blog_id: blog['_id'],
      callbackUpdateBlogList: callbackUpdateBlogList,
    ));
  });

  return blogsListTemp;
}
