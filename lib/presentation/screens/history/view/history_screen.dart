part of history;

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalization.textHistory,
          style: Theme.of(context).textTheme.headline1,
        ),
        titleSpacing: AppInsets.insetsPadding.w,
        actions: [
          Consumer<TransactionsRepository>(builder: (context, model, child) {
            return SvgPicture.asset(
              AppAssets.iconSearch,
              width: 22.w,
              color: AppColors.colorGraphite_1,
            ).gestures(
                onTap: model.transactions != null
                    ? () {
                        searchModalSheet(context);
                      }
                    : null);
          }),
          SizedBox(width: AppInsets.insetsPadding.w),
        ],
      ),
      body: Consumer<TransactionsRepository>(builder: (context, model, child) {
        return model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : model.loadingFailed
                ? Center(
                    child: Text(
                      'Ошибка загрузки данных',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 26.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Consumer<TransactionsController>(
                                builder: (context, controller, _) {
                              return CardMain(
                                title: 'Расходы',
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.debit),
                                subtitle: AppFormatters
                                    .numberFormatterWithoutDecimal
                                    .format(controller.summDebit),
                              );
                            }),
                            SizedBox(width: 12.h),
                            Consumer<TransactionsController>(
                                builder: (context, controller, _) {
                              return CardMain(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.credit),
                                title: 'Поступления',
                                subtitle: AppFormatters
                                    .numberFormatterWithoutDecimal
                                    .format(controller.summCredit),
                                angle: 125,
                                color: Color(0xFFB3E9B8),
                              );
                            }),
                          ],
                        ).padding(
                          horizontal: AppInsets.insetsPadding.w,
                        ),
                        SizedBox(height: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: AppInsets.insetsPadding.w,
                                  right: AppInsets.insetsPadding.w,
                                  top: 32.h,
                                  bottom: 8.h),
                              child: ChipsList(),
                            ),
                            Expanded(
                                child: RefreshIndicator(
                              onRefresh: () => onRefresh(context, model),
                              child: GroupedList(),
                            )),
                          ],
                        )
                            .decorated(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                            )
                            .elevation(6,
                                shadowColor: Color(0x60000000),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                ))
                            .expanded(),
                      ],
                    ),
                  );
      }),
    );
  }

  Future<void> searchModalSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Material(
          child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: AppInsets.insetsPadding.h),
              TextField(
                onChanged: (value) {
                  context.read<TransactionsController>().query.keyword = value;
                  context.read<TransactionsController>().filter();
                },
                decoration: InputDecoration(
                  labelText: "Поиск",
                  fillColor: AppColors.colorGray,
                  filled: true,
                  isDense: true,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 16.sp),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 7.52),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  prefixIcon: SvgPicture.asset(
                    AppAssets.iconChevronLeft,
                    color: Theme.of(context).textTheme.caption.color,
                  ).padding(all: 12.h).gestures(
                        onTap: () => Navigator.pop(context),
                      ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(child: Consumer<TransactionsController>(
                  builder: (context, controller, _) {
                return controller.query.keyword == null ||
                        controller.query.keyword.isEmpty
                    ? SizedBox()
                    : controller.transactions.isEmpty ||
                            controller.transactions == null
                        ? Center(
                            child: Text(
                              'Ничего не найдено',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          )
                        : GroupedListView<Transaction, DateTime>(
                            groupBy: (Transaction transaction) => DateTime(
                              transaction.tranDate.year,
                              transaction.tranDate.month,
                              transaction.tranDate.day,
                            ),
                            separator: SizedBox(
                              height: 32.h,
                            ),
                            elements: controller.transactions,
                            order: GroupedListOrder.DESC,
                            sort: true,
                            shrinkWrap: true,
                            groupSeparatorBuilder: (date) => Padding(
                              padding: EdgeInsets.only(
                                top: date.isLast ? 0.0 : 32.h,
                                bottom: AppInsets.insetsPadding.h,
                              ),
                              child: Text(
                                date.toHuman,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: AppInsets.insetsPadding.h,
                                vertical: AppInsets.insetsPadding.h / 6),
                            itemBuilder: (BuildContext _, transaction) =>
                                TransactionCard(
                              transaction: transaction,
                              leading: SvgPicture.asset(
                                transaction.toAssetByMMC ??
                                    transaction.toAssetByComment,
                                color: Theme.of(context).canvasColor,
                              ),
                              trailingColor: !transaction.isDebit
                                  ? Theme.of(context).successColor
                                  : Theme.of(context).textTheme.headline1.color,
                              title: transaction.toNameByMMC ??
                                  transaction.toNameByComment,
                              subtitle: transaction.toTypeByMMC ??
                                  transaction.toTypeByComment,
                              trailing: transaction.isDebit
                                  ? '- ${transaction.amount.toMoney} ₽'
                                  : '+ ${transaction.amount.toMoney} ₽',
                            ),
                          )
                            .decorated(
                              color: AppColors.colorGray,
                              borderRadius: BorderRadius.circular(16),
                            )
                            .clipRRect(all: 16);
              }))
            ],
          ),
        ),
      )),
    ).whenComplete(() {
      context.read<TransactionsController>().query.keyword = null;
      context.read<TransactionsController>().filter();
    });
  }
}

class CardMain extends StatelessWidget {
  const CardMain({
    Key key,
    @required this.title,
    @required this.subtitle,
    this.angle = -45,
    this.color,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final double angle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.rotate(
                angle: angle * pi / 180,
                child: SvgPicture.asset(AppAssets.iconVector))
            .padding(all: 8.h)
            .decorated(
              color: color ?? Color(0xFFFF9D9D),
              borderRadius: BorderRadius.circular(6),
            )
            .constrained(width: 24.h, height: 24.h),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: 12.sp),
              ),
              SizedBox(height: 2.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: 18.sp,
                      ),
                ),
              )
            ],
          ),
        ),
      ],
    )
        .padding(all: 16.h)
        .decorated(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(12))
        .elevation(4,
            shadowColor: Color(0x20000000),
            borderRadius: BorderRadius.circular(12))
        .gestures(
          onTap: onTap,
        )
        .expanded();
  }
}
