import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:html';
import 'package:blog_frontend/components/my_appbar.dart';
import 'package:blog_frontend/components/page_list.dart';
import 'package:blog_frontend/constants.dart';
import 'package:blog_frontend/services/networking.dart';
import 'package:blog_frontend/services/procedures.dart';

class BlogList extends StatefulWidget {
  BlogList({Key? key, this.allBlogs = false, this.user_id = ""})
      : super(key: key);

  //String user_id;
  bool allBlogs;
  String user_id;

  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  List<Widget> blogsList = [Text("Loading")];
  //List<Widget> pageList = [Text("Loading")];

  Widget pageList = Text("Loading");
  var blogsObject;

  @override
  void initState() {
    print(widget.allBlogs);
    print("n");
    generateBlogsList(callbackUpdateBlogList,
        blogsPerPage: 6,
        page: 1,
        allBlogs: widget.allBlogs,
        user_id: widget.user_id);

    super.initState();
  }

  void callbackUpdateBlogList(List<Widget> blogsListTemp, Widget pageList) {
    setState(() {
      blogsList.clear();
      this.blogsList = blogsListTemp;
      this.pageList = pageList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 9,
        child: Padding(
          padding: EdgeInsets.fromLTRB(80, 40, 80, 40),
          child: ListView(
            children: blogsList,
          ),
        ),
      ),
      Expanded(flex: 1, child: pageList)
    ]);
  }
}
