import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Database {
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
         await  firestore.collection('parking').where("user",isEqualTo: "/utilisateur/"+current_user!.uid).get()   ;
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList() ){
          Map a = {"id":doc.id , "tarif":doc["tarif"],"name":doc["name"],"latitude":doc["latitude"],"longtitude":doc["longtitude"],"nbre_de_place":doc["nbre_de_place"]};
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