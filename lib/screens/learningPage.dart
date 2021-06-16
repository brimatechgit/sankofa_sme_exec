import 'package:flutter/material.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Learning'),),
      body: Container(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Coming Soon')),
        ],
      ),),
    );
  }
}