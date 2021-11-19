import 'dart:convert';

import 'package:blog_frontend/components/my_appbar.dart';
import 'package:blog_frontend/constants.dart';
import 'package:blog_frontend/services/networking.dart';
import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';
import 'dart:html';
//import 'package:flutter_svg/flutter_svg.dart';

import 'dart:html';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<Widget> blogsList = [Text("Loading")];
  var blogsObject;

  void callbackUpdateBlogList(List<Widget> blogsListTemp) {
    setState(() {
      blogsList = blogsListTemp;
    });
  }

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

    generateBlogsList(callbackUpdateBlogList).then((blogsListTemp) {
      setState(() {
        blogsList.clear();
        blogsList = blogsListTemp;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>....");
    return Scaffold(
      appBar: generateAppBar(
          "Profile Page - ${window.localStorage['name']}", context,
          showBackButton: false),
      body: Padding(
        padding: EdgeInsets.fromLTRB(80, 40, 80, 40),
        child: ListView(
          children: blogsList,
        ),
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

class BlogCard extends StatelessWidget {
  const BlogCard(
      {Key? key,
      required this.title,
      required this.body,
      required this.date,
      required this.blog_id,
      required this.callbackUpdateBlogList})
      : super(key: key);

  final String title;
  final String body;
  final String date;
  final String blog_id;
  final Function callbackUpdateBlogList;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        children: [
          // AspectRatio(
          //   aspectRatio: 1.78,
          //   child: Image.asset(blog.image),
          // ),
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Organization Name".toUpperCase(),
                      style: TextStyle(
                        color: kDarkBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isDesktop(context) ? 32 : 24,
                      fontFamily: "Raleway",
                      color: kDarkBlackColor,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SelectableText(
                  body,
                  // maxLines: 4,
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: kDefaultPadding / 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: kPrimaryColor, width: 3),
                          ),
                        ),
                        child: Text(
                          "Read More",
                          style: TextStyle(color: kDarkBlackColor),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/update-blog-post',
                          arguments: <String, String>{
                            'blog_title': this.title,
                            'blog_body': this.body,
                            'blog_id': this.blog_id,
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Delete Blog'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    Text(
                                        'Are you sure you want to delete this blog?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () async {
                                    var res = await deleteBlog(blog_id);
                                    print(res);
                                    generateBlogsList(callbackUpdateBlogList)
                                        .then((blogsListTemp) =>
                                            callbackUpdateBlogList(
                                                blogsListTemp));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    // IconButton(
                    //   icon:
                    //       SvgPicture.asset("assets/icons/feather_share-2.svg"),
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
