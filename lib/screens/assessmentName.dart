import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

final assessNameController = TextEditingController(); // would be a public ref

class AssessmNamePage extends StatefulWidget {
  final from;
  const AssessmNamePage({Key? key, required this.from}) : super(key: key);

  @override
  _AssessmNamePageState createState() => _AssessmNamePageState();
}

class _AssessmNamePageState extends State<AssessmNamePage> {
  final _privateRefController = TextEditingController();
  final _publicRefController = TextEditingController();

  Widget _buildOTP(placeholder, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            obscureText: false,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.work,
                color: Colors.white,
              ),
              hintText: 'i.e. $placeholder',
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
          //push to skills page
          //create diagnostic in db
          // if (this.widget.from == '') {
          await Database.addDiagnostic(
              diagnName: assessNameController.text,
              email: emailController.text,
              from: this.widget.from);
          // } else {
          //   await Database.addNewDiagnostic(
          //     diagnName: assessNameController.text,
          //   );
          // }

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SkillSetsPage()));
        },
        child: Text(
          'Submit',
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
      appBar: AppBar(title: Text('Name assessment')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please name Diagnostic with memorable a reference'),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Who is this for'),
                    Text('What is the purpose of a diagnostic'),
                  ],
                )),
                SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  height: 12.0,
                ),

                Text('Please enter Public Reference'),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.info,
                    color: Colors.blueGrey,
                    size: 12.0,
                  ),
                  Text(
                    'Visible to every participant',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                  )
                ]),
                _buildOTP('Finance', assessNameController),
                Text('Please enter Private Reference'),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.info,
                    color: Colors.blueGrey,
                    size: 12.0,
                  ),
                  Text('Visible only to you',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 12.0))
                ]),
                SizedBox(
                  height: 12.0,
                ),
                _buildOTP('Private ref', _privateRefController),
                // Text('Please enter Public Reference'),
                // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //   Icon(
                //     Icons.info,
                //     color: Colors.blueGrey,
                //     size: 12.0,
                //   ),
                //   Text(
                //     'Visible to every participant',
                //     style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                //   )
                // ]),
                // SizedBox(
                //   height: 12.0,
                // ),
                // _buildOTP('Public ref', _publicRefController),
                _buildLoginBtn(context),
              ]),
        ),
      ),
    );
  }
}
