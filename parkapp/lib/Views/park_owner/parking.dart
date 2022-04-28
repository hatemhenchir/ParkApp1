import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/form_add.dart';
import 'package:flutter_application_2/Views/park_owner/park.dart';
import 'package:flutter_application_2/Views/park_owner/parking.dart';

class Parking extends StatelessWidget {
  

  List<Mycard> mycard = [
     Mycard(Icons.add_outlined, 'Add Parking',true, 1),
     Mycard(Icons.visibility, 'Consult Parking',false , 2),
     Mycard(Icons.update, 'Update Parking',false , 3),
     Mycard(Icons.delete, 'Delete Parking',false ,4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        //title: const Text("",
        //),
      ),

      body: Column(
        children:  <Widget>[
          const Padding(
            padding:EdgeInsets.all(30.0),
            child : Text('Choose your parking activity',
               style: TextStyle(
                  fontSize: 25,
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
                     Navigator.push(context , MaterialPageRoute(builder: (_)=> FormAddPark()));
                   } else if (e.id==2){
                     Navigator.push(context , MaterialPageRoute(builder: (_)=> ConsultPark()));
                   } else if (e.id==3){
                     Navigator.push(context , MaterialPageRoute(builder: (_)=> Parking()));
                   } else if (e.id==4){
                     Navigator.push(context , MaterialPageRoute(builder: (_)=> Parking()));
                   }
              
                },
                child: Card(
                  elevation: 2.5,
                  color:e.isActive ? Colors.purple[800] : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Icon(
                          e.icon,
                          size: 50,
                          color:e.isActive ? Colors.white :  Colors.purple[800] ,),
                        const SizedBox(height: 1,),
                        
                        
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
  bool isActive = false ;
  int id;

  Mycard(this.icon , this.title , this.isActive , this.id);
}
