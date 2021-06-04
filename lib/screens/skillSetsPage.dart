import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/selected_skills.dart';
import 'package:sankofa_sme_exec/screens/skill_sets.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';

List<String>? selectedCountList = [];
List<dynamic> countList = [];

class SkillSetsPage extends StatefulWidget {
  @override
  _SkillSetsPageState createState() => _SkillSetsPageState();
}

class _SkillSetsPageState extends State<SkillSetsPage> {
  @override
  Widget build(BuildContext context) {
    void _openFilterDialog(listVal, title) async {
      List<String> newList = [];
      for (var i = 0; i < listVal.length; i++) {
        newList.add(listVal[i]['Skill'].toString());
      }
      await FilterListDialog.display<String>(context,
          listData: newList,
          selectedListData: selectedCountList,
          height: 480,
          headlineText: "Select Count",
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
            selectedCountList = List.from(list);
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
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectedSkillsPage()),
                    );
                  },
                  child: Text('Review Skills (${selectedCountList!.length})'),
                ),
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
