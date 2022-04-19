import 'package:flutter/material.dart';

 class SignUpscreen extends StatelessWidget {
  const SignUpscreen({Key? key}) : super(key: key);
  static String routeName ='/sign_up';

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
       iconTheme: const IconThemeData(color: Colors.black),
       centerTitle: true,

       title: const Text(
         "Sign Up",
         
         style: TextStyle(
           color: Color(0XFFB0BEC5),
           fontSize: 24 ,
           
           
          ),
        ),
      ),
      body: Container(
        child: const Text(
          "Register Account",
           style: TextStyle(
             fontSize: 28,
             fontWeight: FontWeight.bold,
             color: Colors.black,
             height: 1.5
           ),),
        

      ),
      
    );
  }
}