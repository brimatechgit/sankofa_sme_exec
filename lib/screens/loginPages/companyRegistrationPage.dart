import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _companyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: _companyNameController,
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
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextField(
                      controller: _companyNameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.build,
                          color: Colors.white,
                        ),
                        hintText: 'Automotive',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Please enter relevent Secondary sector'),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextField(
                      controller: _companyNameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.build,
                          color: Colors.white,
                        ),
                        hintText: 'Information Technology',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
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
                          onPressed: () {
                            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LandingPage()));
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
