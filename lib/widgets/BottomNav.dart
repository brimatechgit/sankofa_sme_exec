import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/screens/selected_skills.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectedSkillsPage()),
                );
              },
              child: Text('Diagnostics' ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text('Learning'),
            ),
          ),
        ]),
      ),
    );
    // return SizedBox(
    //   height: 55.0,
    //   child: Container(
    //     margin: EdgeInsets.all(10),
    //     child: Row(children: [
    //       Expanded(
    //         child: TextButton(
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => SelectedSkillsPage()),
    //             );
    //           },
    //           child: Text('Skills (${selectedCountList!.length})' ),
    //         ),
    //       ),
    //       Expanded(
    //         child: TextButton(
    //           onPressed: () {},
    //           child: Text('Assessments'),
    //         ),
    //       ),
    //       Expanded(
    //         child: TextButton(
    //           onPressed: () {},
    //           child: Text('Reports'),
    //         ),
    //       ),
    //     ]),
    //   ),
    // );
  }
}
