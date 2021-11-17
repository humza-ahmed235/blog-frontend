import 'package:http/http.dart' as http;
import 'dart:convert';

const baseurl = 'https://blog-backend-web.herokuapp.com';

Future<String> loginRequest(String email, String password) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';

  try {
    http.Response res = await http.post(
      Uri.parse(baseurl + '/routes/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );

    if (res.statusCode == 200) {
      return res.body;
    } else {
      return "error";
    }
  } catch (err) {
    print(err);
    return "error";
  }
}

Future<String> registerRequest(
    String name, String email, String password) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';
  http.Response res = await http.post(
    Uri.parse(baseurl + '/routes/adduser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
    },
    body: jsonEncode(<String, String>{
      "name": name,
      "email": email,
      'password': password,
    }),
  );

  if (res.statusCode == 200) {
    return res.body;
  } else {
    return "error";
  }
}

Future<String> getUserBlogsRequest(String? user_id) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';
  http.Response res = await http.get(
    Uri.parse(baseurl + '/routes/getblogs/$user_id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
    },
  );

  if (res.statusCode == 200) {
    return res.body;
  } else {
    return "error";
  }
}

Future<String> postBlogRequest(
    String? user_id, String blogTitle, String blogBody) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';

  try {
    http.Response res = await http.post(
      Uri.parse(baseurl + '/routes/addblogs'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
      },
      body: jsonEncode(<String?, String?>{
        "user_id": user_id,
        "blogtitle": blogTitle,
        "blogbody": blogBody,
        "blogtype": "Blog"
      }),
    );

    if (res.statusCode == 200) {
      return res.body;
    } else {
      return "error";
    }
  } catch (err) {
    print(err);
    return "error";
  }
}

//
Future<String> deleteBlog(String? blog_id) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';
  http.Response res = await http.delete(
    Uri.parse(baseurl + '/routes/deleteblog/$blog_id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
    },
  );

  if (res.statusCode == 200) {
    return res.body;
  } else {
    return "error";
  }
}

Future<String> updateBlogRequest(
  String blogTitle,
  String blogBody,
  String? blog_id,
  String? user_id,
) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';

  try {
    http.Response res = await http.put(
      Uri.parse(baseurl + '/routes/updateblog/$blog_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
      },
      body: jsonEncode(<String?, String?>{
        "user_id": user_id,
        "blogtitle": blogTitle,
        "blogbody": blogBody,
        "blogtype": "Blog"
      }),
    );

    if (res.statusCode == 200) {
      return res.body;
    } else {
      return "error";
    }
  } catch (err) {
    print(err);
    return "error";
  }
}