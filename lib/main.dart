import 'package:blog_frontend/screens/create_blog_post.dart';
import 'package:blog_frontend/screens/home.dart';
import 'package:blog_frontend/screens/profile.dart';
import 'package:blog_frontend/screens/register.dart';
import 'package:blog_frontend/screens/update_blog_post.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/screens/login.dart';
import 'package:blog_frontend/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog',
      debugShowCheckedModeBanner: false,
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
      initialRoute: '/login',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => isAuth() ? const LoginScreen() : LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => isAuth() ? MyHomePage() : LoginScreen(),
        '/register': (context) => isAuth() ? RegisterScreen() : LoginScreen(),
        '/profile': (context) => isAuth() ? UserProfileScreen() : LoginScreen(),
        '/create-blog-post': (context) =>
            isAuth() ? CreateBlogPostScreen() : LoginScreen(),
        '/update-blog-post': (context) =>
            isAuth() ? UpdateBlogPostScreen() : LoginScreen(),
      },
    );
  }
}
