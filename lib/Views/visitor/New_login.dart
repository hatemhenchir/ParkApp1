import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/Views/park_owner/choice_activity.dart';

import 'package:flutter_application_2/Views/visitor/New_navBar.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignupScreen = false;
  bool isVisitor = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  TextEditingController _emailLogincontroller = TextEditingController();
  TextEditingController _passwordLogincontroller = TextEditingController();
  String errorMessage = '';

  String? _person = "visiteur";

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phone.dispose();
    _emailLogincontroller.dispose();
    _passwordLogincontroller.dispose();
  }

  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? phone;

  String? emailLogin;
  String? passwordLogin;

  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 300,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://thumbs.dreamstime.com/b/smart-parking-illustration-man-user-smartphone-touch-screen-control-car-driving-to-parking-lot-internet-connection-127312550.jpg'),
                            fit: BoxFit.fill)),
                    child: Container(
                      padding: EdgeInsets.only(top: 70, left: 20),
                      color:
                          Color.fromARGB(255, 117, 131, 162).withOpacity(0.85),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Welcome to ",
                                  style: GoogleFonts.nunito(
                                      letterSpacing: 2,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  children: [
                                TextSpan(
                                    text: isSignupScreen ? "Goo Park" : "Back",
                                    style: GoogleFonts.nunito(
                                      // color:Colors.black,
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ])),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            isSignupScreen
                                ? "Signup to continue"
                                : "Signin to continue",
                            style: GoogleFonts.nunito(
                                letterSpacing: 1,
                                fontSize: 15,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  top: isSignupScreen ? 140 : 250,
                  child: Container(
                    height: isSignupScreen ? 510 : 270,
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5)
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignupScreen = false;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "LOGIN",
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? Colors.grey
                                            : Colors.green.shade300,
                                      ),
                                    ),
                                    if (!isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.green.shade300,
                                      )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignupScreen = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "SIGN UP",
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? Colors.green.shade300
                                            : Colors.grey,
                                      ),
                                    ),
                                    if (isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.green.shade300,
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                          if (isSignupScreen) buildSignupSection(),
                          if (!isSignupScreen) buildLoginScreen()
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  top: isSignupScreen ? 610 : 470,
                  right: 0,
                  left: 0,
                  child: SingleChildScrollView(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() async {
                            if (isSignupScreen) {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  var result = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _email.text,
                                          password: _password.text);
                                  if (result != null) {
                                    await FirebaseFirestore.instance
                                        .collection("utilisateur")
                                        .doc(result.user!.uid)
                                        .set({
                                      'name': _name.text,
                                      'email': _email.text,
                                      'phone': _phone.text,
                                      'role': _person,
                                    });
                                    isSignupScreen = false;
                                    setState(() {});
                                    //Navigator.push(context,MaterialPageRoute(builder:(context)=>AppHome()));
                                  }
                                  errorMessage = '';
                                } on FirebaseAuthException catch (error) {
                                  errorMessage = error.message!;
                                  Fluttertoast.showToast(
                                      msg: errorMessage,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 10.0);
                                }
                              }
                            } else if (!isSignupScreen) {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  var result = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: _emailLogincontroller.text,
                                          password:
                                              _passwordLogincontroller.text);
                                  if (result != null) {
                                    final User? user =
                                        FirebaseAuth.instance.currentUser;
                                    final userId = user!.uid;

                                    await FirebaseFirestore.instance
                                        .collection("utilisateur")
                                        .doc(userId)
                                        .get()
                                        .then((DocumentSnapshot snapshot) {
                                      setState(() {
                                        if (snapshot.get("role") ==
                                            'proprietaire') {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Choice()));
                                        } else if (snapshot.get("role") ==
                                            "visiteur") {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePageVisitor()));
                                        }
                                      });
                                    });
                                  }
                                  errorMessage = '';
                                } on FirebaseAuthException catch (error) {
                                  errorMessage = error.message!;
                                  Fluttertoast.showToast(
                                      msg: errorMessage,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 10.0);
                                }

                                //Navigator.push(context, MaterialPageRoute(builder:(context)=> Sign()));
                              }
                            }
                          });
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.green.shade300,
                                      Colors.grey
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 1))
                                ]),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  Container buildLoginScreen() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            buildMailLoginField(),
            SizedBox(
              height: 20,
            ),
            buildPasswordLoginField()
          ],
        ));
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildNameField(),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            buildMailField(),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            buildPasswordField(),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            buildConfirmPasswordField(),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            buildPhoneField(),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisitor = true;
                        _person = "visiteur";
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: isVisitor
                                ? Colors.green.shade300
                                : Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: isVisitor
                                    ? Colors.transparent
                                    : Colors.green.shade300),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.person,
                            color: isVisitor ? Colors.white : Colors.green[300],
                          ),
                        ),
                        Text(
                          "Visitor",
                          style: GoogleFonts.nunito(
                              color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisitor = false;
                        _person = "proprietaire";
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: isVisitor
                                ? Colors.transparent
                                : Colors.green.shade300,
                            border: Border.all(
                                width: 1,
                                color: isVisitor
                                    ? Colors.green.shade300
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.person,
                            color: isVisitor
                                ? Colors.green.shade300
                                : Colors.white,
                          ),
                        ),
                        Text(
                          "Parking Owner",
                          style: GoogleFonts.nunito(
                              color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      controller: _name,
      onChanged: (newValue) => name = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return 'name is  required';
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
          hintText: "User Name",
          hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          contentPadding: EdgeInsets.all(10)),
    );
  }

  TextFormField buildMailField() {
    String? validateEmail(String? formEmail) {
      if (formEmail == null || formEmail.isEmpty)
        return 'E-mail address is required.';
      String pattern = r'\w+@\w+\.\w+';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

      return null;
    }

    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      onChanged: (newValue) => email = newValue,
      validator: validateEmail,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.grey,
          ),
          hintText: "Email",
          hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          contentPadding: EdgeInsets.all(10)),
    );
  }

  TextFormField buildPasswordField() {
    String? validatePassword(String? formPassword) {
      if (formPassword == null || formPassword.isEmpty)
        return 'Password is required.';
      String pattern = r'^.{6,}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formPassword))
        return '''Password must be at least 6 characters''';

      return null;
    }

    return TextFormField(
      controller: _password,
      obscureText: true,
      onChanged: (newValue) => password = newValue,
      validator: validatePassword,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
          hintText: "Password",
          hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          contentPadding: EdgeInsets.all(10)),
    );
  }

  TextFormField buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPassword,
      obscureText: true,
      onChanged: (newValue) => confirmPassword = newValue,
      validator: (val) {
        if (val!.isEmpty) return 'Confirm Password is required';
        if (val != _password.text) return 'Those passwords didn’t match';
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
          hintText: "Confirm Password",
          hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          contentPadding: EdgeInsets.all(10)),
    );
  }

  TextFormField buildPhoneField() {
    String? validatePhone(String? formPhone) {
      if (formPhone == null || formPhone.isEmpty) return 'phone   is required.';
      String pattern = r'^.{8,8}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formPhone)) return '''phone must  8 number''';

      return null;
    }

    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _phone,
      onChanged: (newValue) => phone = newValue,
      validator: validatePhone,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.grey,
          ),
          hintText: "Phone number",
          hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          contentPadding: EdgeInsets.all(10)),
    );
  }

  TextFormField buildMailLoginField() {
    String? validateEmail(String? formEmail) {
      if (formEmail == null || formEmail.isEmpty)
        return 'E-mail address is required.';
      String pattern = r'\w+@\w+\.\w+';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

      return null;
    }

    return TextFormField(
      controller: _emailLogincontroller,
      keyboardType: TextInputType.emailAddress,
      onChanged: (newValue) => emailLogin = newValue,
      validator: validateEmail,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.grey,
          ),
          hintText: "Email",
          hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          contentPadding: EdgeInsets.all(10)),
    );
  }

  TextFormField buildPasswordLoginField() {
    String? validatePassword(String? formPassword) {
      if (formPassword == null || formPassword.isEmpty)
        return 'Password is required.';
      String pattern = r'^.{6,}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formPassword))
        return '''Password must be at least 6 characters''';

      return null;
    }

    return TextFormField(
      controller: _passwordLogincontroller,
      obscureText: true,
      onChanged: (newValue) => passwordLogin = newValue,
      validator: validatePassword,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
          hintText: "Password",
          hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          contentPadding: EdgeInsets.all(10)),
    );
  }
}

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text(error)
      ],
    );
  }
}
