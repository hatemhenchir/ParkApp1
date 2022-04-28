import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';




  class Search extends StatefulWidget {
   const Search({ Key? key }) : super(key: key);
 
   @override
   _SearchState createState() => _SearchState();
  
  }
 class _SearchState extends State<Search> {

   @override
   Widget build(BuildContext context) {
     final currentPosition=Provider.of<Position?>(context);
     

     return Scaffold(

      body:(currentPosition!=null)? Column (
        
         children: [
           
           Container (
             height: MediaQuery.of(context).size.height/1.2,
             width:  MediaQuery.of(context).size.width,
             child:  GoogleMap(
                mapType: MapType.normal,
               
               initialCameraPosition: CameraPosition(
                 target:LatLng(
                   currentPosition.latitude,
                   currentPosition.longitude ),
                 zoom: 30.0,
                 ) ,
                 zoomGesturesEnabled: true,
                ),
             ),
           
         ],
       
       
     
     ):Center(child: CircularProgressIndicator(),)
   );
 }
 }