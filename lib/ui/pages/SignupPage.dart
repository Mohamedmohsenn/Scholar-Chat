
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/ui/components/pic_name.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String name;

  String email;

  String password;

  String error = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C475B),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          picName("images/education.png", "Scholar Chat"),
          SizedBox(
            height: 100,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    onSaved: (val) {
                      this.name = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return "name couldn't be blank!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
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
                        hintText: "Enter your Name",
                        labelText: "Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    onSaved: (val) {
                      this.email = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Email couldn't be blank!";
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
                        return "Password cant be less than 6 letters!";
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
                ),Padding(
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
                        _formKey.currentState.save();
                        if (_formKey.currentState.validate()) {
                          try {
                            dynamic fireAuth = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: this.email, password: this.password);
                            setState(() {
                              this.error = "Email already Exist!";
                            });
                          } catch (error) {
                            try {
                              dynamic v = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: this.email,
                                      password: this.password);
                              Navigator.pop(context);
                            } catch (error) {
                              setState(() {
                                this.error = "Sign Up Error!";
                              });
                            }
                          }
                        }
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color(0xFF2C475B),
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
