import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:blog_frontend/services/auth.dart';

AppBar generateAppBar(
  String title,
  BuildContext context, {
  bool showBackButton = true,
}) {
  return AppBar(
    automaticallyImplyLeading: showBackButton,
    actions: [
      isAuth(admin: true)
          ? Container(
              margin: EdgeInsets.only(right: 25.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin/user-management');
                  },
                  icon: Icon(Icons.admin_panel_settings)))
          : Container(),
      Container(
          margin: EdgeInsets.only(right: 25.0),
          child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(Icons.home))),
      Container(
        margin: EdgeInsets.only(right: 25.0),
        child: IconButton(
          icon: Icon(Icons.account_circle),
          //child: Text("Profile"),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: 25.0),
        child: IconButton(
          icon: Icon(Icons.logout),
          //child: Text("Log out"),
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
