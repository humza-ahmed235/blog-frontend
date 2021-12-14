import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/services/networking.dart';
import 'package:blog_frontend/services/procedures.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {Key? key,
      required this.name,
      required this.email,
      required this.date,
      this.style = const TextStyle(),
      this.showButton = true,
      required this.user_id,
      required this.usersPerPage,
      required this.page,
      required this.callbackUpdateUsersList})
      : super(key: key);
  final String name;
  final String email;
  final String date;
  final String user_id;
  final int usersPerPage;
  final int page;
  final TextStyle style;
  final bool showButton;
  final Function callbackUpdateUsersList;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(children: [
      Expanded(flex: 1, child: Text(this.name, style: style)),
      Expanded(flex: 1, child: Text(this.email, style: style)),
      Expanded(flex: 1, child: Text(this.date, style: style)),
      Expanded(
        child: Visibility(
          visible: showButton,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete User'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text('Are you sure you want to delete this user?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () async {
                          var res = await deleteUser(this.user_id);
                          print(res);
                          generateUsersList(callbackUpdateUsersList,
                              usersPerPage: this.usersPerPage, page: this.page);
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
        ),
      )
    ]));
  }
}
