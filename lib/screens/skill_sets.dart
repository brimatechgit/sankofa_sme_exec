// import 'package:flutter/material.dart';
// import 'package:filter_list/filter_list.dart';

// class SkillsPage extends StatelessWidget {
//   String title;
//   var skillSets;
//   SkillsPage({required this.title, required this.skillSets});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(this.title),
//       ),
//       body: Column(children: [
//         Expanded(
//           child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 2.0,
//                   mainAxisSpacing: 2.0),
//               itemCount: skillSets.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.white70, width: 1),
//                     borderRadius: BorderRadius.circular(100),
//                   ),
//                   margin: EdgeInsets.all(20.0),
//                   child: ListTile(
//                     title: Text(this.skillSets[index]['Skill'].toString()),
//                   ),
//                 );
//               }),
//         )
//       ]),
//     );
//   }
// }
