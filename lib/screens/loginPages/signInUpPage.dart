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
              // ignore: unnecessary_statements
              // send();
              sendEmail('tshepang@sankofa.digital');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
          ),
        ]),
      ),
    );
  }
}
