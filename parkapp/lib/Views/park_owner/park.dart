import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/database.dart';
import 'package:flutter_application_2/Views/park_owner/form_addPark.dart';
import 'package:flutter_application_2/Views/park_owner/form_updatePark.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



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

            
      
      body: ListView.builder(
        
        itemCount: docs.length,
        itemBuilder: (BuildContext context , int index){
          return Slidable(
            startActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                 SlidableAction(
                   onPressed:
                   showDeleteAlert(context),
                    
                   
                   backgroundColor: Colors.deepOrange,
                   foregroundColor: Colors.white,
                   icon: Icons.delete,
                   label: 'Delete',
                   
                ),
                SlidableAction(
                   onPressed:(BuildContext context) {
                     Navigator.push(context, MaterialPageRoute(builder:(context)=> FormUpdatePark( )));
                   } ,
                   backgroundColor: Colors.greenAccent,
                   foregroundColor: Colors.white,
                   icon: Icons.update_outlined,
                   label: 'Update',
                  
                   ),
               ],
            ),
            
            
            child:ListTile(
                  title: Text("Tarif: "+docs[index]['tarif'] , style: TextStyle(fontSize: 20),),
                   minVerticalPadding: 20,
                  
                   
                  //trailing: Text("Adresse: "+docs[index]['adresse'] ,  style: TextStyle(fontSize: 20)),
                ),
                

            );
        }),
      
    );
    
    
  }

  
}

   showDeleteAlert(BuildContext context) {
    

    Widget noButton = TextButton(
      onPressed: (){
        Navigator.pop(context);
        
      }, 
      child: const Text("No" , style: TextStyle(
        color:Colors.black ),)
    );

    Widget yesButton = TextButton(
      onPressed: (){}, 
      child: const Text("Yes" , style: TextStyle(
        color:Colors.black ),)
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
      content: const Text("Would you like to delete this parking ?"),
      actions: [
        noButton,
        yesButton
      ],
    );
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return alert;
      }
    );
}
  


