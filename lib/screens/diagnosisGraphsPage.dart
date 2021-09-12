import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/graphPages/graphsPage.dart';
import 'package:sankofa_sme_exec/screens/skillScreens/mediumTermSkills.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';
import 'package:sankofa_sme_exec/utilities/globalVars.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DiagnosisGraphPage extends StatefulWidget {
  final String ref;
  final ownerID;
  const DiagnosisGraphPage({Key? key, required this.ref, required this.ownerID})
      : super(key: key);

  @override
  _DiagnosisGraphPageState createState() => _DiagnosisGraphPageState();
}

class _DiagnosisGraphPageState extends State<DiagnosisGraphPage> {
  late List<GDPData> _selfChartData;
  late List<GDPData> _teamChartData;
  late TooltipBehavior _tooltipBehavior;
  String finalizeBtn = 'Finalize and Proceed';

  @override
  void initState() {
    _selfChartData = getSelfChartData();
    _teamChartData = getTeamChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnostic review'),
      ),
      //add graphs here

      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            // self assessments graph here
            //have a counter function that checks all self assessments in db, if selfassessment is empty,
            //increment not completed value of the chart

            //soooo futurebuilder??
            Card(
              child: SfCircularChart(
                title: ChartTitle(text: 'Self Assessment'),
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  PieSeries<GDPData, String>(
                      dataSource: _selfChartData,
                      xValueMapper: (GDPData data, _) => data.continent,
                      yValueMapper: (GDPData data, _) => data.gdp,
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                      enableTooltip: false)
                ],
              ),
            ),
            Card(
              child: SfCircularChart(
                title: ChartTitle(text: 'Team Assessment'),
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  PieSeries<GDPData, String>(
                      dataSource: _teamChartData,
                      xValueMapper: (GDPData data, _) => data.continent,
                      yValueMapper: (GDPData data, _) => data.gdp,
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                      enableTooltip: false)
                ],
              ),
            ),

            Card(
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                title: ChartTitle(text: ''),
                legend: Legend(isVisible: true),
                primaryXAxis: DateTimeAxis(
                  isVisible: false,
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                    labelFormat: '{value}%',
                    isVisible: false,
                    axisLine: const AxisLine(width: 0),
                    minorTickLines: const MinorTickLines(size: 0)),
                tooltipBehavior: TooltipBehavior(enable: false),
                series: _getDefaultScatterSeries(),
              ),
            ),

//show all team members their med and short term skills

            Card(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('/Diagnostics/0aVE0OeC18vY1NRyEOzL/Team')
                      .snapshots(), //has to be a collection
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<ChartSampleData> chartItems = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      chartItems.add(
                        ChartSampleData(
                          x: DateTime(2012), //team short term assessm avr
                          y: 0.01, //team mid term assessm avr
                          yValue: -0.03, //team short term assessm avr
                          secondSeriesYValue:
                              0.10, //team short term assessm avr
                        ),
                      );
                    }

                    return Text('data: ${chartItems.length}');
                  }),
            ),

            //Team assessment graphs here

            //finalize and proceed button
            //navigate to page with filters
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text(finalizeBtn),
                  onPressed: () async {
                    //db should finalize the whole assessment
                    await Database.updateDiagnostic(
                      reference: this.widget.ref,
                    );
                    //change button text to generate report
                    setState(() {
                      finalizeBtn = 'Generate Report';
                    });

                    //navigate to filteredGraphs page
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => SkillsGraphs(
                    //               docuID: this.widget.ref,
                    //             )),
                    //     ModalRoute.withName('/'));
                  },
                ),
              ),
            ),

            SizedBox(
              height: 35.0,
            )
          ]),
        ),
      ),
      // floating actionbuton
      //bottom right finalise button here
      //should navigate to skills page with spider graph that shows average
      ////
      ///

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // should change status of the assessment and diagnostic to finalized

          await Database.updateDiagnostic(
            reference: this.widget.ref,
          );
        },
        label: const Text('Finalize'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  //should be fetching data from db
  List<GDPData> getSelfChartData() {
    final List<GDPData> chartData = [
      GDPData('Completed', completed),
      GDPData('InComplete', incomplete),
    ];
    return chartData;
  }

  List<GDPData> getTeamChartData() {
    final List<GDPData> chartData = [
      GDPData('Completed', teamAcompleted),
      GDPData('InComplete', teamAincomplete),
    ];
    return chartData;
  }

  /// Returns the list of chart series
  /// which need to render on the scatter chart.
  List<ScatterSeries<ChartSampleData, DateTime>> _getDefaultScatterSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: DateTime(2006, 1, 1),
          y: 0.01,
          yValue: -0.03,
          secondSeriesYValue: 0.10),
      ChartSampleData(
          x: DateTime(2007, 1, 1),
          y: 0.03,
          yValue: -0.02,
          secondSeriesYValue: 0.08),
      ChartSampleData(
          x: DateTime(2008, 1, 1),
          y: -0.06,
          yValue: -0.13,
          secondSeriesYValue: -0.03),
      ChartSampleData(
          x: DateTime(2009, 1, 1),
          y: -0.03,
          yValue: -0.04,
          secondSeriesYValue: 0.04),
      ChartSampleData(
          x: DateTime(2010, 1, 1),
          y: 0.09,
          yValue: 0.07,
          secondSeriesYValue: 0.19),
      ChartSampleData(
          x: DateTime(2011, 1, 1), y: 0, yValue: 0.04, secondSeriesYValue: 0),
      ChartSampleData(
          x: DateTime(2012, 1, 1),
          y: 0.01,
          yValue: -0.01,
          secondSeriesYValue: -0.09),
      ChartSampleData(
          x: DateTime(2013, 1, 1),
          y: 0.05,
          yValue: 0.05,
          secondSeriesYValue: 0.10),
      ChartSampleData(
          x: DateTime(2014, 1, 1),
          y: 0,
          yValue: 0.08,
          secondSeriesYValue: 0.05),
      ChartSampleData(
          x: DateTime(2015, 1, 1),
          y: 0.1,
          yValue: 0.01,
          secondSeriesYValue: -0.04),
      ChartSampleData(
          x: DateTime(2016, 1, 1),
          y: 0.08,
          yValue: 0,
          secondSeriesYValue: 0.02),
    ];

    return <ScatterSeries<ChartSampleData, DateTime>>[
      ScatterSeries<ChartSampleData, DateTime>(
          dataSource: chartData,
          opacity: 0.7,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          markerSettings: const MarkerSettings(height: 15, width: 15),
          name: 'Brazil'),
      ScatterSeries<ChartSampleData, DateTime>(
          opacity: 0.7,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          markerSettings: const MarkerSettings(height: 15, width: 15),
          name: 'Canada'),
      ScatterSeries<ChartSampleData, DateTime>(
        dataSource: chartData,
        color: const Color.fromRGBO(0, 168, 181, 1),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        name: 'India',
        markerSettings: const MarkerSettings(height: 15, width: 15),
      )
    ];
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}

class ChartSampleData {
  ChartSampleData(
      {required this.x,
      required this.y,
      required this.secondSeriesYValue,
      required this.yValue});
  final DateTime x;
  final double y;
  final double yValue;
  final double secondSeriesYValue;
}
