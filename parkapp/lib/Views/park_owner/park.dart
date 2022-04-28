import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/database.dart';



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
        title: Text(
          
          "Consult Parking" , 
          style: TextStyle(
            fontSize:20 ),)),
      
      body: ListView.builder(
        
        itemCount: docs.length,
        itemBuilder: (BuildContext context , int index){
          return Card(
            margin: EdgeInsets.all(30),
            child: ListTile(
              onTap: () {
                
              },
              contentPadding: EdgeInsets.only(right: 20 , left: 20),
              title: Text("tarif: "+docs[index]['tarif'] , style: TextStyle(fontSize: 20),),
              minVerticalPadding: 20,
              trailing: Text("adresse: "+docs[index]['adresse'] ,  style: TextStyle(fontSize: 20)),
              
              
              ),
          );
        })
      
    );
  }
}