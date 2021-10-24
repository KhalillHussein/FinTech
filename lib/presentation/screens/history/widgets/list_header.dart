part of history;

class ChipsList extends StatelessWidget {
  const ChipsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          colors: [
            Colors.purple,
            Colors.transparent,
            Colors.transparent,
            Colors.purple
          ],
          stops: [
            0.0,
            0.02,
            0.93,
            1.0
          ], // 10% purple, 80% transparent, 10% purple
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.iconFilter,
              width: 17.w,
              color: Theme.of(context).textTheme.headline1.color,
            )
                .padding(horizontal: 12.h, vertical: 8.h)
                .decorated(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  borderRadius: BorderRadius.circular(16),
                )
                .padding(right: 8.w)
                .gestures(onTap: () {
              context.read<TransactionsController>().query.reset();
              context.read<TransactionsController>().filter();
            }),
            for (final filter in filters)
              ChipSelect(
                type: filter.filterType,
                label: filter.name,
              ),
          ],
        ),
      ),
    );
  }
}

class ChipSelect extends StatelessWidget {
  ChipSelect({
    Key key,
    @required this.label,
    @required this.type,
  }) : super(key: key);

  final String label;
  final FilterType type;
  final DateTime dateTime = DateTime.now();

  final _controllerFrom = TextEditingController();
  final _controllerTo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<TransactionCategory> categories =
        context.select<TransactionsController, List<TransactionCategory>>(
            (value) => value.transactionCategories);
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(width: 6.w),
        SvgPicture.asset(
          AppAssets.iconChevronDown,
          width: 14.w,
          color: Theme.of(context).textTheme.headline1.color,
        ),
      ],
    )
        .padding(horizontal: 16.h, vertical: 8.h)
        .decorated(
          color: Theme.of(context).colorScheme.secondaryVariant,
          borderRadius: BorderRadius.circular(16),
        )
        .padding(right: 8.w)
        .gestures(
            onTap: () => type == FilterType.period
                ? showMaterialModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    builder: (context) => Material(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Spacer(flex: 5),
                                    Text(
                                      'Расходы',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    Spacer(flex: 4),
                                    SvgPicture.asset(AppAssets.iconClose)
                                        .gestures(
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppInsets.insetsPadding.h),
                                Text(
                                  'За неделю',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 16.sp),
                                ).gestures(onTap: () {
                                  context
                                      .read<TransactionsController>()
                                      .query
                                      .period = [
                                    dateTime.subtract(Duration(days: 7)),
                                    dateTime
                                  ];

                                  context
                                      .read<TransactionsController>()
                                      .filter();
                                  print(context
                                      .read<TransactionsController>()
                                      .query);
                                }),
                                SizedBox(height: AppInsets.insetsPadding.h),
                                Text(
                                  'За месяц',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 16.sp),
                                ).gestures(onTap: () {
                                  context
                                      .read<TransactionsController>()
                                      .query
                                      .period = [
                                    dateTime.subtract(Duration(days: 30)),
                                    dateTime
                                  ];

                                  context
                                      .read<TransactionsController>()
                                      .filter();
                                }),
                                SizedBox(height: AppInsets.insetsPadding.h),
                                Text(
                                  'За год',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 16.sp),
                                ).gestures(onTap: () {
                                  context
                                      .read<TransactionsController>()
                                      .query
                                      .period = [
                                    dateTime.subtract(Duration(days: 365)),
                                    dateTime
                                  ];

                                  context
                                      .read<TransactionsController>()
                                      .filter();
                                }),
                                SizedBox(height: AppInsets.insetsPadding.h),
                                Text(
                                  'За период...',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 16.sp),
                                ).gestures(
                                    onTap: () => showMaterialModalBottomSheet(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(32),
                                              topRight: Radius.circular(32),
                                            ),
                                          ),
                                          builder: (context) => Material(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(32),
                                                topRight: Radius.circular(32),
                                              ),
                                              child: SafeArea(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.h),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      Text(
                                                        'Период',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1,
                                                      ).center(),
                                                      SizedBox(
                                                          height: AppInsets
                                                              .insetsPadding.h),
                                                      DateRangePicker(),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Закрыть',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          )
                                                              .padding(
                                                                  vertical:
                                                                      11.h)
                                                              .decorated(
                                                                color: AppColors
                                                                    .colorGray,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              )
                                                              .gestures(
                                                                  onTap: () =>
                                                                      Navigator.pop(
                                                                          context))
                                                              .expanded(),
                                                          SizedBox(width: 12.w),
                                                          Text(
                                                            'Показать',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                              .padding(
                                                                  vertical:
                                                                      11.h)
                                                              .decorated(
                                                                color: AppColors
                                                                    .colorRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  16,
                                                                ),
                                                              )
                                                              .gestures(
                                                                  onTap: () {
                                                            Navigator.pop(
                                                                context);

                                                            context
                                                                .read<
                                                                    TransactionsController>()
                                                                .filter();
                                                          }).expanded(),
                                                        ],
                                                      ),
                                                      SizedBox(height: 32.h),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        )),
                                SizedBox(height: 32.h),
                              ],
                            ),
                          ),
                        )),
                  )
                : type == FilterType.operationType
                    ? operationTypeModalSheet(context, categories)
                    : summaModalSheet(context));
  }

  Future<void> operationTypeModalSheet(
      BuildContext context, List<TransactionCategory> categories) {
    return showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (context) => Material(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Spacer(flex: 5),
                      Text(
                        'Тип операции',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Spacer(flex: 4),
                      SvgPicture.asset(AppAssets.iconClose).gestures(
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: AppInsets.insetsPadding.h),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final category in categories)
                          Row(
                            children: [
                              StatefulBuilder(builder: (context, setState) {
                                return Checkbox(
                                  value: category.isSelected,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      category.isSelected = value;
                                    });
                                    context
                                        .read<TransactionsController>()
                                        .query
                                        .categories = [
                                      for (final category in categories)
                                        if (category.isSelected) category.name
                                    ];
                                    context
                                        .read<TransactionsController>()
                                        .filter();
                                  },
                                  activeColor:
                                      Theme.of(context).colorScheme.secondary,
                                );
                              }),
                              Text(
                                category.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(fontSize: 16.sp),
                              )
                            ],
                          ),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Future<void> summaModalSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (context) => Padding(
        // duration: Duration(milliseconds: 200),
        // curve: Curves.easeIn,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        Spacer(flex: 5),
                        Text(
                          'Сумма',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Spacer(flex: 4),
                        SvgPicture.asset(AppAssets.iconClose).gestures(
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    SizedBox(height: AppInsets.insetsPadding.h),
                    Row(
                      children: [
                        Expanded(
                          child: Consumer<TransactionsController>(
                              builder: (context, controller, _) {
                            return TextField(
                              onChanged: controller.changeFromField,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'От',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 32.w),
                        Expanded(
                          child: Consumer<TransactionsController>(
                              builder: (context, controller, _) {
                            return TextField(
                              onChanged: controller.changeToField,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'До',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Consumer<TransactionsController>(
                        builder: (context, controller, _) {
                      return Text(
                        'Продолжить',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      )
                          .padding(vertical: 11.h)
                          .decorated(
                            color: AppColors.colorRed,
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          )
                          .gestures(
                              onTap: controller.isFormValid
                                  ? () {
                                      context
                                          .read<TransactionsController>()
                                          .query
                                          .amounts = [
                                        double.parse(controller.textFrom.value),
                                        double.parse(controller.textTo.value),
                                      ];
                                      context
                                          .read<TransactionsController>()
                                          .filter();
                                      // Navigator.pop(context);
                                      print(context
                                          .read<TransactionsController>()
                                          .query);
                                    }
                                  : null);
                    }),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateRanger(
      initialDate: DateTime.now(),
      borderColors: AppColors.colorBlack,
      activeItemBackground: AppColors.colorBlack,
      rangeBackground: AppColors.colorBlack,
      initialRange: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
      onRangeChanged: (range) {
        context.read<TransactionsController>().query.period = [
          range.start,
          range.end
        ];
      },
    );
  }
}
