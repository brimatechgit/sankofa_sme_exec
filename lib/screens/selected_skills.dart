import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';

List<Widget> widgetList = [];

class SelectedSkillsPage extends StatefulWidget {
  @override
  _SelectedSkillsPageState createState() => _SelectedSkillsPageState();
}

class _SelectedSkillsPageState extends State<SelectedSkillsPage> {
  _listfunc() {
    // int iterator = subSkill.length;
    // for (var j = 0; j < subSkill.length; j++) {
    //   if (j <= 0) {
    //     for (var i = 0; i < selectedCountList!.sublist(0).length; i++) {
    //       widgetList.add(Card(
    //           child: ListTile(
    //         title: Text(selectedCountList![i] + ' ' + i.toString()),
    //         subtitle: Text(subSkill[j]['title'] + ' testtt ' + j.toString()),
    //       )));
    //     }
    //   } else {
    //     for (var i = 0;
    //         i <
    //             selectedCountList!
    //                 .sublist(subSkill[j]['count'] - subSkill[j - 1]['count'])
    //                 .length;
    //         i++) {
    //       list.add(Card(
    //           child: ListTile(
    //         title: Text(selectedCountList![i] + ' ' + i.toString()),
    //         subtitle: Text(subSkill[j]['title'] + ' ' + j.toString()),
    //       )));
    //     }
    //   }
    // }

    // for (var j = 0; j < subSkill.length; j++) {
    //   // int countTrack = subSkill[j]['count'] - subSkill[j - 1]['count'];
    //   for (var i = 0; i < subSkill[j]['count']; i++) {
    //     list.add(Card(
    //         child: ListTile(
    //       title: Text(selectedCountList![i] + ' ' + i.toString()),
    //       subtitle: Text(subSkill[j]['title'] + ' ' + j.toString()),
    //     )));
    //   }
    // }

    // for (var i = 0; i < subSkill.length; i++) {
    //   //   //count - [count-1]
    //   //   // int countTrack = subSkill[i]['count'];
    //   if (i > 0) {
    //     int countTrack = subSkill[i]['count'] - subSkill[i - 1]['count'];
    //     for (var j = countTrack; j >= countTrack; --j) {
    //       print('ind $j');
    //       list.add(Card(
    //           child: ListTile(
    //         title: Text(selectedCountList![j] + ' ' + i.toString()),
    //         subtitle: Text(subSkill[i]['title']),
    //       )));
    //       iterator++;
    //     }
    //   } else {
    //     list.add(Card(
    //         child: ListTile(
    //       title: Text(selectedCountList![iterator]),
    //       subtitle: Text(subSkill[i]['title'] + ' elsehaha'),
    //     )));
    //     iterator++;
    //   }
    // }
  }

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
                  Text('Total skills selected ${selectedCountList!.length}')),

        Flexible(
          flex: 2,
          child: ListView.builder(
              itemCount: selectedCountList!.length,
              itemBuilder: (context, index) {
                print('Whole list $selectedCountList');
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(outterList[index]['skill'].toString()),
                    subtitle: Text(outterList[index]['title'].toString()),
                  ),
                );
              }),
        ),

        // Flexible(
        //     child: Column(
        //   children: [
        //     Text('selected Categories'),

        //     Flexible(
        //       child: GridView(
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 3,
        //           mainAxisSpacing: 0,
        //           crossAxisSpacing: 0,
        //         ),
        //         children: List.generate(
        //           objList.length,
        //           (index) => Container(
        //             height: 25.0,
        //             child: Card(
        //               shape: RoundedRectangleBorder(
        //                 side: BorderSide(color: Colors.white70, width: 1),
        //                 borderRadius: BorderRadius.circular(25),
        //               ),
        //               margin: EdgeInsets.all(5.0),
        //               child: ListTile(
        //                   title: Text(
        //                 objList[index]['SkillSet'],
        //                 style: TextStyle(
        //                     fontSize: 12.0), /*overflow: TextOverflow.ellipsis*/
        //               )
        //                   // Text(orderLines[index]['Skill'][ind].toString())

        //                   ),
        //             ),
        //           ),
        //         ),
        //       ),

        //       //     GridView.count(

        //       //   // Create a grid with 2 columns. If you change the scrollDirection to
        //       //   // horizontal, this produces 2 rows.
        //       //   crossAxisCount: 3,
        //       //   crossAxisSpacing: 0.0,
        //       //    mainAxisSpacing: 0.0,

        //       //   padding: EdgeInsets.zero,
        //       //   // Generate 100 widgets that display their index in the List.
        //       //   children: List.generate(objList.length, (index) {
        //       //     return Center(
        //       //       child:  Card(
        //       //                     shape: RoundedRectangleBorder(
        //       //                       side: BorderSide(color: Colors.white70, width: 1),
        //       //                       borderRadius: BorderRadius.circular(100),
        //       //                     ),
        //       //                     margin: EdgeInsets.all(5.0),
        //       //                     child: ListTile(title:
        //       //                     Text(objList[index]['SkillSet'], style: TextStyle(fontSize: 12.0),/*overflow: TextOverflow.ellipsis*/)
        //       //                     // Text(orderLines[index]['Skill'][ind].toString())

        //       //                     ),
        //       //                   ),
        //       //     );
        //       //   }),
        //       // ),
        //     )

        //     // GridView.count(

        //     //       crossAxisCount: 2,
        //     //       crossAxisSpacing: 0,
        //     //       mainAxisSpacing: 0),

        //     //  children: List.generate(objList.length, index) {
        //     //     return Text(objList[index]['SkillSet']);
        //     //   }, ),
        //   ],
        // )),
        // Flexible(
        //   flex: 2,
        //   child: ListView.builder(
        //       itemCount: selectedCountList!.length,
        //       itemBuilder: (context, index) {
        //         print('Whole list $selectedCountList');
        //         return Card(
        //           shape: RoundedRectangleBorder(
        //             side: BorderSide(color: Colors.white70, width: 1),
        //             borderRadius: BorderRadius.circular(100),
        //           ),
        //           margin: EdgeInsets.all(10.0),
        //           child: ListTile(
        //             title: Text(selectedCountList![index]),
        //             subtitle: Text(subSkill.toString()),
        //           ),
        //         );
        //       }),
        // ),
        // Flexible(
        //   flex: 2,
        //   child: ListView.builder(
        //       itemCount: widgetList.length,
        //       itemBuilder: (context, index) {
        //         print('Whole list $selectedCountList');
        //         //  int iterator = index;
        //         // _listfunc();
        //         print(widgetList);
        //         //   for (var i = 0; i < selectedCountList!.length; i++) {
        //         //     list.add(Card(
        //         //         child: ListTile(
        //         //       title: Text(selectedCountList![i]+' ' + i.toString()),
        //         //       subtitle: Text(subSkill[index]['title']),
        //         //     )));
        //         //   }

        //         // for (var i = 0; i < subSkill.length; i++) {

        //         //   //count - [count-1]
        //         //   // int countTrack = subSkill[i]['count'];
        //         //   if(i > 0){
        //         //     int countTrack = subSkill[i]['count'] - subSkill[i-1]['count'];
        //         //   for (var j = countTrack; j >= countTrack; --j) {
        //         //     print('ind $j');
        //         //     list.add(Card(
        //         //         child: ListTile(
        //         //       title: Text(selectedCountList![j]+' ' + i.toString()),
        //         //       subtitle: Text(subSkill[i]['title']),
        //         //     )));
        //         //     iterator++;
        //         //   }
        //         //   } else {
        //         //     list.add(Card(
        //         //         child: ListTile(
        //         //       title: Text(selectedCountList![iterator]),
        //         //       subtitle: Text(subSkill[i]['title']+' elsehaha'),
        //         //     )));
        //         //     iterator++;
        //         //   }
        //         // }

        //         return widgetList[index];

        //         // Card(
        //         //   shape: RoundedRectangleBorder(
        //         //     side: BorderSide(color: Colors.white70, width: 1),
        //         //     borderRadius: BorderRadius.circular(100),
        //         //   ),
        //         //   margin: EdgeInsets.all(10.0),
        //         //   child: ListTile(
        //         //     title: Text(selectedCountList![index]),
        //         //     subtitle: Text(() {
        //         //       // subSkill.forEach((element) {
        //         //       //   return element;
        //         //       // });

        //         //       // if (index > subSkill.length) {
        //         //       //   return '';
        //         //       // } else {
        //         //       //   if (subSkill.length < 0) {
        //         //       //     return subSkill[0]['title'].toString();
        //         //       //   } else {
        //         //       //     // int len = subSkill[index]['count'];
        //         //       //     // len - subSkill[index-1]['count'];

        //         //       //     return subSkill[index]['title'].toString();
        //         //       //   }
        //         //       // }

        //         //       if (index > subSkill.length) {
        //         //         return '';
        //         //       } else {
        //         //         return subSkill[index]['title'];
        //         //       }
        //         //     }()),
        //         //   ),
        //         // );
        //       }),
        // ),

        // Flexible(
        //   flex: 2,
        //   child: buildListViewSkills(),
        // ),

        // Flexible(
        //   flex: 2,
        //   child: ListView.builder(
        //       itemCount: subSkill.length,
        //       itemBuilder: (context, index) {

        //       return ListView.builder(
        //       itemCount: subSkill.length,
        //       itemBuilder: (context, index) {

        //         return Text('data');
        //       }
        //       );}
        //   // child: ListView.builder(
        //   //     itemCount: subSkill.length,
        //   //     itemBuilder: (context, index) {
        //   //       if(index == 0){

        //   //         int len = subSkill[0]['count'];
        //   //         return ListView.builder(
        //   //     itemCount: selectedCountList!.length,
        //   //     itemBuilder: (context, ind) {

        //   //                       return Column(
        //   //                         children: [

        //   //                           Card(
        //   //                             shape: RoundedRectangleBorder(
        //   //                               side: BorderSide(color: Colors.white70, width: 1),
        //   //                               borderRadius: BorderRadius.circular(100),
        //   //                             ),
        //   //                             margin: EdgeInsets.all(10.0),
        //   //                             child: ListTile(
        //   //                 title: Text(selectedCountList![ind]),
        //   //                 subtitle: Text(subSkill.toString()),
        //   //               ),
        //   //                           ),
        //   //                         ],
        //   //                       );

        //   //     }
        //   // );

        //   //       }
        //   //        else {
        //   //          int len = 0;
        //   //         if(index >= 1)
        //   //           len = subSkill[index]['count'] - subSkill[index-1]['count'];
        //   //         else
        //   //           len = subSkill[index]['count'];
        //   //         return ListView.builder(
        //   //     itemCount: selectedCountList!.length,
        //   //     itemBuilder: (context, ind) {

        //   //                       return Column(
        //   //                         children: [

        //   //                           Card(
        //   //                             shape: RoundedRectangleBorder(
        //   //                               side: BorderSide(color: Colors.white70, width: 1),
        //   //                               borderRadius: BorderRadius.circular(100),
        //   //                             ),
        //   //                             margin: EdgeInsets.all(10.0),
        //   //                             child: ListTile(
        //   //                 title: Text(selectedCountList![ind]),
        //   //                 subtitle: Text(subSkill.toString()),
        //   //               ),
        //   //                           ),
        //   //                         ],
        //   //                       );

        //   //     }
        //   // );
        //   //     }}),
        // ),

        // Text(objList[index]['SkillSet'].toString()),
        // Flexible(
        //   flex: 2,
        //   child: ListView.builder(
        //       itemCount: orderLines.length,
        //       itemBuilder: (context, index) {
        //         var value = [];

        //         value.add(orderLines[index]['Skill']);
        //         var list = [];

        //         // print('Whole list $index ${objList[0]['Skill']}');
        //         // print('Whole list $index ${orderLines[0]['Skill']}');
        //         print(
        //             'Whole list $index  ${orderLines[index]['SkillSet']} ${orderLines[index]['Skill'].length}');

        //         // print('Whole list $index ${}');

        //         if (orderLines[index]['Skill'].length > 0) {
        //           print(
        //               'Whole list $index  ${orderLines[index]['SkillSet']} ${orderLines[index]['Skill'][0]}');
        //           int len = orderLines[index]['Skill'].length;
        //           print('length of skillsets is $len');
        //           return Column(
        //             children: [
        //               Text(orderLines[index]['SkillSet']),
        //               // Text(orderLines[index]['SkillSet']),
        //               Text(selectedTrack.toString()),
        //               Column(

        //                 children: List.generate(len, (ind) {
        //                   return Column(
        //                     children: [

        //                       Card(
        //                         shape: RoundedRectangleBorder(
        //                           side: BorderSide(color: Colors.white70, width: 1),
        //                           borderRadius: BorderRadius.circular(100),
        //                         ),
        //                         margin: EdgeInsets.all(10.0),
        //                         child: ListTile(title:
        //                         Text(selectedCountList[index].toString())
        //                         // Text(orderLines[index]['Skill'][ind].toString())

        //                         ),
        //                       ),
        //                     ],
        //                   );
        //                 }),
        //                 // children: [
        //                 //   Text(orderLines[index]['SkillSet']),
        //                 //   for (var item in value)
        //                 //     Card(
        //                 //     shape: RoundedRectangleBorder(
        //                 //       side: BorderSide(color: Colors.white70, width: 1),
        //                 //       borderRadius: BorderRadius.circular(100),
        //                 //     ),
        //                 //     margin: EdgeInsets.all(10.0),
        //                 //     child: ListTile(title: Text(item.toString())),
        //                 //   ),

        //                 //   List.generate(length, (index) => null)

        //                 // ],
        //               ),
        //             ],
        //           );
        //         } else {
        //           return SizedBox.shrink();
        //         }
        //       }),
        // ),
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
                    if (selectedCountList!.length > 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Notice"),
                            content: Text(
                                "Please note, selected skillsets cannot be changed once submitted!"),
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
                                    //add skills to created document in db here
                                    await Database.addSkills(reference: companyNameController.text, );

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
