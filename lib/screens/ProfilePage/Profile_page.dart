import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/services/firebase_service.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';

class ProfilePage extends StatefulWidget {
  final String uName;
  final uEmail;
  const ProfilePage({
    Key? key,
    required this.uName,
    required this.uEmail,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var notifications = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Icon(
                Icons.account_circle_rounded,
                size: 65.0,
              )),
              SizedBox(height: 25.0),
              ListTile(
                title: Text('Name'),
                subtitle: Text(this.widget.uName),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.edit),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text(this.widget.uEmail),
                leading: Icon(Icons.email),
                trailing: Icon(Icons.edit),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 145.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () async {
                      // FirebaseService service = new FirebaseService();
                      // await service.signOutFromGoogle();
                      // Navigator.pushReplacementNamed(
                      //     context, Constants.signInNavigate);

                      await _firebaseAuth.signOut().then((value) =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Constants.signInNavigate,
                              (Route<dynamic> route) => false));
                    },
                    child: Text('Logout')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
