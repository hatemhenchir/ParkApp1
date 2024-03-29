
import 'package:flutter/material.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/Views/newIntro.dart';
import 'package:flutter_application_2/Views/services/geolocator_services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';



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
      child:   const MaterialApp(
        debugShowCheckedModeBanner: false,//supprimer debug icone in the interface
        title: 'flutter app',
        home: IntroScreen(),
        

      ),
    );
    
  }
  
}


