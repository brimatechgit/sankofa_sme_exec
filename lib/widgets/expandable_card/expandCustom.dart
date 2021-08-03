import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class ExpandCustom extends StatefulWidget {
  const ExpandCustom({
    Key? key,
    required this.cardA,
    required this.child,
    required this.subText,
    required this.leadText,
  }) : super(key: key);

  final GlobalKey<ExpansionTileCardState> cardA;
  final String subText;
  final String leadText;
  final Widget child;

  @override
  _ExpandCustomState createState() => _ExpandCustomState();
}

class _ExpandCustomState extends State<ExpandCustom> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      baseColor: Colors.blueGrey[500],
      // expandedColor: Colors.red[50],
      key: widget.cardA,
      title: Text(this.widget.leadText),
      subtitle: Text(this.widget.subText),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: this.widget.child,
          ),
        ),
      ],
    );
  }
}

class ExpandCustomActivities extends StatefulWidget {
  const ExpandCustomActivities({
    Key? key,
    required this.cardA,
    required this.child,
    required this.subText,
    required this.leadText,
  }) : super(key: key);

  final GlobalKey<ExpansionTileCardState> cardA;
  final String subText;
  final String leadText;
  final Widget child;

  @override
  _ExpandCustomActivitiesState createState() => _ExpandCustomActivitiesState();
}

class _ExpandCustomActivitiesState extends State<ExpandCustomActivities> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      initiallyExpanded: true,
      baseColor: Colors.white,
      // expandedColor: Colors.red[50],
      key: widget.cardA,
      title: Text(this.widget.leadText),
      subtitle: Text(this.widget.subText),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: this.widget.child,
          ),
        ),
      ],
    );
  }
}
