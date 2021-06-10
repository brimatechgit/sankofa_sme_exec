import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/selected_skills.dart';
import 'package:sankofa_sme_exec/screens/skill_sets.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:sankofa_sme_exec/widgets/custom_filter_list_dialog.dart';

List<String>? selectedCountList = [];
List<dynamic> countList = [];
List<Map<String, dynamic>> objList = [];
var orderLines = <Map>[];
var applied = false;
int checkedIndex = 0;
List<int> selectedIndexList = [];
var selectedTrack = [];
int count = 0;
int li = 0;
var outterList = [];
var subSkill = [];

class SkillSetsPage extends StatefulWidget {
  @override
  _SkillSetsPageState createState() => _SkillSetsPageState();
}

class _SkillSetsPageState extends State<SkillSetsPage> {
  Color fillColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    void _openFilterDialog(listVal, title, index) async {
      var selectedCountListInner = [];
      List<String> newList = [];
      // objList.add({

      // });
      for (var i = 0; i < listVal.length; i++) {
        newList.add(listVal[i]['Skill'].toString());
      }
      // selectedCountList!.clear();
      var len =
          selectedCountList!.length; // before we add anything to selected count

      print('first ${selectedCountList!.length}, len: $len');
      await CustomFilterListDialog.display<String>(context,
          listData: newList,
          selectedListData: selectedCountList,
          height: 480,
          headlineText: title,
          searchFieldHintText: "Search Here", choiceChipLabel: (item) {
        return item;
      }, validateSelectedItem: (list, val) {
        return list!.contains(val);
      }, onItemSearch: (list, text) {
        if (list!.any(
            (element) => element.toLowerCase().contains(text.toLowerCase()))) {
          return list
              .where((element) =>
                  element.toLowerCase().contains(text.toLowerCase()))
              .toList();
        } else {
          return [];
        }
      }, onApplyButtonClick: (list) {
        if (list != null) {
          //adds selected skills to

          if (!selectedIndexList.contains(index)) {
            selectedIndexList.add(index);
          } else {
            selectedIndexList.remove(index);
          }
          setState(() {
            //list of selected skills
            // selectedCountList!.clear();
            selectedCountList = List.from(list);
            

            //fillColor = Colors.lightBlue;
            // selectedCountList!.forEach((element) {

            //   objList.map((e) => null)
            // });
            //change skill sets color
            checkedIndex = index;
          });
          subSkill.add({'title':'$title', 'count': selectedCountList!.length.toInt()});

          selectedCountListInner.add(selectedCountList!.sublist(count));
          applied = true;
          objList.add({
            'SkillSet': '$title',
            'Skill': '${[list]}'
          });

          // // orderLines.add({'SkillSet': '$title', 'Skill': list});
          // selectedTrack.add(selectedCountList!.length);
          
          // print(selectedCountList!.getRange(
          //         (selectedCountList!.length.toInt() - selectedTrack[count]).toInt(),
          //         selectedCountList!.length.toInt()));

          // if (orderLines.length > 0 ) {
          //   print(selectedCountListInner);
          //   print(selectedCountList!.length.toInt() - selectedTrack[count].toInt());
          //   // print('list is ${selectedTrack[count-1]}, selected ${selectedCountList!.length}, count: $count, li is $li\n, start at ${(selectedCountList!.length.toInt() - selectedTrack[count-1]).toInt()} ,sublist :${selectedCountList!.sublist(
          //   //       (selectedCountList!.length.toInt() - selectedTrack[count-1]).toInt())}');
          //   // orderLines.add({
          //   //   'SkillSet': '$title',
          //   //   'Skill': selectedCountList!.sublist(
          //   //       selectedCountList!.length.toInt() - li)
          //   // });

          //   orderLines.add({'SkillSet': '$title', 'Skill': outterList});
          // } else {
          // }

            orderLines.add({'SkillSet': '$title', 'Skill': selectedCountList});
          // print(len);
          // if (selectedCountList!.length == selectedTrack[0]) {
          //   orderLines.add({'SkillSet': '$title', 'Skill': selectedCountList});
          // } else {

          //   li = selectedCountList!.sublist(
          //       (selectedCountList!.length - selectedTrack[count]).toInt(),
          //       selectedCountList!.length);
          //       print("list is $li");
          //   orderLines.add({
          //     'SkillSet': '$title',
          //     'Skill': selectedCountList!.sublist(
          //         (selectedCountList!.length - selectedTrack[count]).toInt(),
          //         selectedCountList!.length)
          //   });
          // }
        }
        // count++;
        // li = selectedTrack[count-1];
        Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      body: Column(
        children: [
          Text('Please Select 3 or more company related skills'),
          Flexible(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Skills').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        bool checked = index == checkedIndex;
                        fillColor = Colors.transparent;
                        DocumentSnapshot skills = snapshot.data!.docs[index];
                        // print(skills['Skills'].toString());
                        print(selectedCountList!.length);
                        //countList.add(skills['Skills'][index]['Skill']);
                        return GestureDetector(
                          onTap: () {
                            _openFilterDialog(
                                skills['Skills'], skills['SkillSet'], index);

                            // setState(() {
                            //   checkedIndex = index;
                            // });
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => SkillSetsPage(
                            //             title: skills['SkillSet'],
                            //             skillSets: skills['Skills'],
                            //           )),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              // color: checked ? Colors.orange : fillColor,
                              color: selectedIndexList.contains(index)
                                  ? Colors.green
                                  : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.all(10.0),
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    skills['SkillSet'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
          Flexible(
              flex: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamLeadMailPage()),
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SelectedSkillsPage()),
                          );
                        },
                        child: Text(
                            'Review Skills (${selectedCountList!.length})'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blueGrey),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Notice"),
                                content: Text(
                                    "Please note, assessment creation process will be cancelled"),
                                actions: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    label: Text('Continue'),
                                    icon: Icon(Icons.keyboard_backspace),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                      onPressed: () {},
                                      child: Text('Cancel')),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Cancel'),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection('Skills').snapshots(),
      //   builder: (context, snapshot){
      //     return ListView.builder(
      //       itemCount: snapshot.data!.documents.length,
      //       itemBuilder: (context, index){

      //     })
      //   }
      // ),
      // bottomNavigationBar: BottomNav(),
    );
  }
}
