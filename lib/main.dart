import 'package:blog_frontend/screens/create_blog_post.dart';
import 'package:blog_frontend/screens/home.dart';
import 'package:blog_frontend/screens/profile.dart';
import 'package:blog_frontend/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      //home: LoginScreen(),
      initialRoute: '/create-blog-post',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => MyHomePage(),
        '/register': (context) => RegisterScreen(),
        '/profile': (context) => UserProfileScreen(),
        '/create-blog-post': (context) => CreateBlogPostScreen(),
      },
    );
  }
}
