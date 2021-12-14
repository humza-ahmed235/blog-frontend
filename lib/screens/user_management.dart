import 'package:blog_frontend/components/my_appbar.dart';
import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<Widget> usersList = [Text("Loading")];
  Widget pageList = Text("Loading");
  void callbackUpdateUsersList(List<Widget> usersListTemp, Widget pageList) {
    setState(() {
      this.usersList = usersListTemp;
      this.pageList = pageList;
    });
  }

  @override
  void initState() {
    generateUsersList(callbackUpdateUsersList, usersPerPage: 10, page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppBar("User Management", context),
      body: Column(children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: EdgeInsets.fromLTRB(80, 40, 80, 40),
            child: ListView(
              children: usersList,
            ),
          ),
        ),
        Expanded(flex: 1, child: pageList)
      ]),
    );
  }
}
