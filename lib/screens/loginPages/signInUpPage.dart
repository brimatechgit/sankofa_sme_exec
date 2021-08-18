import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signInPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';

//first page all users get tp
class SignInUpPage extends StatelessWidget {
  const SignInUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Welcome to sankofa SME,'),
          SizedBox(height: 25.0),
          ElevatedButton(
            child: Text('Sign Up'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              ' - OR - ',
              style: TextStyle(
                fontSize: 22.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            child: Text('Sign In'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
          ),
        ]),
      ),
    );
  }
}
