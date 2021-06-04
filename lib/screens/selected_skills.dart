import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';
import 'package:sankofa_sme_exec/widgets/BottomNav.dart';


class SelectedSkillsPage extends StatefulWidget {
  @override
  _SelectedSkillsPageState createState() => _SelectedSkillsPageState();
}

class _SelectedSkillsPageState extends State<SelectedSkillsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Skills'),
      ),
      bottomNavigationBar: BottomNav(),
      body: Column(children: [
        if (selectedCountList != null)
          // Flexible(
          //   flex: 0,
          //   child: Text('Total skills selected ${selectedCountList!.length}')),
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
                      title: Text(selectedCountList![index]),
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
                                "Please not, selected diagnostics cannot be changed once submitted!"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamLeadMailPage()));
                                  }, child: Text('Proceed')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Edit Skills')),
                            ],
                          );
                        },
                      );
                    }else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Notice"),
                            content: Text(
                                "List is empty, there is nothing to submit!"),
                            actions: [
                             
                            ],
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
}
