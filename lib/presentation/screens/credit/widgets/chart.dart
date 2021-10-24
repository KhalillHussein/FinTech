part of credit;

class Chart extends StatelessWidget {
  Chart({Key key}) : super(key: key);

  final List<DebitSeries> data = [
    DebitSeries(
      category: "2017",
      amount: 40000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFF3872F)),
    ),
    DebitSeries(
      category: "2018",
      amount: 5000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFE4B5FE)),
    ),
    DebitSeries(
      category: "2019",
      amount: 40000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFF9F25CB)),
    ),
    DebitSeries(
      category: "2020",
      amount: 35000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFFDE445)),
    ),
    DebitSeries(
      category: "2021",
      amount: 45000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFFC6C4F)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<DebitSeries, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (DebitSeries series, _) => series.category,
          measureFn: (DebitSeries series, _) => series.amount,
          colorFn: (DebitSeries series, _) => series.barColor)
    ];
    return charts.PieChart(
      series,
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 32,
        strokeWidthPx: 0,
      ),
      animate: true,
    );
  }
}

class DebitSeries {
  final String category;
  final double amount;
  final charts.Color barColor;

  DebitSeries(
      {@required this.category,
      @required this.amount,
      @required this.barColor});
}
