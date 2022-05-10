

import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/visitor/app_bar.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({ Key? key }) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String ? _value  ;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  toolbarHeight: 80,
      //  backgroundColor: Colors.white,
       // elevation: 0,
       // centerTitle: true,
       // title: const Text(' Payment Method' , 
       // style: 
       //  TextStyle(
        //  fontSize: 18,
        //  //color: Colors.teal
        //  color: Color(0XFFB0BEC5),
        //  ),
      //    ),
        
     // ),

      body: Container(
        child: Column (
          children: [
           SizedBox(height: 25,),
           const Text("Choose your payment method" , 
            style: TextStyle(
              fontSize: 25 ,
              color: Colors.blueGrey ),),
           SizedBox(height: 40,),
           RadioListTile(
             
             activeColor: Colors.teal,
             title: const Text('Credit card',style: TextStyle(fontSize: 20),),
             value: "Credit card", 
             groupValue: _value,
             
             onChanged: (String? value ){
              setState(() {
                _value = value ;
              });
             }
             ),
           SizedBox(height: 30,),
           RadioListTile(
             activeColor: Colors.teal,
             title: const Text('Cash',style: TextStyle(fontSize: 20),),
             value: "Cash", 
             groupValue: _value,
             
             onChanged: (String? value ){
              setState(() {
                _value = value ;
              });
             }
             ),
             SizedBox(height: 50,),

            TextButton(onPressed: () {
              
               Navigator.push(context,MaterialPageRoute(builder:(context)=>AppHome()));
            }, 
            child: Text("  Save  "),
            style: TextButton.styleFrom(
             primary: Colors.white,
             backgroundColor: Colors.teal,
             elevation: 10,
             textStyle: const TextStyle(fontSize: 28),
          
          
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
            ), 
            
            ),
            SizedBox(height: 300,)
          ]),
        
      )
      
    );
  }
}