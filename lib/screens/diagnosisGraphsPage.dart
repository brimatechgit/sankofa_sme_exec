import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

class DiagnosisGraphPage extends StatefulWidget {
  final String ref;
  const DiagnosisGraphPage({Key? key, required this.ref}) : super(key: key);

  @override
  _DiagnosisGraphPageState createState() => _DiagnosisGraphPageState();
}

class _DiagnosisGraphPageState extends State<DiagnosisGraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnostic review'),
      ),
      //add graphs here

      body: Container(
        child: Column(children: [
          // self assessments graph here

          //Team assessment graphs here
        ]),
      ),
      // floating actionbuton
      //bottom right finalise button here
      //should navigate to skills page with spider graph that shows average
      ////
      ///

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // should change status of the assessment and diagnostic to finalized

          await Database.updateDiagnostic(
            reference: this.widget.ref,
          );
        },
        label: const Text('Finalize'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
