import 'package:flutter/material.dart';

import 'TakePhoto.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 26, 1, 41),
        body: Center(
          child: Form(
            key: _formkey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Center(
                  child: RichText(
                      text: TextSpan(
                          text: 'Welcome to F-Check',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ))),
                ),
                Icon(
                  Icons.account_circle,
                  size: 150.0,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Username",
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          validator: (value) {
                            if (value.isEmpty) {
                              Pattern pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?)*$";
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value) || value == null)
                                return 'Enter a valid username';
                              else
                                return null;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                          ),
                          // keyboardType:  TextInputType.visiblePassword,
                          // controller: passwordTextController,
                          controller: password,
                          validator: (value) {
                            if (value.isEmpty) {
                              // Pattern pattern =  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              //     r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              //     r"{0,253}[a-zA-Z0-9])?)*$";
                              // RegExp regex = new RegExp(pattern);
                              // if (!regex.hasMatch(value) || value == null)
                              return 'The password field cannot be empty';
                            } else if (value.length < 6) {
                              return "The password has to be at least 6 character long";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color.fromARGB(255, 226, 3, 83),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ListTile(
                          title: MaterialButton(
                            onPressed: ()  {
                              if (_formkey.currentState.validate()) {
                                login(context,email.text,password.text);
                              }
                              else{
                                login(context,email.text,password.text);
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
void login( BuildContext context , String email, String password) {
  String phone_no = '9902127983' , pass = '1234567890';
  if(phone_no.toString() ==  email.toString() && pass.toString() == password.toString()){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TakePhoto()));
  }else{
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Invalid username or password')));
  }
}
