import 'dart:convert';
import 'dart:html';
import 'package:blog_frontend/components/user_card.dart';
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

Future generateUsersList(Function callbackUpdateUsersList) async {
  var blogJsonString = await getAllUsersRequest();
  //print(blogJsonString);
  print(blogJsonString);
  var usersObject = jsonDecode(blogJsonString);

  List<Widget> usersListTemp = [];

  List blogJSONList = usersObject['data']['Users']['userList'];
  print(blogJSONList);
  usersListTemp.add(UserCard(
      name: "Name",
      email: "Email",
      date: "Date Created",
      user_id: "",
      style: TextStyle(fontWeight: FontWeight.bold),
      showButton: false,
      callbackUpdateUsersList: callbackUpdateUsersList));
  blogJSONList.forEach((user) {
    print(user);
    //blogList2.add(Text("YUOHOH"));
    usersListTemp.add(UserCard(
      name: user['name'],
      email: user['email'],
      date: user['date'],
      user_id: user['_id'],
      callbackUpdateUsersList: callbackUpdateUsersList,
    ));
  });

  return usersListTemp;
}

logoutProcedure() {
  window.localStorage.clear();
  navigatorKey.currentState?.pushNamed('/login');
}
