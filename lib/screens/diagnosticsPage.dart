import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/assessmentName.dart';
import 'package:sankofa_sme_exec/screens/diagnosisGraphsPage.dart';
import 'package:sankofa_sme_exec/screens/diagnosisPathPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';
import 'package:sankofa_sme_exec/utilities/globalVars.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';

class DiagnosticsPage extends StatefulWidget {
  final docID;
  final userCompany;
  final userEmail;
  final User? user;
  final from;
  const DiagnosticsPage(
      {Key? key,
      required this.docID,
      required this.from,
      required this.user,
      required this.userEmail,
      required this.userCompany})
      : super(key: key);

  @override
  _DiagnosticsPageState createState() => _DiagnosticsPageState();
}

class _DiagnosticsPageState extends State<DiagnosticsPage> {
  String status = 'WIP';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnostics'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNav(),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //would have an if statement that checks if there iis any assesments on the db
              //since there is no assesment for now only show a center text
              Flexible(
                  flex: 1,
                  child: Container(
                      child: Column(
                    children: [
                      //generate this card using a listview, using an array of assesments the user has engaged in

                      Flexible(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(ownerDocId)
                                .collection('Diagnostics')
                                .snapshots(), //has to be a collection
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    // bool checked = index == checkedIndex;
                                    // fillColor = Colors.transparent;
                                    DocumentSnapshot diagnostic =
                                        snapshot.data!.docs[index];
                                    print('here');
                                    // print(skills['Skills'].toString());
                                    // print(selectedCountList!.length);
                                    //countList.add(skills['Skills'][index]['Skill']);
                                    return GestureDetector(
                                      onTap: () {
                                        //get self assessment results from db
                                        // FirebaseFirestore.instance
                                        //     .collection(
                                        //         '/Diagnostics/$ownerDocId/Team')
                                        //     .get()
                                        //     .then((querySnapshot) {
                                        //   querySnapshot.docs.forEach((result) {
                                        //     //should add to the list immediately
                                        //     print('here');

                                        //     print(result.get(
                                        //         'Self Assessment Result Medium Term'));
                                        //     if (result.get(
                                        //             'Self Assessment Result Medium Term') !=
                                        //         '') {
                                        //       setState(() {
                                        //         ++completed;
                                        //       });

                                        //       print(
                                        //           'Completed Vals $completed');
                                        //     } else {
                                        //       setState(() {
                                        //         ++incomplete;
                                        //       });
                                        //       print(
                                        //           'InCompleted Vals $incomplete');
                                        //     }
                                        //   });
                                        // });

                                        //should navigate to graph page

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DiagnosisGraphPage(
                                                        ref: diagnostic
                                                            .get('Reference'),
                                                        ownerID: this
                                                            .widget
                                                            .docID)));
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => DiagnosisPathPage()));
                                      },
                                      child: Card(
                                          margin: EdgeInsets.all(12.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        '${diagnostic.get('Reference')}')),
                                                SizedBox(width: 5.0),
                                                //check if assesment is wip or completed
                                                Text(status,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .yellowAccent)),
                                                SizedBox(width: 10.0),
                                                ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors
                                                                .blueGrey),
                                                    onPressed: () {},
                                                    icon: Icon(Icons.close),
                                                    label: Text('Cancel'))
                                              ],
                                            ),
                                          )),
                                    );
                                  });
                            }),
                      ),
                    ],
                  ))),
              // Flexible(
              //     flex: 1,
              //     child: Container(
              //         child: Text('Currently no diagnostics running!'))),
              Flexible(
                  flex: 0,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Create New Diagnostic'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssessmNamePage(
                                    userComp: this.widget.userCompany,
                                    from: this.widget.from,
                                    userEmail: this.widget.user!.email,
                                  )));
                    },
                    // child: Text('Diagnosis'),
                  ))
            ]),
      ),
    );
  }
}
