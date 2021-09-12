// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sankofa_sme_exec/screens/landingPage.dart';

// import 'auth.dart';

// class GoogleSignInButton extends StatefulWidget {
//   @override
//   _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
// }

// class _GoogleSignInButtonState extends State<GoogleSignInButton> {
//   bool _isSigningIn = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: _isSigningIn
//           ? CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             )
//           : OutlinedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.white),
//                 shape: MaterialStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 setState(() {
//                   _isSigningIn = true;
//                 });

//                 // TODO: Add a method call to the Google Sign-In authentication
//                 User? user =
//                     await Authentication.signInWithGoogle(context: context);

//                 setState(() {
//                   _isSigningIn = false;
//                 });
//                 if (user != null) {
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                         builder: (context) => LandingPage(
//                               from: 'sign-in',
//                               docID: user.uid,
//                             )),
//                   );
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image(
//                       image: AssetImage("google_logo.jpg"),
//                       height: 35.0,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Text(
//                         'Sign in with Google',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black54,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
