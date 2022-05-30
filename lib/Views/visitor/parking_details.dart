import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/login.dart';
import 'package:flutter_application_2/Views/visitor/New_navBar.dart';
import 'package:flutter_application_2/Views/visitor/confirm.dart';

import 'package:flutter_application_2/Views/visitor/search_park.dart';
import 'package:google_fonts/google_fonts.dart';
 List placelibre = [] ;
class Details extends StatefulWidget {
  
  

   Details({ Key? key , required this.id_park , required this.name_park , required this.tarif  , required this.nombre_place
    }) : super(key: key);
    String id_park;
    String name_park;
    String tarif;
    String nombre_place;
    
  
    
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
   int? place ;
  
   var listPlaceReservation=[];
 @override
   void initState(){
     super.initState();
     placelibre.clear();
     
   }
   void getReservationPlace()async {
     await FirebaseFirestore.instance.collection("reservation").where("park",isEqualTo: "/parking/"+widget.id_park).snapshots().listen((event) {
       for(var i in event.docs){
         //print("docs=${i.data()["idPlace"]}");
         if(listPlaceReservation.contains(i.data()["idPlace"])==false){
           listPlaceReservation.add(i.data()["idPlace"]);
         }
       }
       print("listplace=$listPlaceReservation");
     }) ;
   }

  @override
  Widget build(BuildContext context) {
    getReservationPlace();
    
    
    return Scaffold(
     
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green.shade300,
       
        onPressed: (){
          if((place==0)||(place==null)){

          }else{
          Navigator.push(context, MaterialPageRoute(builder:(context)=> Confirm(idPark:widget.id_park,tarif: widget.tarif, placelibre:placelibre )));
          }
        }, 
         label:  Text("Make reservation",
             style: GoogleFonts.nunito(
             color: Colors.white,
             fontSize: 22 ,
             fontWeight: FontWeight.w800 ),
                   
          ),),
        
      
       body: Stack(
         children:<Widget> [
           Container(
             
             decoration: BoxDecoration(
               image: DecorationImage(
                opacity: 0.75,
                 image:  AssetImage("lib/img/back.jpg"),
                 
                 fit: BoxFit.cover )
                  ),
                  
           ),
            
           Positioned(
             top: 40.0,
             right: 15.0,
             child: CircleAvatar(
               backgroundColor:Colors.grey.withOpacity(0.5) ,
              child: IconButton(
                icon:const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: ()async{
                  //await FirebaseAuth.instance.signOut();
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> HomePageVisitor()));
                },
                 ),
                 )
             ),
             Positioned(
               top: MediaQuery.of(context).size.height * 0.2,
               left: 25.0,
               
               child: Container(
                 margin: EdgeInsets.only(top: 10.0),
                
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children:  <Widget>[
                     Text(widget.name_park,
                         style: GoogleFonts.nunito(
                         fontSize:50.0,
                         fontWeight: FontWeight.bold,
                         color: Colors.white ),),
                    ],
                 ),
               )
               ),
               Positioned(
                 bottom: 0.0,
                 child: Container(
                   padding: const EdgeInsets.only(left: 20.0 , right: 20.0 , top: 25.0),
                   height:MediaQuery.of(context).size.height * 0.6 ,
                   width: MediaQuery.of(context).size.width,
                   decoration:  BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(15.0),
                       topRight: Radius.circular(15.0)
                     )

                   ),
                   child: SingleChildScrollView(
                     child: Column(
                       children: <Widget>[
                         buildItemRow(context),
                         buildItemRowPrice(context)
                       ]

                       
                     ),
                   ),
                   ))

         ]),
      
    );
  }

   buildItemRow(BuildContext context) {
     
    return 
     Container(
       padding: const EdgeInsets.only(bottom: 30.0),
         child: Row(
                         children: <Widget>[
                           Container(
                             height: 75.0,
                             width: 75.0,
                             decoration:  BoxDecoration(
                               borderRadius: BorderRadius.circular(50.0),
                               image: const DecorationImage(
                                 fit: BoxFit.cover,
                                 image: AssetImage("lib/img/p.png"),
                                 //image: NetworkImage(
                                 //  "https://th.bing.com/th/id/R.d57dc0273ef0ebd46a30ee72307fd05c?rik=OLznvm4HljgULQ&pid=ImgRaw&r=0"),
                                    )
                             ),
                           ),
                           SizedBox(width: 10.0,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children:  [
                               
                                Text("Places available :",
                               style: GoogleFonts.nunito(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.green[300]
                                 ),),
                                 SizedBox(height: 10.0,),
                                 
                                 
                                 Container(
                                     width: MediaQuery.of(context).size.width -150,
                                     child: StreamBuilder<DocumentSnapshot<Map<String , dynamic>>>(
                                       stream: FirebaseFirestore.instance.collection("places").doc(widget.id_park).snapshots(),
                                       builder: (context , snapshot ){
                                         
                                         final document = snapshot.data;
                                        
                                         final text = document?.data()?["place_libre"];
                                         for(int i=0 ; i<int.parse(widget.nombre_place) ; i++) {
                                           if (document?.data()!["$i"] == false ) {
                                             if(placelibre.contains("$i")==false && listPlaceReservation.contains("$i")==false ){
                                              placelibre.add("$i");
                                              print("$placelibre");
                                             }
                                           }
                                         }
                                         
                                           place = text ;
                                        
                                         return Text("There are ${text } places free \nPlaces not reserved: \n ${placelibre}",
                                         style: GoogleFonts.nunito(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87
                                 ),
                                         );
                                       },
                                     )
                                       
                                       
                                       
                                 )
                             ],
                           )
                         ]),
                     );
                   
  }

  Container buildItemRowPrice(BuildContext context) {
    return 
     Container(
       padding: EdgeInsets.only(bottom: 30.0),
         child: Row(
                         children: <Widget>[
                           Container(
                             height: 75.0,
                             width: 75.0,
                             decoration:  BoxDecoration(
                               borderRadius: BorderRadius.circular(10.0),
                               image: const DecorationImage(
                                 fit: BoxFit.cover,
                                 image: AssetImage("lib/img/money.png"),
                                // image: NetworkImage(
                                //   "https://th.bing.com/th/id/R.de51a4f823481a985b7d202a2ef4a1c8?rik=sfFuz%2fE7obZ%2bwg&riu=http%3a%2f%2fwww.clipartbest.com%2fcliparts%2fKcn%2faG7%2fKcnaG7ddi.png&ehk=W5NcL8VHtYgAs00gHh4I%2f8iR2j6jKmVyhdmR1d6lkFM%3d&risl=&pid=ImgRaw&r=0"),
                                    )
                             ),
                           ),
                           SizedBox(width: 10.0,),
                           
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children:  [
                                Text("Fees per hour :",
                               style: GoogleFonts.nunito(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.green.shade300
                                 ),),
                                 const SizedBox(height: 10.0,),
                                 Container(
                                     width: MediaQuery.of(context).size.width -150,
                                     child:  Text(
                                       "${widget.tarif} DT" ,
                                       style: GoogleFonts.nunito(
                                         color:Colors.black87,
                                         fontSize: 20.0,
                                         fontWeight: FontWeight.bold ),
                                       ),
                                 )
                             ],
                           )
                         ]),
                     );
  }
}