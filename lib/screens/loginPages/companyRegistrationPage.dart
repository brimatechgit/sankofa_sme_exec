import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signInPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

List<String> sectors = [];
final companyNameController = TextEditingController();
var secSectordropdownValue;
var priSectordropdownValue;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _pSectorController = TextEditingController();
  final _secSectorController = TextEditingController();
  var selectedPrimarySec, selectedType, selectedSecondarySec;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Company Registration'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter company Name'),
            SizedBox(height: 20.0),
            Flexible(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: kBoxDecorationStyle,
                height: 60.0,
                child: TextField(
                  controller: companyNameController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintText: 'Sankofa SME',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Flexible(
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Please enter relevent Primary sector'),
                  ),
                  SizedBox(height: 20.0),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Sectors")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return const Text("Loading.....");
                        else {
                          List<DropdownMenuItem> currencyItems = [];
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data!.docs[i];
                            currencyItems.add(
                              DropdownMenuItem(
                                child: Text(
                                  snap.get('Sector'),
                                ),
                                value: "${snap.get('Sector')}",
                              ),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueAccent, width: 0.5),
                                borderRadius: BorderRadius.circular(15.0)),
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: DropdownButton<dynamic>(
                              items: currencyItems,
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Colors.blueAccent,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.blueAccent),
                              underline: SizedBox(),
                              onChanged: (pSecVal) {
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Selected primary Sector is $pSecVal',
                                    style: TextStyle(color: Color(0xff11b719)),
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                                setState(() {
                                  selectedPrimarySec = pSecVal;
                                });
                              },
                              value: selectedPrimarySec,
                              isExpanded: true,
                              hint: new Text(
                                "Select Primary Sector",
                              ),
                            ),
                          );
                        }
                      }),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Please enter relevent Secondary sector'),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(height: 20.0),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Sectors")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return const Text("Loading.....");
                        else {
                          List<DropdownMenuItem> currencyItems = [];
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data!.docs[i];
                            currencyItems.add(
                              DropdownMenuItem(
                                child: Text(
                                  snap.get('Sector'),
                                ),
                                value: "${snap.get('Sector')}",
                              ),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueAccent, width: 0.5),
                                borderRadius: BorderRadius.circular(15.0)),
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: DropdownButton<dynamic>(
                              items: currencyItems,
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Colors.blueAccent,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.blueAccent),
                              underline: SizedBox(),
                              onChanged: (pSecVal) {
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Selected Secondary Sector is $pSecVal',
                                    style: TextStyle(color: Color(0xff11b719)),
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                                setState(() {
                                  selectedSecondarySec = pSecVal;
                                });
                              },
                              value: selectedSecondarySec,
                              isExpanded: true,
                              hint: new Text(
                                "Select Secondary Sector",
                              ),
                            ),
                          );
                        }
                      }),
                ],
              )),
            ),
            Flexible(
                flex: 0,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.info,
                              color: Colors.blueGrey[500],
                            ),
                            label: Text(
                              'why we need sectors?',
                              style: TextStyle(color: Colors.blueGrey[100]),
                            )),
                      ),
                    ),
                    SizedBox(width: 75.0),
                    Flexible(
                      flex: 0,
                      child: Container(
                        child: ElevatedButton(
                          child: Text('Submit'),
                          onPressed: () async {
                            //validate check
                            if (selectedPrimarySec == null ||
                                selectedSecondarySec == null ||
                                companyNameController.text == '') {
                              AlertDialog alert = AlertDialog(
                                title: Text("Missing fields"),
                                content:
                                    Text("Please enter all required fields"),
                              );

                              // show the dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            } else {
                              await Database.updateRegiForm(
                                companyName: companyNameController.text,
                                primarySec: selectedPrimarySec,
                                secondarySec: selectedSecondarySec,
                                email: emailController.text,
                              );

                              //popup showing user account successfully created
                              //please sign in
                              Fluttertoast.showToast(
                                  msg:
                                      "User account successfully created, please sign in",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()),
                                  (Route<dynamic> route) => false);
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LandingPage(
                            //               from: '',
                            //             )));
                          },
                        ),
                      ),
                    )
                  ],
                ))
          ]),
    );
  }
}
