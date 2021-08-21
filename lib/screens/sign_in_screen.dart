import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_todays_tiffin/Utilities/utilities.dart';
import 'package:z_todays_tiffin/screens/homescreen.dart';
import 'package:z_todays_tiffin/services/firebase_methods.dart';

class SignInScreen extends StatefulWidget {
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _passwordController.text = "123456";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Center(
          child: Column(
            children: [
              Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sign In",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Sign In to access the features!"),
                            SizedBox(
                              height: 40,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _numberController,
                                      decoration: InputDecoration(
                                        labelText: "Phone Number",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        // else if (value.length != 10) {
                                        //   return "Enter a valid 10 digit Phone Number";
                                        // }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                            labelText: "Password"),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter password';
                                          }
                                          return null;
                                        }),
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await Authorize()
                                .signinwithPhoneEmail(
                              _numberController.text.trim(),
                              _passwordController.text.trim(),
                            )
                                .then((value) {
                              if (value == "success") {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const HomeScreen()),
                                    (Route<dynamic> route) => false);
                              }
                            });
                          }
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF5DA5ED),
                                  Color(0xFF0984FD),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.5),
                                  blurRadius: 1.5,
                                ),
                              ]),
                          child: SizedBox(
                            width: 240,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: Text(
                                      "Sign In",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 12, 0),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
