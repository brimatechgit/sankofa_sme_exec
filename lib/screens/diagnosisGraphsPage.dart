import 'package:flutter/material.dart';



class DiagnosisGraphPage extends StatefulWidget {
  const DiagnosisGraphPage({ Key? key }) : super(key: key);

  @override
  _DiagnosisGraphPageState createState() => _DiagnosisGraphPageState();
}

class _DiagnosisGraphPageState extends State<DiagnosisGraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diagnostic review'),),
      //add graphs here
      body: Container(child: Column(
        children:[
          // self assessments graph here
          



          //Team assessment graphs here



          //bottom right finalise button here
          //should navigate to skills page with spider graph that shows average 
          //// 
        ]
      ),),
    );
  }
}