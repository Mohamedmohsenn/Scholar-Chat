import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/ui/components/pic_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  String error = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C475B),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          picName("images/education.png", "Scholar Chat"),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    onSaved: (val) {
                      this.email = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Email couldnt be blank!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                        hintText: "Enter your Email",
                        labelText: "Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    obscureText: true,
                    onSaved: (val) {
                      this.password = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Password couldn't be blank!";
                      } else if (val.length < 6) {
                        return "Password can't be less than 6 letters!";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                        hintText: "Enter your Password",
                        labelText: "Password"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    height: 21,
                    child: Text(
                      this.error,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          try {
                            dynamic fireAuth = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: this.email, password: this.password);
                            setState(() {
                              this.error = "";
                            });
                            Navigator.pushReplacementNamed(context, 'third');
                          } catch (error) {
                            setState(() {
                              this.error = "Wrong Email or Password!";
                            });
                          }
                        }
                        else {
                          setState(() {
                            this.error = "";
                          });
                        }
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Color(0xFF2C475B),
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "don't have an account",
                    style: TextStyle(color: Colors.white),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'second');
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ))
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
