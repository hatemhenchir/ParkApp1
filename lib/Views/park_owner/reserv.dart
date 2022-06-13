
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/database.dart';

import 'package:flutter_application_2/Views/park_owner/showReservation.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_fonts/google_fonts.dart';



class Reserv extends StatefulWidget {
   Reserv({ Key? key }) : super(key: key);

   

  @override
  _ReservState createState() => _ReservState();
}

class _ReservState extends State<Reserv> {
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
        backgroundColor: Colors.blueGrey.shade700,
        
      
            ),

            
      
      body:RefreshIndicator(
        onRefresh: () async { 
          //Navigator.push(context,MaterialPageRoute(builder:(context)=> ParkPlace()));
         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ParkPlace()));
         },
        child: ListView.separated(
                
        itemCount: docs.length,
        itemBuilder: (BuildContext context , int index){
          return Slidable(
            key: ValueKey(index),
            startActionPane: ActionPane(
           
              motion: ScrollMotion(),
              children: [
                 SlidableAction(

                   
                   onPressed:
                   (BuildContext context){
                     //print(docs[index]["id"]);
                     //print(docs[index]["nbre_de_place"]);
                     //FirebaseFirestore.instance.collection("parking").doc(docs[index]["id"]).delete();
                    
                    print(docs[index]["id"]);
                   
                     Navigator.push(context,MaterialPageRoute(builder:(context)=> ShowReservation(idPark:docs[index]["id"],nbre_de_place:docs[index]["nbre_de_place"])));
                     
                   },
                   
                     
                   
                   backgroundColor: Colors.green.shade300,
                   foregroundColor: Colors.white,
                   icon: Icons.check,
                   label: 'Show Reservation',
                   
                   
                ),
               
               ],
            ),
            
            

            child:ListTile(
               tileColor: Colors.grey.shade300,
                  title: Text("Parking name:  ${docs[index]["name"]} " , style: GoogleFonts.nunito (
                          
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87 ),),
                   minVerticalPadding: 20,
                  
                   
                  //trailing: Text("Adresse: "+docs[index]['adresse'] ,  style: TextStyle(fontSize: 20)),
                ),
                

            );
        }, separatorBuilder: (BuildContext context, int index) => Container(height: 8,),),
      
    ));
    
    
  }

 

  
}

   
  
