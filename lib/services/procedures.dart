import 'dart:convert';
import 'dart:html';
import 'package:blog_frontend/components/user_card.dart';
import 'package:blog_frontend/main.dart';
import 'package:blog_frontend/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/screens/user_blogs.dart';
import 'package:blog_frontend/components/blog_card.dart';
import 'package:blog_frontend/components/page_list.dart';

void postLoginSetup(String resBody) {
  var resObject = jsonDecode(resBody);

  print(resObject.runtimeType);

  window.localStorage['user_id'] = resObject['data']['user_id'];
  window.localStorage['token'] = resObject['data']['token'];
  window.localStorage['name'] = resObject['data']['name'];
  window.localStorage['email'] = resObject['data']['user'];
  //window.localStorage['isAdmin'] = resObject['data']['isAdmin'];
}

// getBlogsObject() async {
//   var blogJsonString =
//       await getUserBlogsRequest(window.localStorage['user_id']);
//   print(blogJsonString);
//   return jsonDecode(blogJsonString);
// }

Future generateBlogsList(Function callbackUpdateBlogList,
    {required int page, required int blogsPerPage}) async {
  var blogJsonString = await getUserBlogsRequest(window.localStorage['user_id'],
      blogsPerPage: blogsPerPage, page: page);
  //print(blogJsonString);
  print(blogJsonString);
  var blogsObject = jsonDecode(blogJsonString);

  List<Widget> blogsListTemp = [];

  List blogJSONList = blogsObject['data']['blogList'];
  print("aa");
  print(blogJSONList);

  if (blogJSONList.isEmpty && page != 1) {
    generateBlogsList(callbackUpdateBlogList,
        page: page - 1, blogsPerPage: blogsPerPage);
    return;
  }

  if (blogJSONList.isEmpty && page == 1) {
    //generateBlogsList(callbackUpdateBlogList,
    //    page: page - 1, blogsPerPage: blogsPerPage);

    callbackUpdateBlogList([Text("No blogs found")], Text(""));
    return;
  }

  print("bb");

  blogJSONList.forEach((blog) {
    print("cc");
    print(blog);
    print("dd");
    //blogList2.add(Text("YUOHOH"));
    blogsListTemp.add(BlogCard(
      title: blog['blogtitle'],
      body: blog['blogbody'],
      date: blog['date'],
      blog_id: blog['_id'],
      likes: blog['likes']['count'].toString(),
      blogsPerPage: blogsPerPage,
      page: page,
      callbackUpdateBlogList: callbackUpdateBlogList,
    ));
  });

  // blogsListTemp.add(
  //
  // );
  PageList tempPageList = PageList(
    totalPages: totalPages(blogsObject['data']['count'], blogsPerPage),
    page: page,
    itemsPerPage: blogsPerPage,
    pageTap: (int i) {
      generateBlogsList(callbackUpdateBlogList,
          page: i, blogsPerPage: blogsPerPage);
    },
  );
  callbackUpdateBlogList(blogsListTemp, tempPageList);

  return blogsListTemp;
}

Future generateUsersList(Function callbackUpdateUsersList,
    {required int page, required int usersPerPage}) async {
  var userJsonString =
      await getAllUsersRequest(usersPerPage: usersPerPage, page: page);
  //print(blogJsonString);
  print(userJsonString);
  var usersObject = jsonDecode(userJsonString);

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
      usersPerPage: usersPerPage,
      page: page,
      callbackUpdateUsersList: callbackUpdateUsersList));
  blogJSONList.forEach((user) {
    print(user);
    //blogList2.add(Text("YUOHOH"));
    usersListTemp.add(UserCard(
      name: user['name'],
      email: user['email'],
      date: user['date'],
      user_id: user['_id'],
      usersPerPage: usersPerPage,
      page: page,
      callbackUpdateUsersList: callbackUpdateUsersList,
    ));
  });
  print("K");
  print(totalPages(usersObject['data']['Users']['count'], usersPerPage));
  print(usersObject['data']['Users']['count']);
  print(usersPerPage);
  PageList tempPageList = PageList(
    totalPages: totalPages(usersObject['data']['Users']['count'], usersPerPage),
    page: page,
    itemsPerPage: usersPerPage,
    pageTap: (int i) {
      generateUsersList(callbackUpdateUsersList,
          page: i, usersPerPage: usersPerPage);
    },
  );
  print("Q");
  callbackUpdateUsersList(usersListTemp, tempPageList);

  return usersListTemp;
}

Widget generatePageRow() {
  int blogCount = 26;
  int pages = 0;
  int blogsPerPage = 5;
  List<Widget> pageList = [];
  pages = (blogCount / blogsPerPage).toInt();

  if (blogCount % blogsPerPage != 0) {
    pages += 1;
  }

  for (int i = 1; i <= pages; i++) {
    pageList.add(Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        child: Text(
          (i).toString(),
          style: TextStyle(
            color: Colors.grey[800],
            //    fontWeight: FontWeight.bold
          ),
        ),
        onTap: () {
          //Navigator.pushNamed(context, '/login');
        },
      ),
    ));
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: pageList,
  );
}

logoutProcedure() {
  window.localStorage.clear();
  navigatorKey.currentState?.pushNamed('/login');
}

int totalPages(blogCount, blogsPerPage) {
  // int blogCount = 26;
  int pages = 0;
  //int blogsPerPage = 5;
  List<Widget> pageList = [];
  pages = (blogCount / blogsPerPage).toInt();

  if (blogCount % blogsPerPage != 0) {
    pages += 1;
  }

  return pages;
}

Map<String, dynamic> parseJwt(String? token) {
  final parts = token?.split('.');
  if (parts?.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts![1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
