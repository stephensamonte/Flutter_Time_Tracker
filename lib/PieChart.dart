/// Adapted from: https://google.github.io/charts/flutter/example/pie_charts/auto_label

/// Donut chart with labels example. This is a simple pie chart with a hole in
/// the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutAutoLabelChart.withSampleData() {
    return new DonutAutoLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        //
        // [ArcLabelDecorator] will automatically position the label inside the
        // arc if the label will fit. If the label will not fit, it will draw
        // outside of the arc with a leader line. Labels can always display
        // inside or outside using [LabelPosition].
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<DayItem, dynamic>> _createSampleData() {
    final data = [
      new DayItem("0", 100),
      new DayItem("1", 75),
      new DayItem("2", 25),
      new DayItem("testing", 5),
    ];

    return [
      new charts.Series<DayItem, dynamic>(
        id: 'Sales',
        domainFn: (DayItem sales, _) => sales.category,
        measureFn: (DayItem sales, _) => sales.duration,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (DayItem row, _) => '${row.category}: ${row.duration}',
      )
    ];
  }
}

/// Sample linear data type.
class DayItem {
  final String category;
  final int duration;

  DayItem(this.category, this.duration);
}