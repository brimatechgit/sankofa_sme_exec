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
          Flexible(
              flex: 0,
              child:
                  Text('Total skills selected ${selectedCountList!.length}')),
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
        Flexible(
          flex: 2,
          child: ListView.builder(
           shrinkWrap: true, // 1st add
          physics: ClampingScrollPhysics(),
              itemCount: subSkill.length,
              itemBuilder: (context, index) {
                print('Whole list $subSkill');

                if (index <= 0) {
                  
                return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 1000),
                                  child: ListView.builder(
                    

              itemCount: subSkill[index]['count'],
              itemBuilder: (context, ind) { 
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(selectedCountList![ind]+'here'),
                      subtitle: Text(subSkill.toString()),
                    ),
                  );
              }),
                );
                } else {
                  return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 10000),
                                      child: ListView.builder(
                      

              itemCount: subSkill[index]['count'],
              itemBuilder: (context, ind) { 
                return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(selectedCountList![ind]),
                      subtitle: Text(subSkill.toString()),
                    ),
                );
              }
                    ),
                  );}
                
                // Card(
                //   shape: RoundedRectangleBorder(
                //     side: BorderSide(color: Colors.white70, width: 1),
                //     borderRadius: BorderRadius.circular(100),
                //   ),
                //   margin: EdgeInsets.all(10.0),
                //   child: ListTile(
                //     title: Text(selectedCountList![index]),
                //     subtitle: Text(subSkill.toString()),
                //   ),
                // );
              }),
        ),


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
                                  onPressed: () {
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
}
