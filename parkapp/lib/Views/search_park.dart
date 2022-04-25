import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

//import '../services/geolocator_service.dart';


  class Search extends StatefulWidget {
   const Search({ Key? key }) : super(key: key);
 
   @override
   _SearchState createState() => _SearchState();
  
  }
 class _SearchState extends State<Search> {
   @override
   Widget build(BuildContext context) {
     

     return Scaffold(

       body: Column (
        
         children: [
           
           Container (
             height: MediaQuery.of(context).size.height/2,
             width:  MediaQuery.of(context).size.width,
             child: const GoogleMap(
                mapType: MapType.normal,
               
               initialCameraPosition: CameraPosition(
                 target:LatLng(36.806389,10.181667 , ),
                 zoom: 30.0,
                 ) ,
                ),
             ),
           
         ],
       ),
       
     );
   }
 }