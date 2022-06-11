
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/Views/visitor/New_login.dart';
import 'package:flutter_application_2/Views/visitor/consult_reservation.dart';

import 'package:flutter_application_2/Views/visitor/search_park.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePageVisitor extends StatefulWidget {
   HomePageVisitor({ Key? key ,}) : super(key: key);

 
  @override
  State<HomePageVisitor> createState() => _HomePageVisitorState();
}

class _HomePageVisitorState extends State<HomePageVisitor> {
   Set<Marker> _markers = {};
   
  GlobalKey<CurvedNavigationBarState> _NavKey = GlobalKey(); 
  var AllPages = [Search(), ConsultReservation() , ];
  var myindex =  0;

 
  
 

  
  @override
  Widget build(BuildContext context) {
    
    
    final currentPosition = Provider.of<Position?>(context);
    return Scaffold(
     // backgroundColor: Colors.green.shade300,
      bottomNavigationBar: CurvedNavigationBar(
        key: _NavKey,
        backgroundColor: Colors.white,
        color: Colors.green.shade300,
        animationDuration: Duration(microseconds: 0),
        animationCurve: Curves.fastLinearToSlowEaseIn,
        onTap: (index){
         setState(() {
           myindex = index ;
         });
        },
        items: const [
          Icon(Icons.home ,
          color: Colors.white,
          size: 30,),
          Icon(Icons.book_online_outlined,
          color: Colors.white,
          size: 30,),
         
        ]),
         body: Stack(
           children: [
             Container(
               child: AllPages[myindex],
             ),
              Positioned(
             top: 60.0,
             right: 10.0,
             child: CircleAvatar(
               backgroundColor:Colors.grey.withOpacity(0.5) ,
              child: IconButton(
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
                onPressed: ()async{
                  await FirebaseAuth.instance.signOut();
                   Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen(),
                ),
                (route) => false,
              );
                },
                 ),
                 )
             ),
           ],),
        
    );
  }
}