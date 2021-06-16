
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';

class OtpPage extends StatelessWidget {
  final String fromPage;
  const OtpPage({Key? key, required this.fromPage}) : super(key: key);

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
            obscureText: true,
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
              hintText: 'Enter your OTP',
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

          if(this.fromPage == 'signUp'){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RegistrationPage()));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LandingPage()));
          }


          // if (this.widget.from == "login") {
          //   VerifyOPT();
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => ProfilePage(
          //                 userName: this.widget.email,
          //               )));

          //   //  Navigator.pushNamedAndRemoveUntil(
          //   //           context, ProfilePage.idScreen, (route) => false);

          // } else {
          //   userDbRef.push().set({
          //     "name": this.widget.name,
          //     "email": this.widget.email,
          //     "score": counter,
          //     "preferences": arrRes
          //   }).then((_) {
          //     ScaffoldMessenger.of(context)
          //         .showSnackBar(SnackBar(content: Text('Successfully Added')));
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => ProfilePage(
          //                   userName: this.widget.email,
          //                 )));
          //   }).catchError((onError) {
          //     ScaffoldMessenger.of(context)
          //         .showSnackBar(SnackBar(content: Text(onError)));
          //   });
        },
        child: Text(
          'LOGIN',
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
        title: Text('OTP'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ENTER OTP',
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
          ],
        ),
      ),
    );
  }
}
