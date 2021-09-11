import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signInPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signInUpPage.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    // '/': (context) => SignInUpPage(),
    '/sign-in': (context) => SignInPage(),
    '/landing': (context) => LandingPage(
          from: '',
        )
  };
}
