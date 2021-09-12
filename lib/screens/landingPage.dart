import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/assessmentName.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/screens/selected_skills.dart';
import 'package:sankofa_sme_exec/screens/skill_sets.dart';
import 'package:sankofa_sme_exec/services/firebase_service.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';
import 'package:filter_list/filter_list.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

class LandingPage extends StatefulWidget {
  final docID;
  final from;
  final userEmail;
  final userComp;
  LandingPage({this.docID, required this.from, this.userEmail, this.userComp});
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              FirebaseService service = new FirebaseService();
              await service.signOutFromGoogle();
              Navigator.pushReplacementNamed(context, Constants.signInNavigate);
            },
          )
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssessmNamePage(
                                userComp: this.widget.userComp,
                                userEmail: this.widget.userEmail,
                                from: this.widget.from,
                              )));
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
                          builder: (context) => DiagnosticsPage(
                                userEmail: this.widget.userEmail,
                                from: this.widget.from,
                                docID: this.widget.docID,
                                userCompany: this.widget.userComp,
                                user: user,
                              )));
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
