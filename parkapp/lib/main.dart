//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/chose_account.dart';

import 'package:flutter_application_2/Views/intro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/Views/login.dart';
import 'package:flutter_application_2/Views/park_owner/choice_activity.dart';
import 'package:flutter_application_2/Views/services/geolocator_services.dart';
import 'package:flutter_application_2/Views/visitor/app_bar.dart';
import 'package:flutter_application_2/Views/sign.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_2/Views/park_owner/form_add.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}):super(key: key);
   final locatorService=GeoLocatorService();
  @override
  Widget build(BuildContext context){
    return FutureProvider(
      create: (context)=>locatorService.getLocation(),
      initialData: null,
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,//supprimer debug icone in the interface
        title: 'flutter app',
        home: Login(),

      ),
    );
    
  }
}


