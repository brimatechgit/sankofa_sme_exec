import 'package:flutter/material.dart';
import 'custom_slider_thumb_circle.dart';

// import 'custom_slider_thumb_circle.dart';

class UserSliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  double currValue;
  final bool fullWidth;
  final Function(int value) onChanged;

  UserSliderWidget(
      {required this.sliderHeight,
      required this.max,
      required this.min,
      required this.currValue,
      this.fullWidth = false,
      required this.onChanged});

  @override
  _UserSliderWidgetState createState() => _UserSliderWidgetState();
}

class _UserSliderWidgetState extends State<UserSliderWidget> {
  double currentValue = 50;

  @override
  Widget build(BuildContext context) {
    //currentValue = this.widget.currValue;
    // double currentValue = this.widget.currValue;
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .3)),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFFffad05),
              const Color(0xFF5BC0EB),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.00),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor,
            2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              'A',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(0.5),
                    inactiveTrackColor: Colors.white.withOpacity(0.5),

                    trackHeight: 8.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: this.widget.sliderHeight * .3,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
                    //overlayColor: Colors.white.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                  ),
                  child: Slider(
                    min: widget.min.toDouble(),
                    max: widget.max.toDouble(),
                    value: currentValue,
                    onChanged: (value) {
                      setState(() {
                        currentValue = value;
                      });
                      widget.onChanged(value.round());
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Text(
              'B', //slider left/right value text
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
