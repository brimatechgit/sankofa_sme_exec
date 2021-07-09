import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/review_mailPage.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/globalVars.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

final List<Map<String, dynamic>> teamLeadMailList = [];

//a class of teamLeaders List of objects
class Leaders extends Object {
  String name;
  String email;

  Leaders({required this.name, required this.email});

  // @override
  // String toString() {
  //   //should be a json type list
  //   return '{ ${this.name}, ${this.email} }';
  // }
}

class TeamLeadMailPage extends StatefulWidget {
  const TeamLeadMailPage({Key? key}) : super(key: key);

  @override
  _TeamLeadMailPageState createState() => _TeamLeadMailPageState();
}

class _TeamLeadMailPageState extends State<TeamLeadMailPage> {
  // final List teamLeadMailList =
  //     []; //will be the final mail list that is pushed to the db
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nominate Team Leaders'),
        ),
        bottomNavigationBar: BottomNav(),
        body: Form(
          key: _formKey,
          child: Column(children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please nominate team leader(s)',
                    style:
                        TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextField(
                      controller: _nameController,
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
                        hintText: 'Name',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
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
                        hintText: 'Enter email',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //a start button and a button to enter another team lead email
            Flexible(
                flex: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        //add email to list

                        teamLeadMailList.add({
                          'name': '${_nameController.text}',
                          'email': '${_emailController.text}'
                        });
                        _emailController.clear(); //clears email field
                        _nameController.clear(); //clears name field
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Adding Leader')));
                      },
                      label: Text('Add'),
                      icon: Icon(Icons.add),
                    ),
                    SizedBox(width: 15.0),
                    ElevatedButton(
                      onPressed: () {
                        if (teamLeadMailList.length > 0) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Notice"),
                                content: Text(
                                    """Please confirm!\nTotal team leaders: ${teamLeadMailList.length}\nTotal Near Term skills selected: $totalNearTermSkills\nTotal Medium Term skills selected: $totalMidTermSkills"""),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewMailPage()));
                                        //  email();
                                      },
                                      child: Text('Proceed')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Add more leaders')),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Notice"),
                                content: Text(
                                    "List is empty, there is nothing to submit!"),
                                actions: [],
                              );
                            },
                          );
                        }
                      },
                      child: Text('START'),
                    ),
                    SizedBox(width: 15.0),
                  ],
                )),
          ]),
        ));
  }
}

email() async {
  String username = 'bogosi@sankofa.digital';
  String password = '';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Your name')
    ..recipients.add('tshepang@sankofa.digital')
    ..ccRecipients.add('bogosim15@gmail.com')
    ..bccRecipients.add(Address(''))
    ..subject =
        'Test Dart Mailer for Emailing Team Leads :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html =
        "<h1>emailing team leads with instructions</h1>\n<p>Hey! Congratulations on being a Team Lead these are your instructions</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE

  // Sending multiple messages with the same connection
  //
  // Create a smtp client that will persist the connection
  var connection = PersistentConnection(smtpServer);

  // Send the first message
  await connection.send(message);

  // close the connection
  await connection.close();
}
