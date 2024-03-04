import 'package:flutter/material.dart';
import 'package:login_share_preference/home_page.dart';
import 'package:login_share_preference/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the Form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: Card(
            elevation: 10,
            shadowColor: Colors.blue,
            color: Colors.greenAccent,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Enter email",
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: passController,
                      cursorColor: Colors.blue,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: "Enter password",
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(Icons.lock),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // If all fields are validated, proceed with login
                            var sharedPref = await SharedPreferences.getInstance();
                            sharedPref.setBool(MySplashScreenState.keyLogin, true);
                            saveValue();
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(
                              builder: (context)=>HomePage(),
                            ));
                          }
                        },
                        child: Text("Login", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 10,
                          shadowColor: Colors.grey,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveValue() async {
    var prefs = await SharedPreferences.getInstance();
    var email = emailController.text.toString();
    var pass = passController.text.toString();

    prefs.setString("email", email);
    prefs.setString("pass", pass);
  }
}
