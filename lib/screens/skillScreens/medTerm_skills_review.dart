import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/assessmentName.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/skillScreens/mediumTermSkills.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';
import 'package:sankofa_sme_exec/utilities/globalVars.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';

List<Widget> widgetList = [];

class SelectedMediumSkillsPage extends StatefulWidget {
  var totalSkills;
  SelectedMediumSkillsPage({required this.totalSkills});
  @override
  _SelectedMediumSkillsPageState createState() => _SelectedMediumSkillsPageState();
}

class _SelectedMediumSkillsPageState extends State<SelectedMediumSkillsPage> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Skills'),
      ),
      bottomNavigationBar: BottomNav(),
      body: Column(children: [
        if (selectedCountList != null)
          Flexible(
              flex: 0,
              child:
                  Text('Total skills selected ${this.widget.totalSkills!.length}')),

        Flexible(
          flex: 2,
          child: ListView.builder(
              itemCount: this.widget.totalSkills!.length,
              itemBuilder: (context, index) {
                print('Whole list $selectedCountList');
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(midTermList[index]['skill'].toString()),
                    subtitle: Text(midTermList[index]['title'].toString()),
                  ),
                );
              }),
        ),

        Flexible(
            flex: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text('Edit'),
                  icon: Icon(Icons.keyboard_backspace),
                ),
                SizedBox(width: 15.0),
                ElevatedButton(
                  onPressed: () {
                    if (this.widget.totalSkills!.length > 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Notice"),
                            content: Text(
                                "Please note, selected medium term skillsets cannot be changed once submitted!"),
                            actions: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                label: Text('Edit'),
                                icon: Icon(Icons.keyboard_backspace),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  onPressed: () async {

setState(() {
                            totalMidTermSkills = selectedCountList!.length;
                          });

                                    //add skills to created document in db here
                                    await Database.addSkills(compName: companyNameController.text, location: 'mid term', diagnName: assessNameController.text);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TeamLeadMailPage()));
                                  },
                                  child: Text('Proceed')),
                              SizedBox(width: 65.0),
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
                  child: Text('Submit'),
                ),
                SizedBox(width: 15.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    setState(() {
                      selectedCountList!.clear();
                      orderLines.clear();
                    });
                  },
                  child: Text(
                    'Clear List',
                  ),
                ),
              ],
            )),
        if (selectedCountList == null)
          Container(child: Center(child: Text('No skillsets selected')))
      ]),
    );
  }

//   ListView buildListViewSkills() {
//     return ListView.builder(
//          shrinkWrap: true, // 1st add
//         physics: ClampingScrollPhysics(),
//             itemCount: subSkill.length,
//             itemBuilder: (context, index) {
//               print('Whole list $subSkill');

//               // if (index <= 0) {

//               return

//       //         ConstrainedBox(
//       // constraints: BoxConstraints(maxHeight: 1000),
//       //                           child: ListView.builder(

//       //       itemCount: subSkill[index]['count'],
//       //       itemBuilder: (context, ind) {
//       //           return Card(
//       //             shape: RoundedRectangleBorder(
//       //               side: BorderSide(color: Colors.white70, width: 1),
//       //               borderRadius: BorderRadius.circular(100),
//       //             ),
//       //             margin: EdgeInsets.all(10.0),
//       //             child: ListTile(
//       //               title: Text(selectedCountList![ind]+'here'),
//       //               subtitle: Text(subSkill.toString()),
//       //             ),
//       //           );
//       //       }),
//       //         );
//       //         } else {
//       //           return ConstrainedBox(
//       // constraints: BoxConstraints(maxHeight: 10000),
//       //                               child: ListView.builder(

//       //       itemCount: subSkill[index]['count'],
//       //       itemBuilder: (context, ind) {
//       //         return Card(
//       //             shape: RoundedRectangleBorder(
//       //               side: BorderSide(color: Colors.white70, width: 1),
//       //               borderRadius: BorderRadius.circular(100),
//       //             ),
//       //             margin: EdgeInsets.all(10.0),
//       //             child: ListTile(
//       //               title: Text(selectedCountList![ind]),
//       //               subtitle: Text(subSkill.toString()),
//       //             ),
//       //         );
//       //       }
//       //             ),
//       //           );}

//               // Card(
//               //   shape: RoundedRectangleBorder(
//               //     side: BorderSide(color: Colors.white70, width: 1),
//               //     borderRadius: BorderRadius.circular(100),
//               //   ),
//               //   margin: EdgeInsets.all(10.0),
//               //   child: ListTile(
//               //     title: Text(selectedCountList![index]),
//               //     subtitle: Text(subSkill.toString()),
//               //   ),
//               // );
//             });
//   }
// }

  Widget getTextWidgets(List<String> strings) {
    return new Row(children: strings.map((item) => new Text(item)).toList());
  }
}
