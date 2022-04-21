import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    orientation = _mediaQueryData.orientation;
  }
}

//Obtenir la hauteur proportionnelle selon la taille de l'écran
 double getProportionateScreenHeight(double inputHeight){
   double screenHeight = SizeConfig.screenHeight;
   // 812 est la hauteur de mise en page utilisée par les developpeurs
   return(inputHeight / 812.0) * screenHeight;
 }

 //Obtenir la largeur proportionnelle selon la taille de l'écran
 double getProportionateScreenWidth(double inputWidth){
   double screenWidth = SizeConfig.screenWidth;
   // 375 est la hauteur de mise en page utilisée par les developpeurs
   return(inputWidth / 375.0) * screenWidth;
 }