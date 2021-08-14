import 'dart:convert';

// import 'package:assesment_app/screens/bottom_tabs_screen.dart';
// import 'package:assesment_app/services/api_manager.dart';
import 'package:flutter/material.dart';

class SignInSceen extends StatelessWidget {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController userController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  // signUserUp(BuildContext context) async {
  //   if (formKey.currentState!.validate()) {
  //     var completeToken = await API_manager()
  //         .signIn(userController.text, passwordController.text);
  //     print("TOKEN HERE: ${completeToken.toString()}");

  //     if (completeToken.toString().length > 1) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute<void>(
  //             builder: (BuildContext context) => TabsScreen(completeToken)),
  //         ModalRoute.withName('/'),
  //       );
  //     } else {
  //       print(completeToken.toString());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Color(0xff007EF4),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.87,
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: userController,
                    // validator: (val) {
                    //   if (val.length < 2) {
                    //     return "Please enter your name";
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    // validator: (val) {
                    //   if (val.length == 10) {
                    //     return null;
                    //   }
                    //   return "Enter a valid phone number.";
                    // },
                    style: TextStyle(color: Colors.white),
                    // keyboardType: TextInputType.number,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO Submit Data & Sign In
                      // signUserUp(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.075,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff007EF4), Color(0xff2A75BC)],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     //TODO Submit Data & Sign Up
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.9,
                  //     height: MediaQuery.of(context).size.height * 0.075,
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //           colors: [Colors.white, Colors.grey[300]]),
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         'Sign Up',
                  //         style: TextStyle(fontSize: 20, color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
