import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/chose_account.dart';
import 'package:flutter_application_2/Views/intro.dart';
import 'package:flutter_application_2/Views/login.dart';
import 'package:flutter_application_2/Views/search_park.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

//import '../services/geolocator_service.dart';


class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  var currentPage = DrawerSections.Reservation;
  @override
  Widget build(BuildContext context) {
    var container ;
    if (currentPage == DrawerSections.Reservation){
      container = Intro();
    } else if (currentPage == DrawerSections.Payment){
      container = Login();
    } else if (currentPage == DrawerSections.Payment_method){
      container = ChoseAccount();
    } else if (currentPage == DrawerSections.Find_park){
      container = Search();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        
      ),
      body: container,

      drawer: Drawer(
        child: SingleChildScrollView(
          child:Container (
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
                
              ])
          ,) ),
      ),
      
    );
  }

  Widget MyDrawerList(){
    return Container(
      padding: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          menuItem(1 , "Find Parking", Icons.local_parking_outlined,
               currentPage == DrawerSections.Payment_method ? true : false),
          menuItem(2 , "Reservation", Icons.book_online_outlined,
               currentPage == DrawerSections.Reservation ? true : false),
          menuItem(3 , "Payment", Icons.payment_outlined , 
               currentPage == DrawerSections.Payment ? true : false),
          menuItem(4 , "Payment method", Icons.credit_score_outlined,
               currentPage == DrawerSections.Payment_method ? true : false),
          
        ],

      ),

    );

  }

  Widget menuItem(int id , String title , IconData icon , bool selected){
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1 ){
              currentPage = DrawerSections.Find_park;
            } else if (id == 2 ){
              currentPage = DrawerSections.Reservation;
            } else if (id == 3 ){
              currentPage = DrawerSections.Payment;
            } else if (id == 4 ){
              currentPage = DrawerSections.Payment_method;
            }
          });
        } ,
        child: Padding(
        padding: EdgeInsets.all(15.0) ,
        child:Row(
          children:  [
             Expanded(
              child: Icon(
                icon ,
                size: 20,
                color: Colors.black,)
                ),
            Expanded(
              flex: 1,
              child: 
              Text(
                title,
              style: TextStyle(color: Colors.black,fontSize: 20),))
          ]) ,
        ),
      )
    );
  }






}

enum DrawerSections {
  Find_park,
  Reservation ,
  Payment,
  Payment_method,



}









class MyHeaderDrawer extends StatefulWidget {
  

  @override
  _MyDrawerHeaderState createState() => _MyDrawerHeaderState();
}

class _MyHeaderDrawerState {
}

class _MyDrawerHeaderState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[700],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.asset("lib/img/logo_park.png" ,height: 80, ),
          Container(
            margin: EdgeInsets.only(bottom: 50),
            height: 50,
            
            
             
            
          )
        ],
      ),
    );
  }
}