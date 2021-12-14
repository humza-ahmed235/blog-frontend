import 'package:blog_frontend/services/procedures.dart';
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
            logoutProcedure();
          },
        ),
      )
    ],
    title: Text(title),
    centerTitle: true,
  );
}
