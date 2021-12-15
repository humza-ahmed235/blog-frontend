import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/services/networking.dart';
import 'dart:html';
import 'package:blog_frontend/components/my_appbar.dart';

// Create a Form widget.
class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  UserSettingsScreenState createState() {
    return UserSettingsScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class UserSettingsScreenState extends State<UserSettingsScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController.text = window.localStorage['name']!;
    emailController.text = window.localStorage['email']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    // var routeArguments = ModalRoute.of(context)?.settings.arguments as Map;

    //print("heyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    //print(routeArguments['blog_body']);
    return Scaffold(
      appBar: generateAppBar("Settings", context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(80, 20, 80, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: TextFormField(
                  // initialValue: routeArguments['blog_title'],
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Name', border: OutlineInputBorder()),

                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 16,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  // initialValue: routeArguments['blog_body'],
                  minLines: 1,
                  maxLines: null,
                  //keyboardType: TextInputType.,
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Email', border: OutlineInputBorder()),

                  //initialValue: "Password",
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String resBody = await updateUserRequest(
                      nameController.text,
                      emailController.text,
                    );
                    //print(resBody);
                    if (resBody != "error") {
                      //postLoginSetup(resBody);
                      //Navigator.pop(context);
                      window.localStorage['name'] =
                          nameController.text.isNotEmpty
                              ? nameController.text
                              : window.localStorage['name']!;

                      window.localStorage['email'] =
                          emailController.text.isNotEmpty
                              ? emailController.text
                              : window.localStorage['email']!;
                      Navigator.pushNamed(context, '/profile');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Account update unsuccessful')),
                      );
                    }

                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Processing Data')),
                      // );

                    }
                  },
                  child: const Text('Update'),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Account'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    'Are you sure you want to delete your account?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () async {
                                var res = await deleteUser(
                                    window.localStorage['user_id']);
                                print(res);
                                // generateUsersList(callbackUpdateUsersList,
                                //     usersPerPage: this.usersPerPage,
                                //     page: this.page);
                                window.localStorage.clear();
                                //Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Account Deleted')),
                                );
                                Navigator.pushNamed(context, '/login');
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
                  child: Text("Delete Account")),
            ],
          ),
        ),
      ),
    );
  }
}
