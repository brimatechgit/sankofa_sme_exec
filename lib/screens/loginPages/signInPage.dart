import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/otpPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';
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
  final auth = FirebaseAuth.instance;

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
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Example@email.com',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passwordController,
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
              hintText: 'Name',
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
        onPressed: () async {
          auth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
          // auth.signInWithEmailLink(email: _emailController.text, emailLink: emailLink);
          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DiagnosticsPage(docID: docID)))

          if (auth.currentUser == null) {
            print('no user signed in');
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => LandingPage(
                          docID: auth.currentUser!.uid,
                        )),
                (Route<dynamic> route) => false);

            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (context) => LandingPage(
            //           docID: auth.currentUser!.uid,
            //         )));
          }
        },
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // _EmailLinkSignInSection(),

        Text(
          'Enter Email',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFieldWidget(
            textController: _emailController,
            hint: 'Email@example.com',
            icon: Icons.email,
            type: TextInputType.emailAddress,
            obscure: false),
        Text(
          'Enter Password',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFieldWidget(
            textController: _passwordController,
            hint: 'password',
            icon: Icons.lock,
            type: TextInputType.visiblePassword,
            obscure: true),
        // SizedBox(height: 30.0),
        // _buildOTP(),
        // SizedBox(
        //   height: 30.0,
        // ),
        // SizedBox(height: 30.0),
        // // _buildPassword(),
        // // SizedBox(
        // //   height: 30.0,

        // // ),

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

final FirebaseAuth _auth = FirebaseAuth.instance;

class _EmailLinkSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailLinkSignInSectionState();
}

class _EmailLinkSignInSectionState extends State<_EmailLinkSignInSection>
    with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _success = true;
  String _userEmail = '';
  String _userID = '';
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  void handleLink(Uri link) async {
    if (link != null) {
      final User? user = (await _auth.signInWithEmailLink(
        email: _userEmail,
        emailLink: link.toString(),
      ))
          .user;
      if (user != null) {
        setState(() {
          _userID = user.uid;
          _success = true;
        });
      } else {
        setState(() {
          _success = false;
        });
      }
    } else {
      setState(() {
        _success = false;
      });
    }
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (data!.link != null) {
        handleLink(data.link);
      }
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri deepLink = dynamicLink!.link;
        handleLink(deepLink);
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });
    }
  }

  Future<void> _signInWithEmailAndLink() async {
    _userEmail = _emailController.text;

    return _auth.sendSignInLinkToEmail(
        email: _userEmail,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://sankofasmeexec.page.link/',
          handleCodeInApp: true,
          iOSBundleId: 'com.example.sankofa_sme_exec',
          androidPackageName: 'com.example.sankofa_sme_exec',
          androidInstallApp: true,
          androidMinimumVersion: "16",
        ));
    // return await _auth.sendSignInWithEmailLink(
    //   email: _userEmail,
    //   url: 'https://flutterauth.page.link/',
    //   handleCodeInApp: true,
    //   iOSBundleID: 'com.google.firebase.flutterauth',
    //   androidPackageName: 'com.google.firebase.flutterauth',
    //   androidInstallIfNotAvailable: true,
    //   androidMinimumVersion: "1",
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const Text('Test sign in with email and link'),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email.';
              }
              return null;
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _signInWithEmailAndLink();
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success
                  ? ''
                  : (_success
                      ? 'Successfully signed in, uid: ' + _userID
                      : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
