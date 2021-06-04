import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';

//will have 3 tiles/paths
//skills, assesments, and report
class DiagnosisPathPage extends StatelessWidget {
  const DiagnosisPathPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosis'),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SkillSetsPage()));
                },
                child: Card(
                  child: Center(
                      child: Text(
                    'SKILLS',
                    style: TextStyle(fontSize: 25.5, letterSpacing: 1.2),
                  )),
                ),
              )),
        ),
        Expanded(
          child: Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Card(
                  child: Center(
                    child: Text('ASSESSMENTS',
                        style: TextStyle(fontSize: 25.5, letterSpacing: 1.2)),
                  ),
                ),
              )),
        ),
        Expanded(
          child: Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Card(
                  child: Center(
                    child: Text('REPORT',
                        style: TextStyle(fontSize: 25.5, letterSpacing: 1.2)),
                  ),
                ),
              )),
        ),
      ]),
      bottomNavigationBar: BottomNav());
  }
}