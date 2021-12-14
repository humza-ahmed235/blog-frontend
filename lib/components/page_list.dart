import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';

class PageList extends StatelessWidget {
  const PageList(
      {Key? key,
      required this.totalPages,
      required this.page,
      required this.itemsPerPage,
      required this.pageTap})
      : super(key: key);

  final int totalPages;
  final int itemsPerPage;
  final int page;
  final Function pageTap;

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
                pageTap(i);
                //Navigator.pushNamed(context, '/login');
              },
            ),
          ),
      ],
    );
  }
}
