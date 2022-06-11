import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/New_Park.dart';
import 'package:flutter_application_2/Views/park_owner/database.dart';

import 'package:flutter_application_2/Views/park_owner/update_park.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_fonts/google_fonts.dart';




class ConsultPark extends StatefulWidget {
   ConsultPark({ Key? key }) : super(key: key);

   

  @override
  _ConsultParkState createState() => _ConsultParkState();
}

class _ConsultParkState extends State<ConsultPark> {
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => NewConsultPark()));
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
                       print(docs[index]["id"]);
                       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>  UpdatePark(tarif: docs[index]["tarif"], id: docs[index]["id"],name:docs[index]["name"],nbr_de_place:docs[index]["nbre_de_place"])));
                       
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
                       //print(docs[index]["id"]);
                       FirebaseFirestore.instance.collection("parking").doc(docs[index]["id"]).delete();
                       FirebaseFirestore.instance.collection("places").doc(docs[index]["id"]).delete();
                       Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=> NewConsultPark()));
                       
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
                
                    title: Text(" Name:  ${docs[index]['name']} \n Fees:   ${docs[index]["tarif"]} DT \n Total nembre places:  ${docs[index]["nbre_de_place"]}" , 
                    style: GoogleFonts.nunito(
                                  fontSize: 20 ,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600
                                ),
                    ),
                     minVerticalPadding: 20,
                    
                     
                    //trailing: Text("Adresse: "+docs[index]['adresse'] ,  style: TextStyle(fontSize: 20)),
                  ),
                  
          
              ),
          );
            
        }, separatorBuilder: (BuildContext context, int index) => Container(height: 8,)
          
         ,),
      
    ));
    
    
  }

 

  
}

   
  


