part of debit;

class Chart extends StatelessWidget {
  Chart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final creditSumma = context.watch<DebitsController>().summDebit;
    final debitSeries = context.watch<DebitsController>().debitSeries;
    final List<charts.Series<DebitSeries, String>> series = [
      charts.Series(
          id: "developers",
          data: debitSeries,
          domainFn: (DebitSeries series, _) => series.category,
          measureFn: (DebitSeries series, _) => series.amount,
          colorFn: (DebitSeries series, _) => series.barColor)
    ];
    return Column(
      children: [
        SizedBox(
          height: 150.h,
          child: Stack(
            children: [
              charts.PieChart(
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
              ),
              Center(
                  child: Text(
                AppFormatters.compactFormatter.format(creditSumma),
                style: Theme.of(context).textTheme.headline2,
              )),
            ],
          ),
        ),
        // Wrap(
        //   children: [
        //     for (final debit in debitSeries)
        //       Text(
        //         debit.category,
        //         style: Theme.of(context).textTheme.bodyText2,
        //       ).padding(vertical: 10.h,horizontal: 16.w).decorated(color: debit.barColor)
        //   ],
        // )
      ],
    );
  }
}
