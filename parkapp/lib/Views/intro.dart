//import 'dart:html';

import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
  
    body: Container(
       
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children:<Widget> [
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  
                  Text(
                    "Easy Park",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.purple[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Welcome to Easy Park , Let's Park!" , 
                    style: TextStyle (
                    fontSize: 25 , 
                    color: Colors.black87
                    ),
                  ),

                  Spacer(),

                  
                  Image.asset("lib/img/park3.png",
            
                  ),

                  Spacer(),

                  
                  
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.purple[800],
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    
                    
                    onPressed: () {}, 
                    child: Text(
                      "Let's Go!" ,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ) ,

                    
                    ),
                  Spacer(),
                  
                ]
              ),
            )

          ]
        ),
      ),
         

        
    ),
      
      
  );
  }
}








class View extends StatefulWidget {
  const View({ Key? key }) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

