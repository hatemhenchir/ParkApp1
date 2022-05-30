import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/database.dart';
import 'package:flutter_application_2/Views/park_owner/form_addPark.dart';

import 'package:flutter_application_2/Views/park_owner/place.dart';
import 'package:flutter_application_2/Views/park_owner/update_park.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ParkPlace extends StatefulWidget {
   ParkPlace({ Key? key }) : super(key: key);

   

  @override
  _ParkPlaceState createState() => _ParkPlaceState();
}

class _ParkPlaceState extends State<ParkPlace> {
    late Database db;
  List docs= [];
  initialise(){
    db = Database();
    db.initiliase();
    db.read().then((value) => {
      setState(() {
      docs = value;
    })
    },);
   
    
  }
  @override
  void initState(){
    super.initState();
    initialise();
  }
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
       /* title: const Text(
          
          "Parking exist" , 
          style: TextStyle(
            fontSize:20 ),),*/

     /*   actions: [
          IconButton(
            onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder:(context)=> FormAddPark()));
            }, 
            icon: Icon(Icons.library_add),
            iconSize: 40,
            color: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 20),)
        ],*/
            ),

            
      
      body:RefreshIndicator(
        onRefresh: () async { 
          //Navigator.push(context,MaterialPageRoute(builder:(context)=> ParkPlace()));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ParkPlace()));
         },
        child: ListView.separated(
                
        itemCount: docs.length,
        itemBuilder: (BuildContext context , int index){
          return Slidable(
            key: ValueKey(index),
            startActionPane: ActionPane(
              //dismissible: DismissiblePane(onDismissed: (){},),
              motion: ScrollMotion(),
              children: [
                 SlidableAction(
                   
                   onPressed:
                   (BuildContext context){
                     //print(docs[index]["id"]);
                     print(docs[index]["nbre_de_place"]);
                     //FirebaseFirestore.instance.collection("parking").doc(docs[index]["id"]).delete();
                     Navigator.push(context,MaterialPageRoute(builder:(context)=> StatePlaces(idPark:docs[index]["id"],nbre_de_place:docs[index]["nbre_de_place"])));
                     
                   },
                  
                   backgroundColor: Colors.red.shade200,
                   foregroundColor: Colors.white,
                   icon: Icons.check,
                   label: 'Consult place',
                   
                   
                   
                ),
               
               ],
            ),
            
            
            child:ListTile(
               tileColor: Colors.grey.shade200,
                  title: Text("Parking name:  ${docs[index]["name"]} \nTotal nembre places:  ${docs[index]["nbre_de_place"]}" , 
                  style:  GoogleFonts.nunito (
                          
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87 ),),
                   minVerticalPadding: 20,
                  
                   
                  //trailing: Text("Adresse: "+docs[index]['adresse'] ,  style: TextStyle(fontSize: 20)),
                ),
                

            );
        }, separatorBuilder: (BuildContext context, int index) => Container(height: 8,),),
      
    ));
    
    
  }

 

  
}

   
  
