import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseReservation{
late FirebaseFirestore  firestore ;
  initiliase(){
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async{
    QuerySnapshot querySnapshot ;
    List docs=[];
    var current_user= FirebaseAuth.instance.currentUser;
    try{
      querySnapshot = 
         await  firestore.collection('reservation').where("user",isEqualTo: "/utilisateur/"+current_user!.uid).get()   ;
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList() ){
          Map a = {"id":doc.id , "finish_time":doc["finish_time"],"name":doc["name"],"phone_number":doc["phone_number"],"plate_number":doc["plate_number"],"start_time":doc["start_time"], "idPlace":doc["idPlace"]};
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