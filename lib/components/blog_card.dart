import 'package:flutter/material.dart';
import 'package:blog_frontend/components/my_appbar.dart';
import 'package:blog_frontend/constants.dart';
import 'package:blog_frontend/services/networking.dart';
import 'package:blog_frontend/services/procedures.dart';
import 'dart:html';
import 'dart:convert';
import 'package:intl/intl.dart';

class BlogCard extends StatefulWidget {
  BlogCard(
      {Key? key,
      required this.title,
      required this.body,
      required this.date,
      required this.blog_id,
      required this.likes,
      required this.blogsPerPage,
      required this.page,
      required this.callbackUpdateBlogList})
      : super(key: key);

  final String title;
  final String body;
  final String date;
  final String blog_id;
  final int blogsPerPage;
  final int page;
  final Function callbackUpdateBlogList;
  String likes;
  IconData likeIcon = Icons.favorite_border;

  @override
  _BlogCardState createState() => _BlogCardState();

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;
}

class _BlogCardState extends State<BlogCard> {
  @override
  void initState() {
    print("a1");
    getBlog(widget.blog_id).then((resBody) {
      print("a3");
      //IconData newIcon = Icons.favorite_border;
      //print()
      if (jsonDecode(resBody)['data']['likes']['userlist']
          .contains(window.localStorage['user_id'])) {
        //newIcon = Icons.favorite;
        setState(() {
          widget.likeIcon = Icons.favorite;
        });
      } else {
        setState(() {
          widget.likeIcon = Icons.favorite_border;
        });
      }
      print("a4");
    });

    print("a2");
    super.initState();
  }

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
                      DateFormat("dd-MM-yyyy")
                          .format(DateTime.parse(widget.date)),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: widget.isDesktop(context) ? 32 : 24,
                      fontFamily: "Raleway",
                      color: kDarkBlackColor,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "By Hassan Ahmed".toUpperCase(),
                      style: TextStyle(
                        color: kDarkBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      DateFormat("dd-MM-yyyy")
                          .format(DateTime.parse(widget.date)),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                SelectableText(
                  widget.body,
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
                      icon: Icon(widget.likeIcon),
                      onPressed: () async {
                        print("a");
                        String resBody = await likeRequest(
                            window.localStorage['user_id'], widget.blog_id);
                        print("b");
                        print(resBody);
                        String likes = jsonDecode(resBody)['data']['Likes']
                                ['count']
                            .toString();
                        IconData newIcon = Icons.favorite_border;
                        if (jsonDecode(resBody)['data']['Likes']['userlist']
                            .contains(window.localStorage['user_id'])) {
                          newIcon = Icons.favorite;
                        } else {
                          newIcon = Icons.favorite_border;
                        }
                        setState(() {
                          widget.likes = likes;
                          widget.likeIcon = newIcon;
                        });
                      },
                    ),
                    Text(widget.likes),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/update-blog-post',
                          arguments: <String, String>{
                            'blog_title': widget.title,
                            'blog_body': widget.body,
                            'blog_id': widget.blog_id,
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
                                    var res = await deleteBlog(widget.blog_id);
                                    print(res);
                                    generateBlogsList(
                                        widget.callbackUpdateBlogList,
                                        blogsPerPage: widget.blogsPerPage,
                                        page: widget.page);

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
