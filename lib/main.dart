import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sankofa_sme_exec/screens/diagnosisGraphsPage.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signInUpPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/verify.dart';
import 'package:sankofa_sme_exec/screens/skillScreens/mediumTermSkills.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/temp/o_auth_test.dart';
import 'package:sankofa_sme_exec/temp/sign_in_page.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

import 'navigation/navigate.dart';

void main() async {
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      appId: "341881760971319", //<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sankofa SME',
//       theme: ThemeData.dark(),
//       // initialRoute: '/',
//       home: SignInScreen(),
//       routes: Navigate.routes,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

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
        // vq57oqPgYjo5IrSs2Haq

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Sankofa SME',
            theme: ThemeData.dark(),
            // initialRoute: '/',
            // home: MediumTermSkillsPage(),
            // home: RegistrationPage(),
            // home: Verify(nameContr: 'Tshe', emailContr: 'Tshe@tshe.co'),
            // home: SignInUpPage(),
            // home: DiagnosticsPage(
            //   docID: 'vq57oqPgYjo5IrSs2Haq',
            //   from: null,
            // ),
            home: DiagnosisGraphPage(
              ownerID: '',
              ref: 'test',
            ),
            // home: MyTestApp(),
            routes: Navigate.routes,
            debugShowCheckedModeBanner: false,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
