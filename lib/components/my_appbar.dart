import 'package:flutter/material.dart';
import 'dart:html';

AppBar generateAppBar(
  String title,
  BuildContext context, {
  bool showBackButton = true,
}) {
  return AppBar(
    automaticallyImplyLeading: showBackButton,
    actions: [
      Container(
        margin: EdgeInsets.only(right: 25.0),
        child: ElevatedButton(
          child: Text("Log out"),
          onPressed: () {
            window.localStorage.clear();
            Navigator.pushNamed(context, '/login');
          },
        ),
      )
    ],
    title: Text(title),
  );
}
