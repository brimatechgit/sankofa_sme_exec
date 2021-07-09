import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/assessmentName.dart';
import 'package:sankofa_sme_exec/screens/diagnosisGraphsPage.dart';
import 'package:sankofa_sme_exec/screens/diagnosisPathPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';

class DiagnosticsPage extends StatefulWidget {
  final docID;
  const DiagnosticsPage({Key? key, required this.docID}) : super(key: key);

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
                                .doc(this.widget.docID)
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
                                    // print(skills['Skills'].toString());
                                    // print(selectedCountList!.length);
                                    //countList.add(skills['Skills'][index]['Skill']);
                                    return GestureDetector(
                                      onTap: () {
                                        //should navigate to graph page

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DiagnosisGraphPage(
                                                      ref: diagnostic.id,
                                                    )));
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

                      //   GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => DiagnosisPathPage()));
                      //     },
                      //     child: Card(
                      //         margin: EdgeInsets.all(12.0),
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(12.0),
                      //           child: Row(
                      //             children: [
                      //               Expanded(child: Text('Finance ')),
                      //               SizedBox(width: 5.0),
                      //               //check if assesment is wip or completed
                      //               Text(status,
                      //                   style: TextStyle(
                      //                       color: Colors.yellowAccent)),
                      //               SizedBox(width: 10.0),
                      //               ElevatedButton.icon(
                      //                 style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      //                   onPressed: () {},
                      //                   icon: Icon(Icons.close),
                      //                   label: Text('Cancel'))
                      //             ],
                      //           ),
                      //         )),
                      //   ),
                      //  GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => DiagnosisPathPage()));
                      //     },
                      //                           child: Card(
                      //         margin: EdgeInsets.all(12.0),
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(22.0),
                      //           child: Row(
                      //             children: [
                      //               Expanded(child: Text('Sales')),
                      //               SizedBox(width: 5.0),
                      //               //check if assesment is wip or completed, and chenge text color accordingly
                      //               Text('Completed',
                      //                   style:
                      //                       TextStyle(color: Colors.greenAccent)),
                      //               SizedBox(width: 10.0),
                      //               // ElevatedButton.icon(
                      //               //     onPressed: () {},
                      //               //     icon: Icon(Icons.close),
                      //               //     label: Text('Stop'))
                      //             ],
                      //           ),
                      //         )),
                      //   ),
                      //   GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => DiagnosisPathPage()));
                      //     },
                      //                           child: Card(
                      //         margin: EdgeInsets.all(12.0),
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(22.0),
                      //           child: Row(
                      //             children: [
                      //               Expanded(child: Text('Communication')),
                      //               SizedBox(width: 5.0),
                      //               //check if assesment is wip or completed, and chenge text color accordingly
                      //               Text('Not started',
                      //                   style: TextStyle(color: Colors.blueGrey)),
                      //               SizedBox(width: 10.0),
                      //               ElevatedButton.icon(
                      //                 style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      //                   onPressed: () {},
                      //                   icon: Icon(Icons.close),
                      //                   label: Text('Cancel'))
                      //             ],
                      //           ),
                      //         )),
                      //   ),
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
                              builder: (context) => AssessmNamePage()));
                    },
                    // child: Text('Diagnosis'),
                  ))
            ]),
      ),
    );
  }
}
