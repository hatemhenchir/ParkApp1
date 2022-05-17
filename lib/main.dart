
import 'package:flutter/material.dart';
//import 'package:flutter_application_2/Views/chose_account.dart';

import 'package:flutter_application_2/Views/intro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/Views/park_owner/choice_activity.dart';


import 'package:flutter_application_2/Views/park_owner/form_addPark.dart';
import 'package:flutter_application_2/Views/park_owner/mark.dart';
//import 'package:flutter_application_2/Views/park_owner/newupdate.dart';
//import 'package:flutter_application_2/Views/login.dart';
//import 'package:flutter_application_2/Views/park_owner/choice_activity.dart';
//import 'package:flutter_application_2/Views/park_owner/form_updatePark.dart';
//import 'package:flutter_application_2/Views/park_owner/park.dart';
import 'package:flutter_application_2/Views/services/geolocator_services.dart';
import 'package:flutter_application_2/Views/visitor/New_login.dart';
import 'package:flutter_application_2/Views/visitor/New_navBar.dart';
import 'package:flutter_application_2/Views/visitor/confirm.dart';


import 'package:flutter_application_2/Views/visitor/payment.dart';
//import 'package:flutter_application_2/Views/visitor/app_bar.dart';
//import 'package:flutter_application_2/Views/sign.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_application_2/Views/park_owner/form_addPark.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51KxRwtI5r7w4X89756fzSmvtmfTPU2UJn72pNoQRmsHQkbCE3x3TJ5Fb5rGT4qG0hkTR3TrhPvkZHPVcg4msXB1h001C2atZvH';
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
      child:   MaterialApp(
        debugShowCheckedModeBanner: false,//supprimer debug icone in the interface
        title: 'flutter app',
        home: Intro()
        

      ),
    );
    
  }
  
}


