import 'package:flutter/material.dart';






//form Error
final RegExp emailValidatorRegExp = RegExp(r"[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kNameNullError = "Please Enter your name";
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Password don't match";
const String kPlateNullError = "Please Enter your car plate number";
const String kPhoneNullError = "Please Enter your phone number";
