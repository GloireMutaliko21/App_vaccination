import 'package:flutter/material.dart';
import 'package:v_connect/Screens/Signup/components/utils.dart';

class SliderLabelWidget extends StatefulWidget {
  @override
  _SliderLabelWidgetState createState() => _SliderLabelWidgetState();
}

class _SliderLabelWidgetState extends State<SliderLabelWidget> {
  int indexTop = 0;
  double valueBottom = 20;

  @override
  Widget build(BuildContext context) => SliderTheme(
        data: SliderThemeData(
          /// ticks in between
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSliderTopLabel(),
          ],
        ),
      );

  Widget buildSliderTopLabel() {
    final labels = ['0', '18', '30', '50', '+'];
    final double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(
              labels,
              (index, label) {
                final selectedColor = Colors.black;
                final unselectedColor = Colors.black.withOpacity(0.3);
                final isSelected = index <= indexTop;
                final color = isSelected ? selectedColor : unselectedColor;

                return buildLabel(label: label, color: color, width: 30);
              },
            ),
          ),
        ),
        Slider(
          value: indexTop.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          // label: labels[indexTop],
          onChanged: (value) => setState(() => this.indexTop = value.toInt()),
        ),
      ],
    );
  }

  Widget buildLabel({
    @required String label,
    @required double width,
    @required Color color,
  }) =>
      Container(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      );
}
