import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/Views/park_owner/showReservation.dart';
class DatabaseReserv extends ShowReservation {
   late FirebaseFirestore
     firestore ;

  DatabaseReserv({required String idPark , required nombre_place }) : super(idPark: idPark , nbre_de_place: nombre_place);
  initiliase(){
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async{
    QuerySnapshot querySnapshot ;
    List docs=[];
    var current_user= FirebaseAuth.instance.currentUser;
    try{
      querySnapshot = 
         await  firestore.collection('reservation').where("park",isEqualTo: "/parking/"+idPark).get()   ;
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList() ){
          Map a = {"id":doc.id , "plate_number":doc["plate_number"],"name":doc["name"],"phone_number":doc["phone_number"],"start_time":doc["start_time"],"finish_time":doc["finish_time"],"idPlace":doc["idPlace"]};
          docs.add(a);
        } 
        return docs ;
      }
    } catch (e){
       print(e);
    }
    return docs ;
  }
}