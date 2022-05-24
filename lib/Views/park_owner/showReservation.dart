import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/New_Park.dart';
import 'package:flutter_application_2/Views/park_owner/database.dart';
import 'package:flutter_application_2/Views/park_owner/databaseRserv.dart';
import 'package:flutter_application_2/Views/park_owner/form_addPark.dart';

import 'package:flutter_application_2/Views/park_owner/update_park.dart';
import 'package:flutter_application_2/Views/park_owner/visualize_parkMap.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';




class ShowReservation extends StatefulWidget {
  ShowReservation({ Key? key  , required this.idPark }) : super(key: key);

  final String idPark;
  

  @override
  _ShowReservationState createState() => _ShowReservationState();
}

class _ShowReservationState extends State<ShowReservation> {
  
    late DatabaseReserv db;
  List docs= [];
  String id = "";
  initialise( ){
    db = DatabaseReserv(idPark: widget.idPark,);
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
       backgroundColor: Colors.white,    
      //appBar: AppBar(
      //  backgroundColor: Colors.teal,
      //  title: const Text(
          
      /*    "Consult Parking" , 
          style: TextStyle(
            fontSize:20 ),),

        actions: [
          IconButton(
            onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder:(context)=> FormAddPark()));
            }, 
            icon: Icon(Icons.library_add),
            iconSize: 30,
            padding: EdgeInsets.symmetric(horizontal: 20),),
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=> VisializePark()));
            }, 
          icon: Icon(Icons.local_parking),
            iconSize: 30,
            padding: EdgeInsets.symmetric(horizontal: 20),),
        ],
            ),*/

            
      
      body:RefreshIndicator(
        
        
        onRefresh: () async { 
          //Navigator.push(context,MaterialPageRoute(builder:(context)=> ConsultPark()));
        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => NewConsultPark()));
         },
        child: ListView.separated(
         
        itemCount: docs.length,
        itemBuilder: (BuildContext context , int index){
          return ClipRRect(
            
            borderRadius: BorderRadius.circular(15),
            child: Slidable(
              
              key: ValueKey(index),
              startActionPane: ActionPane(
                
                motion: StretchMotion(),
                children: [
                  
              
                 ],
              ),
              endActionPane: ActionPane(
   motion: StretchMotion(),
                children: [
                  SlidableAction(
                    
                     onPressed:
                     (BuildContext context){
                       //print(docs[index]["id"]);
                       FirebaseFirestore.instance.collection("parking").doc(docs[index]["id"]).delete();
                      // Navigator.push(context,MaterialPageRoute(builder:(context)=> ConsultPark()));
                       
                     },
            
                     backgroundColor: Colors.deepOrange,
                     foregroundColor: Colors.white,
                     icon: Icons.delete,
                     label: 'Delete',
                     spacing: 4,
                     
                     
                  ),
                  
                 ],
  ),
              
              child:ListTile(
                tileColor: Colors.grey.shade200,
                
                    title: Text(" Name:  ${docs[index]['name']} \n Plate number:   ${docs[index]["plate_number"]}  \n Phone number:  ${docs[index]["phone_number"]} \n Start time:   ${docs[index]["start_time"]} \n Finish time:   ${docs[index]["finish_time"]}" , 
                    style: GoogleFonts.nunito(
                                  fontSize: 20 ,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600
                                ),
                    ),
                     minVerticalPadding: 20,
                     
                    trailing: FloatingActionButton(
                     onPressed: () async {
                      
                       FirebaseFirestore.instance.collection("reservation").doc(docs[index]['id']).update({
                        "State":"valide"
                       });
  
                     },
                      child: Text("valid"),
                      backgroundColor: Colors.pink,),

                     
                      
                      
                   
                  ),
                  
          
              ),
          );
            
        }, separatorBuilder: (BuildContext context, int index) => Container(height: 8,)
          
         ,),
      
    ));
    
    
  }

 

  
}

   
  


