import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
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
                  Container(
                    
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 0.5),
                        borderRadius: BorderRadius.circular(15.0)),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: DropdownButton<String>(
                      hint: priSectordropdownValue == null ? Text('Select Secondary Sector') : Text(priSectordropdownValue),
                      // value: priSectordropdownValue,
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Colors.blueAccent,
                      ),
                      iconSize: 24,
                      isExpanded: true,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueAccent),
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          priSectordropdownValue = newValue!;
                          
                        });
                      },
                      items: sectors.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Please enter relevent Secondary sector'),
                  ),
                  SizedBox(height: 20.0),
                  //should be a dropdown
            //       DropdownButton<String>(
            //         value: dropdownValue,
            //         hint: Text('Please choose a sector'),
            //         items: sectors.map((value) {
            //           return DropdownMenuItem<String>(
            //             value: value,
            //             child: Text(value),
            //           );
            //         }).toList(),
            //        onChanged: (newValue) {
            //   setState(() {
            //     dropdownValue = newValue.toString();
            //   });
            // },
            //       )

            Container(
                    
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 0.5),
                        borderRadius: BorderRadius.circular(15.0)),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: DropdownButton<String>(
                      hint: secSectordropdownValue == null ? Text('Select Secondary Sector') : Text(secSectordropdownValue),
                      // value: secSectordropdownValue,
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Colors.blueAccent,
                      ),
                      iconSize: 24,
                      isExpanded: true,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueAccent),
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          secSectordropdownValue = newValue!;
                          this.setState(() {
                            
                          });
                        });
                      },
                      items: sectors.map<DropdownMenuItem<String>>((String value2) {
                        return DropdownMenuItem<String>(
                          value: value2,
                          child: Text(value2),
                        );
                      }).toList(),
                    ),
                  ),

                  //              StreamBuilder<QuerySnapshot>(
                  //   stream: FirebaseFirestore.instance.collection('Sectors').snapshots(),
                  //   builder: (context, snapshot) {

                  //     if (!snapshot.hasData) {
                  //       return Text('Loading');
                  //     }

                  //     for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  //       DocumentSnapshot documentSnapshot = snapshot.data!.docs[i];
                  //       print(documentSnapshot.id);
                  //       institution.add(
                  //         DropdownMenuItem(
                  //           child: Text(
                  //             documentSnapshot.id,

                  //           ),
                  //           value: "${documentSnapshot.id}",
                  //         ),
                  //       );
                  //     }

                  //     return  DropdownButton(
                  //         hint: Text("Select Secondary sector"),
                  //         // value: widget.selectedInstitution,
                  //         items: institution,
                  //         // onChanged: widget.onpressed,
                  //         // onChanged: (val){

                  //         // },
                  //     );
                  //   },
                  // ),

//                 StreamBuilder(
//     stream: FirebaseFirestore.instance.collection('Sectors').snapshots(),
//     builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot){
//       if (!snapshot.hasData) return const Center(
//         child: const CupertinoActivityIndicator(),
//       );
//       var length = snapshot.data!.docs.length;
//       DocumentSnapshot ds = snapshot.data!.docs[length - 1];
//       // _queryCat = snapshot.data.documents;
//       return new Container(
//         padding: EdgeInsets.only(bottom: 16.0),
//         width: 200.0,
//         child: new Row(
//           children: <Widget>[
//             new Expanded(
//                 flex: 2,
//                 child: new Container(
//                   padding: EdgeInsets.fromLTRB(12.0,10.0,10.0,10.0),
//                   child: new Text("Sector"),
//                 )
//             ),
//             new Expanded(
//               flex: 4,
//               child:new InputDecorator(
//                 decoration: const InputDecoration(
//                   //labelText: 'Activity',
//                   hintText: 'Choose a Sector',
//                   hintStyle: TextStyle(

//                     fontSize: 16.0,
//                     fontFamily: "OpenSans",
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 // isEmpty: _category == null,
//                 child: new DropdownButton(
//                   // value: _category,
//                   isDense: true,
//                   // onChanged: (String newValue) {
//                   //   setState(() {
//                   //     _category = newValue;
//                   //     dropDown = false;
//                   //     print(_category);
//                   //   });
//                   // },
//                   items: snapshot.data!.docs.map((DocumentSnapshot document) {
//                     return new DropdownMenuItem<String>(
//                         value: document.get('Sector'),
//                         child: new Container(
//                           decoration: new BoxDecoration(

//                               borderRadius: new BorderRadius.circular(5.0)
//                           ),
//                           height: 100.0,
//                           padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
//                           //color: primaryColor,
//                           child: new Text(document.get('Sector')),
//                         )
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
// )

                  //   Container(
                  //     alignment: Alignment.centerLeft,
                  //     decoration: kBoxDecorationStyle,
                  //     height: 60.0,
                  //     child: TextField(
                  //       controller: _secSectorController,
                  //       keyboardType: TextInputType.text,
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontFamily: 'OpenSans',
                  //       ),
                  //       decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         contentPadding: EdgeInsets.only(top: 14.0),
                  //         prefixIcon: Icon(
                  //           Icons.build,
                  //           color: Colors.white,
                  //         ),
                  //         hintText: 'Information Technology',
                  //         hintStyle: kHintTextStyle,
                  //       ),
                  //     ),
                  //   ),
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
                            await Database.updateRegiForm(
                              companyName: companyNameController.text,
                              primarySec: _pSectorController.text,
                              secondarySec: _secSectorController.text,
                              email: emailController.text,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LandingPage()));
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
