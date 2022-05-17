import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/login.dart';
import 'package:flutter_application_2/Views/park_owner/park.dart';
import 'package:flutter_application_2/Views/park_owner/park_place.dart';



class Choice extends StatelessWidget {
  

  List<Mycard> mycard = [
     Mycard(Icons.local_parking_outlined, 'Park',false , 1),
     Mycard(Icons.place_outlined, 'Place',false , 2 ),
     Mycard(Icons.book_online, 'Reservation',false ,3),
     Mycard(Icons.person, 'Note Visitor',false , 4),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        
      actions: [
          IconButton(
            onPressed:()async{
              
              await FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder:(context)=> Login()));
            
            //setState(() {});
            }, 
            icon: Icon(Icons.logout),
            iconSize: 30,
            padding: EdgeInsets.symmetric(horizontal: 20),)
        ],
      ),

      body: Column(
        children:  <Widget>[
          const Padding(
            padding:EdgeInsets.all(30.0),
            child : Text('Choose your activity',
               style: TextStyle(
                  fontSize: 30,
                  color: Colors.black54),
                  ),
                  ),

          Expanded(
            child:GridView(
              
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
              children: 
              mycard.map((e) => InkWell(
                onTap: () {
                  if(e.id==1){
                   Navigator.push(context , MaterialPageRoute(builder: (_)=> ConsultPark()));
                  } else if (e.id==2){
                    Navigator.push(context , MaterialPageRoute(builder: (_)=> ParkPlace()));
                  } else if (e.id==3){
                    Navigator.push(context , MaterialPageRoute(builder: (_)=> ConsultPark()));
                  } else if (e.id==4){
                    Navigator.push(context , MaterialPageRoute(builder: (_)=> ConsultPark()));
                  }
                  
                },
                child: Card(
                  elevation: 2.5,
                  color:e.isActive ? Colors.teal : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Icon(
                          e.icon,
                          size: 50,
                          color:e.isActive ? Colors.white :  Colors.teal ,),
                        const SizedBox(height: 10,),
                        Text(
                          e.title,
                          style: 
                             TextStyle(
                               fontSize: 20,
                              color: e.isActive ? Colors.white : Colors.grey
                            ),)
                  ]),
                ),
              )).toList(),
            ) )

        ],
      ),
      
    );
  }
}

class Mycard{
  final icon ;
  final title ;
  bool isActive  ;
  int id;

  Mycard(this.icon , this.title , this.isActive , this.id);
}