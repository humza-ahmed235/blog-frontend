import 'package:flutter/material.dart';
import 'package:blog_frontend/services/networking.dart' as networking;

// Create a Form widget.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterScreenState extends State<RegisterScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Name'),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: 300,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "Invalid Email";
                  }

                  return null;
                },
              ),
            ),
            Container(
              width: 300,
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    String resBody = await networking.registerRequest(
                        nameController.text,
                        emailController.text,
                        passwordController.text);
                    print(resBody);
                    if (resBody != "error") {
                      Navigator.pushNamed(context, '/login');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account Created')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Registration Unsuccessful')),
                      );
                    }

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );

                  }
                },
                child: const Text('Register'),
              ),
            ),
            InkWell(
              child: Text(
                "Already have an account? Click here to sign in!",
                style: TextStyle(
                    color: Colors.grey[800], fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
        ),
      ),
    );
  }
}
