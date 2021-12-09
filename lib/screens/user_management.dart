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
  void callbackUpdateUsersList(List<Widget> usersListTemp) {
    setState(() {
      usersList = usersListTemp;
    });
  }

  @override
  void initState() {
    generateUsersList(callbackUpdateUsersList).then((usersListTemp) {
      setState(() {
        usersList.clear();
        usersList = usersListTemp;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppBar("User Management", context),
      body: Padding(
        padding: EdgeInsets.fromLTRB(80, 40, 80, 40),
        child: ListView(
          children: usersList,
        ),
      ),
    );
  }
}
