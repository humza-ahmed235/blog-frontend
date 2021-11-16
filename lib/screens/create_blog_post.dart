import 'package:blog_frontend/services/procedures.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/services/networking.dart' as networking;

// Create a Form widget.
class CreateBlogPostScreen extends StatefulWidget {
  const CreateBlogPostScreen({Key? key}) : super(key: key);

  @override
  CreateBlogPostScreenState createState() {
    return CreateBlogPostScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CreateBlogPostScreenState extends State<CreateBlogPostScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'Blog Title'),

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
                    minLines: 20,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: passwordController,
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
                    String resBody = await networking.loginRequest(
                        emailController.text, passwordController.text);
                    print(resBody);
                    if (resBody != "error") {
                      postLoginSetup(resBody);
                      Navigator.pushNamed(context, '/profile');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login Unsuccessful')),
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
