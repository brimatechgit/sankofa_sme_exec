import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/loginPages/otpPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';
import 'package:sankofa_sme_exec/widgets/login_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _btnFunction() async {
    //validate email
    //check user in db
    if (true)
    // EmailValidator.validate(_emailController.text))

    {
      EmailAuth.sessionName = "Test Session";
      // var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);

      FirebaseFirestore.instance
          .collection("Users")
          .where("email",
              isEqualTo: 'bogosi@sankofa.digital') //change email here
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          userID = result.id;

          //should send otp to user
          // if (res) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpPage(
                        userList: result.data(),
                        documentID: result.id,
                        emailC: _emailController.text,
                        fromPage: 'signIn',
                      )));
          // }
          //.then((value) => showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return AlertDialog(
          //       title: Text("Notice"),
          //       content: Text("No email found, please re-enter"),
          //       actions: [],
          //     );
          //   },
          // ));

          // if(resul)
          // print('${result.data()}, ${result.id}');
        });
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Notice"),
            content: Text("Invalid email entered"),
            actions: [],
          );
        },
      );
    }

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => OtpPage(
    //               fromPage: 'signIn',
    //             )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Enter Email',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: TextFieldWidget(
            obscure: false,
            type: TextInputType.emailAddress,
            textController: _emailController,
            hint: 'example@mail.com',
            icon: Icons.email_outlined,
          ),
        ),
        // SizedBox(
        //   height: 30.0,
        // ),
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: TextFieldWidget(
            obscure: true,
            type: TextInputType.visiblePassword,
            textController: _passwordController,
            hint: '********',
            icon: Icons.email_outlined,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 13.0, top: 5.0),
              child: GestureDetector(
                child: Text('Forgot passwword'),
                onTap: () {},
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 75,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: ElevatedButton(
              onPressed: _btnFunction,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
