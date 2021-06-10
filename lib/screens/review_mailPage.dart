import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';


class ReviewMailPage extends StatefulWidget {
  const ReviewMailPage({ Key? key }) : super(key: key);

  @override
  _ReviewMailPageState createState() => _ReviewMailPageState();
}

class _ReviewMailPageState extends State<ReviewMailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('review mail list'),),
      body: Column(
        children: [
         Flexible(
           flex: 2,
            child: ListView.builder(

              itemCount: teamLeadMailList.length,
                itemBuilder: (context, index) { 

                  return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                                                      child: ListTile(
                              
                              title: Text(teamLeadMailList[index]['name']),
                              subtitle: Text(teamLeadMailList[index]['email']),
                            ),
                          ),

                          Flexible(
                            flex: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(Icons.close, color: Colors.redAccent,),
                            ))
                        ],
                      ),
                    );
                }
            ),
          ),

          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
              onPressed: (){},
              child: Text('Submit'), ),
            ))
        ]
      ),
    );
  }
}