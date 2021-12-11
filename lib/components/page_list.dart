import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';

class PageList extends StatelessWidget {
  const PageList(
      {Key? key,
      required this.totalPages,
      required this.page,
      required this.blogsPerPage,
      required this.callbackUpdateBlogList})
      : super(key: key);

  final int totalPages;
  final int blogsPerPage;
  final int page;
  final Function callbackUpdateBlogList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= totalPages; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              child: Text(
                (i).toString(),
                style: TextStyle(
                    color: page == i ? Colors.red : Colors.grey[800],
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                generateBlogsList(callbackUpdateBlogList,
                    page: i, blogsPerPage: blogsPerPage);
                //Navigator.pushNamed(context, '/login');
              },
            ),
          ),
      ],
    );
  }
}
