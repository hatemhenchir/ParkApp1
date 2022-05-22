import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
//import 'package:toggle_switch/toggle_switch.dart';

class StatePlaces extends StatelessWidget {
   StatePlaces({Key? key, required this.idPark, required this.nbre_de_place}) : super(key: key);
  final String idPark;
  String nbre_de_place;




 


  var nbre = 4;
  
  

Map<String, bool> numbers = {};
void  initNumbers(){
  for(int  i=0;i<int.parse(nbre_de_place);i++){
  numbers.addAll({"${i}":false});
  }
  
}


 
  



  @override
  Widget build(BuildContext context) {
    
//print("park id = ${idPark}");

    //var nbre = 3;
    initNumbers();
   
    

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title:  Text(
            "Set place state ",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  for (int i = 0; i < int.parse(nbre_de_place); i++) MyToggleList(i),
                ],
              ),
            ),
          ),
        ));
  }

  Widget MyToggleList(int i) {
    return Container(
      child: Column(
        children: [
          Text(
            "This Place is : ",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          menuItem(i),
        ],
      ),
    );
  }

  Widget menuItem(i) {
    

    return Material(
      
      child: RollingSwitch.icon(
        
      

        onChanged: (bool state) {
          numbers.addAll({"${i}":state});
          print('turned ${i} ${(state) ? 'on' : 'off'}');
          print("${numbers}");
          print("nbre de palace  =${int.parse(nbre_de_place)} ");
          
          int  count=0;
          for(int  i=0;i<numbers.length;i++){
              if ( (numbers["${i}"]==false)){
                  count+=1;
              }

          }
          print("place libre = ${count}");
          FirebaseFirestore.instance.collection("places").doc(idPark).set({"place_libre":count});
        },
        rollingInfoRight: const RollingIconInfo(
          
          icon: Icons.flag,
           
          text: Text('Full'),
        ),
        rollingInfoLeft: const RollingIconInfo(
          icon: Icons.check,
          backgroundColor: Colors.red,
          text: Text('Empty'),
        ),
      ),
    );
  }
}