import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/assessmentName.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/screens/selected_skills.dart';
import 'package:sankofa_sme_exec/screens/skill_sets.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Expanded(
          child: Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AssessmNamePage()));
                },
                child: Card(
                  child: Center(
                      child: Text(
                    'NEW DIAGNOSTIC',
                    style: TextStyle(fontSize: 25.5, letterSpacing: 1.2),
                  )),
                ),
              )),
        ),
        Expanded(
          child: Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiagnosticsPage()));
                },
                child: Card(
                  child: Center(
                    child: Text('REVIEW',
                        style: TextStyle(fontSize: 25.5, letterSpacing: 1.2)),
                  ),
                ),
              )),
        ),
      ]),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection('Skills').snapshots(),
      //   builder: (context, snapshot){
      //     return ListView.builder(
      //       itemCount: snapshot.data!.documents.length,
      //       itemBuilder: (context, index){

      //     })
      //   }
      // ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
