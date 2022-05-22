

import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/services/payment_service.dart';
import 'package:flutter_application_2/Views/visitor/app_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({ Key? key }) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String ? _value  ;
  
  @override
  Widget build(BuildContext context) {
    final PaymentService controller = Get.put(PaymentService());
    return Scaffold(
      

      body: Container(
        child: Column (
          children: [
           SizedBox(height: 25,),
           const Text("Choose your payment method" , 
            style: TextStyle(
              fontSize: 25 ,
              color: Colors.blueGrey ),),
           SizedBox(height: 30,),
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
           SizedBox(height: 20,),
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
             SizedBox(height: 40,),

            TextButton(onPressed: () {
              
              //Navigator.push(context,MaterialPageRoute(builder:(context)=>AppHome()));
               controller.makePayment(amount: '5', currency: 'USD');
            }, 
            child: Text("  Confirm  "),
            style: TextButton.styleFrom(
             primary: Colors.white,
             backgroundColor: Colors.teal,
             elevation: 10,
             textStyle: const TextStyle(fontSize: 20),
          
          
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
            ), 
            
            ),
            SizedBox(height: 100,)
          ]),
        
      )
      
    );
  }
}