import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/add_reservation.dart';

import 'package:flutter_application_2/Views/park_owner/databaseRserv.dart';
import 'package:flutter_application_2/Views/park_owner/update_reservation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';





class ShowReservation extends StatefulWidget {
  ShowReservation({ Key? key  , required this.idPark , required this.nbre_de_place }) : super(key: key);

  final String idPark;
  final String nbre_de_place;

  @override
  _ShowReservationState createState() => _ShowReservationState();
}

class _ShowReservationState extends State<ShowReservation> {
  
    late DatabaseReserv db;
  List docs= [];
  String id = "";
  initialise( ){
    db = DatabaseReserv(idPark: widget.idPark , nombre_place:  widget.nbre_de_place,);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 1,
          backgroundColor: Colors.blueGrey.shade400,
          onPressed: () async {
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> AddReserv(idPark:widget.idPark , nombre_place:widget.nbre_de_place)));
     
          },
          label: Text(
            "Add Reservation",
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),
      body:Stack(
        children: [ 
        
          RefreshIndicator(
         
          onRefresh: () async { 
            //Navigator.push(context,MaterialPageRoute(builder:(context)=> ConsultPark()));
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ShowReservation()));
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

                  SlidableAction(
                     onPressed:(BuildContext context) {
                       Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=> updateReserv( idReserv:docs[index]["id"],idPark: widget.idPark, nombre_place:widget.nbre_de_place ,start_time:docs[index]["start_time"], finish_time:docs[index]["finish_time"] ,idPlace:docs[index]["idPlace"] ,plate_number: docs[index]["plate_number"])));
                     
                     } ,
                     backgroundColor: Colors.greenAccent,
                     foregroundColor: Colors.white,
                     icon: Icons.update_outlined,
                     label: 'Update',
                     
                    
                     ),
                 ],
              ),
                endActionPane: ActionPane(
         motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      
                       onPressed:
                       (BuildContext context){
                         print(docs[index]["id"]);
                         FirebaseFirestore.instance.collection("reservation").doc(docs[index]["id"]).delete();
                        // Navigator.push(context,MaterialPageRoute(builder:(context)=> ConsultPark()));
                         
                       },
              
                       backgroundColor: Colors.deepOrange.shade600,
                       foregroundColor: Colors.white,
                       icon: Icons.delete,
                       label: 'Delete',
                       spacing: 4,
                       
                       
                    ),
                    
                   ],
        ),
                
                child:ListTile(
                  tileColor: Colors.grey.shade200,
                  
                      title: Text(" Name:  ${docs[index]['name']} \n Plate number:   ${docs[index]["plate_number"]}  \n Phone number:  ${docs[index]["phone_number"]} \n Start time:   ${docs[index]["start_time"]} \n Finish time:   ${docs[index]["finish_time"]} \n idPlace : ${docs[index]["idPlace"]} " , 
                      style: GoogleFonts.nunito(
                                    fontSize: 20 ,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600
                                  ),
                      ),
                       minVerticalPadding: 20,
                       
                    /*  trailing: FloatingActionButton(
                        heroTag: 3,
                       onPressed: () async {
                        
                         FirebaseFirestore.instance.collection("reservation").doc(docs[index]['id']).update({
                          "State":"valide"
                         });
        
                       },
                        child: Text("valid"),
                        backgroundColor: Colors.indigo.shade200,),*/
      
                       
                        
                        
                     
                    ),
                    
            
                ),
            );
              
          }, separatorBuilder: (BuildContext context, int index) => Container(height: 8,)
            
           ,),
        
          ),]
      )
      );
    
    
  }

 

  
}

   
  


