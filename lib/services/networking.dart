import 'package:blog_frontend/services/procedures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html';
import 'package:blog_frontend/main.dart';

const baseurl = 'https://blog-backend-web.herokuapp.com';
//const baseurl = 'http://localhost:5000';

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
      'Authorization': 'Bearer ${window.localStorage['token']}',
    },
  );
  print(res.body);

  if (res.statusCode == 200 || res.statusCode == 400) {
    return res.body;
  }

  if (res.statusCode == 401) {
    logoutProcedure();
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
        'Authorization': 'Bearer ${window.localStorage['token']}',
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
    } else if (res.statusCode == 401) {
      logoutProcedure();
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
      'Authorization': 'Bearer ${window.localStorage['token']}',
    },
  );

  if (res.statusCode == 200) {
    return res.body;
  } else if (res.statusCode == 401) {
    logoutProcedure();
    return res.body;
  } else {
    return "error";
  }
}

Future<String> deleteUser(String? user_id) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';
  http.Response res = await http.delete(
    Uri.parse(baseurl + '/routes/deleteuser/$user_id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ${window.localStorage['token']}',
    },
  );

  if (res.statusCode == 200) {
    return res.body;
  } else if (res.statusCode == 401) {
    logoutProcedure();
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
        'Authorization': 'Bearer ${window.localStorage['token']}',
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
    } else if (res.statusCode == 401) {
      logoutProcedure();
      return res.body;
    } else {
      return "error";
    }
  } catch (err) {
    print(err);
    return "error";
  }
}

Future<String> likeRequest(String? user_id, String? blog_id) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';

  try {
    http.Response res = await http.put(
      Uri.parse(baseurl + '/routes/updatelikes/$blog_id/$user_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer ${window.localStorage['token']}',
      },
    );

    if (res.statusCode == 200) {
      return res.body;
    } else if (res.statusCode == 401) {
      logoutProcedure();
      return res.body;
    } else {
      return "error";
    }
  } catch (err) {
    print(err);
    return "error";
  }
}

Future<String> getBlog(String? blog_id) async {
  //print("yo2");
  //'http://192.168.18.60:5000/';
  http.Response res = await http.get(
    Uri.parse(baseurl + '/routes/blog/$blog_id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ${window.localStorage['token']}',
    },
  );
  print(res.body);

  if (res.statusCode == 200 || res.statusCode == 400) {
    return res.body;
  } else if (res.statusCode == 401) {
    logoutProcedure();
    return res.body;
  } else {
    return "error";
  }
}

Future<String> getAllUsersRequest() async {
  //print("yo2");
  //'http://192.168.18.60:5000/';
  http.Response res = await http.get(
    Uri.parse(baseurl + '/routes/SuperAdmin/allUsers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ${window.localStorage['token']}',
    },
  );
  print(res.body);

  if (res.statusCode == 200 || res.statusCode == 400) {
    return res.body;
  }

  if (res.statusCode == 401) {
    logoutProcedure();
    return res.body;
  } else {
    return "error";
  }
}
