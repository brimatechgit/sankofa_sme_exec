import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/selected_skills.dart';
import 'package:sankofa_sme_exec/screens/skillScreens/medTerm_skills_review.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/screens/skill_sets.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:sankofa_sme_exec/widgets/custom_filter_list_dialog.dart';

// List<String>? selectedMidTermSkillList = [];
// List<dynamic> countList = [];
// List<Map<String, dynamic>> objList = [];
// var orderLines = <Map>[];
// var applied = false;
// int checkedIndex = 0;
// List<int> selectedIndexList = [];
// var selectedTrack = [];
// int count = 0;
// int li = 0;
var midTermList = [];
// var subSkill = [];
// var fillList = [];
List<String>? selectedMidTermSkillList = [];

class MediumTermSkillsPage extends StatefulWidget {
  @override
  _MediumTermSkillsPageState createState() => _MediumTermSkillsPageState();
}

class _MediumTermSkillsPageState extends State<MediumTermSkillsPage> {
  Color fillColor = Colors.transparent;

  List<int> selectedIndexList = [];
  int checkedIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _openFilterDialog(listVal, title, index) async {
      var selectedCountListInner = [];
      List<String> newList = [];
      for (var i = 0; i < listVal.length; i++) {
        newList.add(listVal[i]['Skill'].toString());
      }
      // selectedMidTermSkillList!.clear();
      var len = selectedMidTermSkillList!
          .length; // before we add anything to selected count

      print('first ${selectedMidTermSkillList!.length}, len: $len');
      await CustomFilterListDialog.display<String>(context,
          locationData: 'medium term',
          width: 500,
          titleStr: title,
          listData: newList,
          selectedListData: selectedMidTermSkillList,
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
            selectedMidTermSkillList = List.from(list);

            //change skill sets color
            checkedIndex = index;
          });
        }
        Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Text('Please Select 3 or more company related medium term skills'),
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

                  return LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            bool checked = index == checkedIndex;
                            fillColor = Colors.transparent;
                            DocumentSnapshot skills =
                                snapshot.data!.docs[index];
                            // print(skills['Skills'].toString());
                            print(selectedMidTermSkillList!.length);
                            //countList.add(skills['Skills'][index]['Skill']);
                            return GestureDetector(
                              onTap: () {
                                _openFilterDialog(skills['Skills'],
                                    skills['SkillSet'], index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Card(
                                  // color: checked ? Colors.orange : fillColor,
                                  color: selectedIndexList.contains(index)
                                      ? Colors.green
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 1),
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
                    } else {
                      return SizedBox(
                        width: 900,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              bool checked = index == checkedIndex;
                              fillColor = Colors.transparent;
                              DocumentSnapshot skills =
                                  snapshot.data!.docs[index];
                              // print(skills['Skills'].toString());
                              print(selectedMidTermSkillList!.length);
                              //countList.add(skills['Skills'][index]['Skill']);
                              return GestureDetector(
                                onTap: () {
                                  _openFilterDialog(skills['Skills'],
                                      skills['SkillSet'], index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Card(
                                    // color: checked ? Colors.orange : fillColor,
                                    color: selectedIndexList.contains(index)
                                        ? Colors.green
                                        : Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
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
                            }),
                      );
                    }
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
                                builder: (context) => SelectedMediumSkillsPage(
                                      totalSkills: selectedMidTermSkillList!,
                                    )),
                          );
                        },
                        child: Text(
                            'Review Skills (${selectedMidTermSkillList!.length})'),
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
    );
  }
}
