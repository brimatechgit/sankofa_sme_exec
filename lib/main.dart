import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signInUpPage.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final databaseReference  = FirebaseFirestore.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Error fetching DB');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
      title: 'Sankofa SME',
      theme: ThemeData.dark(
        
      
      ),
      home: SignInUpPage(),
      routes: {
        "/DiagnosticPage": (_) => new DiagnosticsPage(docID: userID,),
      },
      debugShowCheckedModeBanner: false,
    );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
    
    
    
    
  }
}

