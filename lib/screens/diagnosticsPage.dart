import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/diagnosisPathPage.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';

class DiagnosticsPage extends StatefulWidget {
  const DiagnosticsPage({Key? key}) : super(key: key);

  @override
  _DiagnosticsPageState createState() => _DiagnosticsPageState();
}

class _DiagnosticsPageState extends State<DiagnosticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diagnostics')),
      bottomNavigationBar: BottomNav(),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //would have an if statement that checks if there iis any assesments on the db
              //since there is no assesment for now only show a center text
              Flexible(
                  flex: 1,
                  child: Container(
                      child: Text('Currently no diagnostics running!'))),
              Flexible(
                  flex: 0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiagnosisPathPage()));
                    },
                    child: Text('Diagnosis'),
                  ))
            ]),
      ),
    );
  }
}
