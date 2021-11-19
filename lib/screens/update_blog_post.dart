import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/services/networking.dart' as networking;
import 'dart:html';
import 'package:blog_frontend/components/my_appbar.dart';

// Create a Form widget.
class UpdateBlogPostScreen extends StatefulWidget {
  const UpdateBlogPostScreen({Key? key}) : super(key: key);

  @override
  UpdateBlogPostScreenState createState() {
    return UpdateBlogPostScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class UpdateBlogPostScreenState extends State<UpdateBlogPostScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final blogTitleController = TextEditingController();
  final blogBodyController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    blogTitleController.dispose();
    blogBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    var routeArguments = ModalRoute.of(context)?.settings.arguments as Map;
    blogTitleController.text = routeArguments['blog_title'];
    blogBodyController.text = routeArguments['blog_body'];
    print("heyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    print(routeArguments['blog_body']);
    return Scaffold(
      appBar: generateAppBar("Update Blog Post", context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(80, 20, 80, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    // initialValue: routeArguments['blog_title'],
                    controller: blogTitleController,
                    decoration: InputDecoration(
                        hintText: 'Blog Title', border: OutlineInputBorder()),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    // initialValue: routeArguments['blog_body'],
                    minLines: 20,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: blogBodyController,
                    decoration: InputDecoration(
                        hintText: 'Blog Text', border: OutlineInputBorder()),

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
              ),
              SizedBox(
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String resBody = await networking.updateBlogRequest(
                      blogTitleController.text,
                      blogBodyController.text,
                      routeArguments['blog_id'],
                      window.localStorage['user_id'],
                    );
                    //print(resBody);
                    if (resBody != "error") {
                      //postLoginSetup(resBody);
                      //Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Blog update unsuccessful')),
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
                  child: const Text('Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
