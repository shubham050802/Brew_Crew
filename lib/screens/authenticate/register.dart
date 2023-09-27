import "package:brew_crew/services/auth.dart";
import "package:brew_crew/shared/constants.dart";
import "package:brew_crew/shared/loading.dart";
import "package:flutter/material.dart";

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String _password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 5.0,
              title: Text('Register to Brew Crew'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Row(
                      children: [Icon(Icons.login), Text("Sign in")],
                    ))
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) {
                        if (val?.isEmpty == true) {
                          return "Enter an email";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) {
                        if (val!.length < 7) {
                          return "Enter an password 6+ char long";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          _password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, _password);
                          if (result == null) {
                            setState(() {
                              error = 'please supply a valid email';
                              loading = false;
                            });
                          } else {
                            widget.toggleView();
                          }
                        }
                      },
                      child: const Text("Register"),
                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[400],
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(error,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 14.0,
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
