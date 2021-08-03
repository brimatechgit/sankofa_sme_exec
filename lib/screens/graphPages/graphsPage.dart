import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/skillScreens/mediumTermSkills.dart';
import 'package:sankofa_sme_exec/widgets/expandable_card/expandCustom.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SkillsGraphs extends StatefulWidget {
  const SkillsGraphs({Key? key, required this.docuID}) : super(key: key);
  final docuID;

  @override
  _SkillsGraphsState createState() => _SkillsGraphsState();
}

class _SkillsGraphsState extends State<SkillsGraphs> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  //fetch skills from db
  //put values in array, to be used in graphs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('skills Graphs'),
      ),
      body: Container(
        //stream builder fetchin user details
        //listview for each member involved w/ diagnostic
        //graph for each skill

        //scatter comparisons

        //proposed intervention/training section
        // --> will impliment

        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('/Diagnostics/${this.widget.docuID}/Team')
                .snapshots(), //has to be a collection
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // bool checked = index == checkedIndex;
                    // fillColor = Colors.transparent;
                    final GlobalKey<ExpansionTileCardState> card =
                        new GlobalKey();
                    DocumentSnapshot diagnostic = snapshot.data!.docs[index];
                    // print(skills['Skills'].toString());
                    // print(selectedCountList!.length);
                    //countList.add(skills['Skills'][index]['Skill']);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpandCustom(
                          cardA: card,
                          leadText: diagnostic.get('Name'),
                          subText: diagnostic.get('Role'),
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MidTermList(
                                                  midTermList: diagnostic.get(
                                                      'Self Assessment Result Medium Term'),
                                                  docuID: this.widget.docuID,
                                                )));
                                  },
                                  child: Card(
                                    child: Text('Medium Term Skills'),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NearTermList(
                                                  nearTermList: diagnostic.get(
                                                      'Self Assessment Result Short Term'),
                                                  docuID: this.widget.docuID,
                                                )));
                                  },
                                  child: Card(
                                    child: Text('Near Term Skills'),
                                  )),
                            ],
                          )),
                    );
                  });
            }),
      ),
    );
  }
}

class MidTermList extends StatefulWidget {
  const MidTermList({Key? key, required this.docuID, required this.midTermList})
      : super(key: key);
  final docuID;
  final midTermList;

  @override
  _MidTermListState createState() => _MidTermListState();
}

class _MidTermListState extends State<MidTermList> {
  late List<GDPData> _chartData;

  List<GDPData> data = [];

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = data;
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  addData(skill, intData) {
    for (var i = 0; i < skill.length; i++) {
      data.add(GDPData('${skill[i]['skill']}', intData[i].toInt()));
    }

    _chartData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medium Term Skills'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  '/Diagnostics/4U5r5ImEHDJ5iszKMsdi/Strategic Skills/testing/Medium Term Skills/')
              .snapshots(), //has to be a collection
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            DocumentSnapshot diagnostic = snapshot.data!.docs[0];

            addData(diagnostic.get('Skills'), this.widget.midTermList);

            return SfCircularChart(
              // title: ChartTitle(
              //     text: 'Continent wise GDP - 2021 \n (in billions of USD)'),
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                RadialBarSeries<GDPData, String>(
                    dataSource: _chartData,
                    xValueMapper: (GDPData data, _) => data.continent,
                    yValueMapper: (GDPData data, _) => data.gdp,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    maximumValue: 10)
              ],
            );
          }),
    );
  }
}

class NearTermList extends StatefulWidget {
  const NearTermList(
      {Key? key, required this.docuID, required this.nearTermList})
      : super(key: key);
  final docuID;
  final nearTermList;

  @override
  _NearTermListState createState() => _NearTermListState();
}

class _NearTermListState extends State<NearTermList> {
  late List<GDPData> _chartData;
  List<GDPData> data = [];
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = data;
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  addData(skill, intData) {
    for (var i = 0; i < skill.length; i++) {
      data.add(GDPData('${skill[i]['skill']}', intData[i].toInt()));
    }

    _chartData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Near Term Skills'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  '/Diagnostics/4U5r5ImEHDJ5iszKMsdi/Strategic Skills/testing/Short Term Skills/')
              .snapshots(), //has to be a collection
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            DocumentSnapshot diagnostic = snapshot.data!.docs[0];

            addData(diagnostic.get('Skills'), this.widget.nearTermList);

            print(_chartData);

            return SfCircularChart(
              // title: ChartTitle(
              //     text: 'Continent wise GDP - 2021 \n (in billions of USD)'),
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                RadialBarSeries<GDPData, String>(
                    dataSource: _chartData,
                    xValueMapper: (GDPData data, _) => data.continent,
                    yValueMapper: (GDPData data, _) => data.gdp,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    maximumValue: 10)
              ],
            );
          }),
    );
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}


// Text(diagnostic.get('Skills')[index]['skill'])
