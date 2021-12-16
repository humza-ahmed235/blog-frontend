import 'dart:convert';

import 'package:blog_frontend/components/blog_list.dart';
import 'package:blog_frontend/components/my_appbar.dart';
import 'package:blog_frontend/components/page_list.dart';
import 'package:blog_frontend/constants.dart';
import 'package:blog_frontend/services/networking.dart';
import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';
import 'dart:html';
//import 'package:flutter_svg/flutter_svg.dart';

import 'dart:html';

import 'package:intl/intl.dart';

class UserBlogsScreen extends StatefulWidget {
  const UserBlogsScreen({Key? key}) : super(key: key);

  @override
  _UserBlogsScreenState createState() => _UserBlogsScreenState();
}

class _UserBlogsScreenState extends State<UserBlogsScreen> {
  @override
  void initState() {
    // getBlogsObject().then((blogsObject) {
    //   setState(() {
    //     print("NO");
    //     List blogJSONList = blogsObject['blogList'];
    //     blogJSONList.forEach((blog) {
    //       print(blog);
    //       blogsList.add(Text("YUOHOH"));
    //       // blogsList.add(BlogCard(
    //       //     title: blog['blogtitle'],
    //       //     body: blog['blogbody'],
    //       //     date: blog['date']));
    //     });
    //   }); //set
    // });

    // getBlogsObject().then((blogsObject) {
    //   List<Widget> blogsListTemp = [];
    //
    //   //print("NO");
    //   List blogJSONList = blogsObject['blogList'];
    //   blogJSONList.forEach((blog) {
    //     print("My man profile");
    //     print(blog);
    //     //blogList2.add(Text("YUOHOH"));
    //     blogsListTemp.add(BlogCard(
    //       title: blog['blogtitle'],
    //       body: blog['blogbody'],
    //       date: blog['date'],
    //       blog_id: blog['_id'],
    //     ));
    //   });
    //   setState(() {
    //     blogsList.clear();
    //     blogsList = blogsListTemp;
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>....");
    return Scaffold(
      appBar: generateAppBar(
        "My Blogs",
        context,
      ),
      body: BlogList(
        allBlogs: false,
        user_id: window.localStorage['user_id']!,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-blog-post');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
