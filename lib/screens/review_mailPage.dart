import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/assessmentName.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';
import 'package:sankofa_sme_exec/utilities/globalVars.dart';

//final page, reviews teamlead emails
//submits to db here?
class ReviewMailPage extends StatefulWidget {
  final docID;
  final from;

  const ReviewMailPage({Key? key, this.docID, this.from}) : super(key: key);

  @override
  _ReviewMailPageState createState() => _ReviewMailPageState();
}

class _ReviewMailPageState extends State<ReviewMailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('review mail list'),
      ),
      body: Column(children: [
        Flexible(
          flex: 2,
          child: ListView.builder(
              itemCount: teamLeadMailList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: ListTile(
                          title: Text(teamLeadMailList[index]['name']),
                          subtitle: Text(teamLeadMailList[index]['email']),
                        ),
                      ),
                      Flexible(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.redAccent,
                            ),
                          ))
                    ],
                  ),
                );
              }),
        ),
        Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => LandingPage(docID: userID,)));

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => LandingPage(
                                from: this.widget.from,
                                docID: userID,
                              )),
                      (Route<dynamic> route) => false);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => DiagnosticsPage(docID: userID,)));

                  //add the teamleade to document, with the user's role
                  await Database.addTeamLeaders(
                    currID: gDocuId,
                  );
                },
                child: Text('Finalise'),
              ),
            ))
      ]),
    );
  }
}
