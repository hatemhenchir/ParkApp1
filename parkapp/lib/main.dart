//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/chose_account.dart';
import 'package:flutter_application_2/Views/intro.dart';
import 'package:flutter_application_2/Views/routes.dart';
import 'package:flutter_application_2/Views/login.dart';
import 'package:flutter_application_2/Views/sign.dart';
import 'package:flutter_application_2/Views/park/form_add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,//supprimer debug icone in the interface
      title: 'flutter app',
      home: Body(),
      
    );
  }
}


