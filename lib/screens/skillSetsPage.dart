import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/selected_skills.dart';
import 'package:sankofa_sme_exec/screens/skill_sets.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';

List<String>? selectedCountList = [];
List<dynamic> countList = [];
List<Map<String, dynamic>> objList = [];
var orderLines = <Map>[];

class SkillSetsPage extends StatefulWidget {
  @override
  _SkillSetsPageState createState() => _SkillSetsPageState();
}

class _SkillSetsPageState extends State<SkillSetsPage> {
  @override
  Widget build(BuildContext context) {
    void _openFilterDialog(listVal, title) async {
      List<String> newList = [];
      // objList.add({

      // });
      for (var i = 0; i < listVal.length; i++) {
        newList.add(listVal[i]['Skill'].toString());
      }
      // selectedCountList!.clear();
      await FilterListDialog.display<String>(context,
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
          setState(() {
            //list of selected skills
            // selectedCountList!.clear();
            selectedCountList = List.from(list);
            
            // selectedCountList!.forEach((element) {

            //   objList.map((e) => null)
            // });
            //change skill sets color
          });
          
          objList.add({'SkillSet': '$title', 'Skill': '${[selectedCountList]}'});
          orderLines.add({'SkillSet': '$title', 'Skill': selectedCountList});
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
                        DocumentSnapshot skills = snapshot.data!.docs[index];
                        // print(skills['Skills'].toString());
                        print(selectedCountList!.length);
                        //countList.add(skills['Skills'][index]['Skill']);
                        return GestureDetector(
                          onTap: () {
                            _openFilterDialog(
                                skills['Skills'], skills['SkillSet']);
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
                                builder: (context) => SelectedSkillsPage()),
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
