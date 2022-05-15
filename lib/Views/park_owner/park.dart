import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/database.dart';
import 'package:flutter_application_2/Views/park_owner/form_addPark.dart';
import 'package:flutter_application_2/Views/park_owner/form_updatePark.dart';
import 'package:flutter_application_2/Views/park_owner/update_park.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';



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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          
          "Consult Parking" , 
          style: TextStyle(
            fontSize:20 ),),

        actions: [
          IconButton(
            onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder:(context)=> FormAddPark()));
            }, 
            icon: Icon(Icons.library_add),
            iconSize: 30,
            padding: EdgeInsets.symmetric(horizontal: 20),)
        ],
            ),

            
      
      body:RefreshIndicator(
        onRefresh: () async { 
          //Navigator.push(context,MaterialPageRoute(builder:(context)=> ConsultPark()));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ConsultPark()));
         },
        child: ListView.builder(
                
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
                     FirebaseFirestore.instance.collection("parking").doc(docs[index]["id"]).delete();
                     Navigator.push(context,MaterialPageRoute(builder:(context)=> ConsultPark()));
                     
                   },
                   
                    
                   
                   backgroundColor: Colors.deepOrange,
                   foregroundColor: Colors.white,
                   icon: Icons.delete,
                   label: 'Delete',
                   
                   
                ),
                SlidableAction(
                   onPressed:(BuildContext context) {
                     print(docs[index]["id"]);
                     Navigator.push(context, MaterialPageRoute(builder:(context)=>  UpdatePark(tarif: docs[index]["tarif"], id: docs[index]["id"],name:docs[index]["name"],nbr_de_place:docs[index]["nbre_de_place"])));
                   } ,
                   backgroundColor: Colors.greenAccent,
                   foregroundColor: Colors.white,
                   icon: Icons.update_outlined,
                   label: 'Update',
                  
                   ),
               ],
            ),
            
            
            child:ListTile(
                  title: Text("Tarif: ${docs[index]['tarif']} Nom:${docs[index]["name"]} longtitude:${docs[index]["longtitude"]} latitude:${docs[index]["latitude"]} nombre de  place :${docs[index]["nbre_de_place"]}" , style: TextStyle(fontSize: 20),),
                   minVerticalPadding: 20,
                  
                   
                  //trailing: Text("Adresse: "+docs[index]['adresse'] ,  style: TextStyle(fontSize: 20)),
                ),
                

            );
        }),
      
    ));
    
    
  }

 

  
}

   
  


