import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signInPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';

//first page all users get tp
class SignInUpPage extends StatelessWidget {
  const SignInUpPage({Key? key}) : super(key: key);

  sendEmail(String emailAddress) async {
    final Email email = Email(
      body: 'Hello World',
      subject: 'Testing email on flutter',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }

  Future<void> send() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['tshepang@sankofa.digital'],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
      print(platformResponse);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: 250, height: 250, child: Image.asset('/diagnostic.png')),
          SizedBox(height: 25.0),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                  padding: EdgeInsets.all(22)),
              child: Text('Sign Up'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Already have an account? ',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                child: Text('Sign In'),
                onPressed: () {
                  // ignore: unnecessary_statements
                  // send();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
              )
            ],
          ),
        ]),
      ),
    );
  }
}
