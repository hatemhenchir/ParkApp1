import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/visitor/showPark.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';




  class Search extends StatefulWidget {
   const Search({ Key? key }) : super(key: key);
 
   @override
   _SearchState createState() => _SearchState();
  
  }
 class _SearchState extends State<Search> {
   Set<Marker> _markers = {} ;
   
    void _onMapCreated(GoogleMapController controller){
      setState(() {
        
        _markers.add(
          Marker(
            markerId: const MarkerId('id-1'),
            position: LatLng(35.301699 , 11.034399),
            
            onTap:  (){
               Navigator.push(context, MaterialPageRoute(builder:(context)=> const showPark()));
            },
            infoWindow: const InfoWindow(
              title: 'Park',
              snippet: 'Smart Parking'
            )
            ),
        );
      });
    }


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
               onMapCreated: _onMapCreated,
               markers: _markers,
                mapType: MapType.normal,
               
               initialCameraPosition: CameraPosition(
                 target:LatLng(
                   currentPosition.latitude,
                   currentPosition.longitude ),
                 zoom: 9.0,
                 ) ,
                 zoomGesturesEnabled: true,
                ),
             ),
           
         ],
       
       
     
     ):const Center(child: CircularProgressIndicator(),)
   );
 }
 }