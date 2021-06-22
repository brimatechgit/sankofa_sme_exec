import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/loginPages/otpPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();

  Widget _buildOTP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'mail@mail.com',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: ElevatedButton(
        onPressed: () {
          
          //validate email
          //check user in db
          if (EmailValidator.validate(_emailController.text)) {
            


            FirebaseFirestore.instance
                .collection("Users").where("email", isEqualTo: _emailController.text)
                .get()
                .then((querySnapshot) {
              querySnapshot.docs.forEach((result) {
                userID = result.id;
                
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpPage(
                                  userList: result.data(),
                                  documentID: result.id,
                                  
                                  fromPage: 'signIn',
                                )));
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
        },
        child: Text(
          'Get OTP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
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
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30.0),
        _buildOTP(),
        SizedBox(
          height: 30.0,
        ),
        _buildLoginBtn(context),

        // Flexible(

        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text('Please enter email'),
        //       ),
        //       Container(
        //         alignment: Alignment.centerLeft,
        //         decoration: kBoxDecorationStyle,
        //         height: 60.0,
        //         child: TextField(
        //           controller: _emailController,
        //           keyboardType: TextInputType.text,
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontFamily: 'OpenSans',
        //           ),
        //           decoration: InputDecoration(
        //             border: InputBorder.none,
        //             contentPadding: EdgeInsets.only(top: 14.0),
        //             prefixIcon: Icon(
        //               Icons.email,
        //               color: Colors.white,
        //             ),
        //             hintText: 'email@email.com',
        //             hintStyle: kHintTextStyle,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Flexible(

        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: ElevatedButton(
        //           onPressed: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => OtpPage(
        //                           fromPage: 'signIn',
        //                         )));
        //           },
        //           child: Text('Submit')),
        //     ))
      ]),
    );
  }
}
