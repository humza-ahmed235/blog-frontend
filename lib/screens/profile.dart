import 'dart:convert';

import 'package:blog_frontend/components/my_appbar.dart';
import 'package:blog_frontend/services/networking.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState

    getUserRequest().then((resBody) {
      setState(() {
        name = jsonDecode(resBody)['data']['name'];
        email = jsonDecode(resBody)['data']['email'];
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: generateAppBar("Profile Page", context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // width: 3 / 5 * constraints.maxWidth,
              // height: 3 / 5 * constraints.maxHeight,
              width: MediaQuery.of(context).size.width * 3 / 5,
              height: MediaQuery.of(context).size.height * 3 / 5,
              child: Card(
                elevation: 35.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 25),
                    ),
                    Divider(
                      indent: 1 / 10 * MediaQuery.of(context).size.width,
                      endIndent: 1 / 10 * MediaQuery.of(context).size.width,
                    ),
                    Text(
                      email,
                      style: TextStyle(fontSize: 25),
                    ),
                    Divider(
                      indent: 1 / 10 * MediaQuery.of(context).size.width,
                      endIndent: 1 / 10 * MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/my-blogs');
                            },
                            child: Text("My Blogs")),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/my-blogs');
                            },
                            child: Text("Settings"))
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
            )
          ],
        ));
  }
}
