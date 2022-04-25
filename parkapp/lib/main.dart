//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/chose_account.dart';
import 'package:flutter_application_2/Views/intro.dart';
import 'package:flutter_application_2/Views/routes.dart';
import 'package:flutter_application_2/Views/login.dart';
import 'package:flutter_application_2/Views/sign.dart';
import 'package:flutter_application_2/Views/park/form_add.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,//supprimer debug icone in the interface
      title: 'flutter app',
      home: Intro(),
      
    );
  }
}


