
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolling_switch/rolling_switch.dart';
//import 'package:toggle_switch/toggle_switch.dart';
var dataplaces;

class StatePlaces extends StatefulWidget {
   StatePlaces({Key? key, required this.idPark, required this.nbre_de_place}) : super(key: key);
  final String idPark;
  String nbre_de_place;

  @override
  State<StatePlaces> createState() => _StatePlacesState();
}


class _StatePlacesState extends State<StatePlaces> {
  var nbre = 4;

Map<String, bool> numbers = {};



@override
void initState() {
  super.initState();
  Future.delayed(Duration.zero,() async {
        initNumbers();
  });
    
  
  
}
Future <Map<String, bool>> initNumbers()async{
   dataplaces=await FirebaseFirestore.instance.collection("places").doc(widget.idPark).get();
   
  //print("dataplaces=${dataplaces.data()?["place_libre"]}");
  for(int  i=0;i<int.parse(widget.nbre_de_place);i++){
  numbers.addAll({"$i":dataplaces.data()["$i"]});
  }
  print("numbers  lkoll  =$numbers");
  return numbers;
}


  @override
  Widget build (BuildContext context)  {
    

    initNumbers();
    print("numbers=$numbers");
   
    


    return Scaffold(
       
        body: SingleChildScrollView(
          child: Center(
            
            child: Container(
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  for (int i = 0; i < int.parse(widget.nbre_de_place); i++)  MyToggleList(i),
                ],
              ),
            ),
          ),
        ));
  }

  Widget MyToggleList(int i) {
    return Row(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Column(
            children: [
              Text(
                "Place n° $i : ",
                style:  GoogleFonts.nunito (
                              letterSpacing: 1,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color:  Colors.blueGrey.shade800 ),
              ),
              SizedBox(
                height: 10,
              ),
             // menuItem(i),
            ],
          ),
        
        ),
        Column(
         children:  [
           menuItem(i),
           SizedBox(height: 18,)],
         
        )
      ],
    );
  }

  Widget menuItem(i) {
    
    return Material(
      
      child: StreamBuilder<DocumentSnapshot<Map<String , dynamic>>>(
       
        stream: FirebaseFirestore.instance.collection("places").doc(widget.idPark).snapshots(),
        
        builder: (context, snapshot)  {
         while (snapshot.connectionState == ConnectionState.waiting) {
          return  
          CircularProgressIndicator();
          
         } 
              var stateplace=snapshot.data?.data()?['$i'];
          print("stateplace=$stateplace");
          
        return 
          RollingSwitch.icon(
         
          initialState: numbers['$i'] ??dataplaces.data()['$i']   ,
           
          onChanged: (bool state) async{
      
            numbers.addAll({"${i}":state});
            print('turned ${i} ${(state) ? 'on' : 'off'}');
            print("${numbers}");
            print("nbre de palace  =${int.parse(widget.nbre_de_place)} ");
            
            
            int  count=0;
            for(int  i=0;i<numbers.length;i++){
                if ( (numbers["${i}"]==false)){
                    count+=1;
                }
      
            }
            print("place libre = ${count}");
            print("hhhhh ${numbers}");

            await FirebaseFirestore.instance.collection("places").doc(widget.idPark).update({"place_libre":count,
            "$i": state});
            setState(() {
              
            });
          },
          rollingInfoRight: RollingIconInfo(
            
            icon: Icons.flag,
             backgroundColor: Colors.red.shade400,
            text: Text('Full'),
          ),
          rollingInfoLeft:  RollingIconInfo(
            icon: Icons.check,
            backgroundColor: Colors.green.shade400,
            text: Text('Empty'),
          ),
          
        );
      
           
        
          },
      ),
    );
  }

 
}