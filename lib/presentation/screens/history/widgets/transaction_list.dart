part of history;

class GroupedList extends StatelessWidget {
  const GroupedList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsController>(builder: (context, controller, _) {
      return controller.transactions.isEmpty || controller.transactions == null
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
                  vertical: AppInsets.insetsPadding.h),
              itemBuilder: (BuildContext _, transaction) => TransactionCard(
                transaction: transaction,
                leading: SvgPicture.asset(
                  transaction.toAssetByMMC ?? transaction.toAssetByComment,
                  color: Theme.of(context).canvasColor,
                ),
                trailingColor: !transaction.isDebit
                    ? Theme.of(context).successColor
                    : Theme.of(context).textTheme.headline1.color,
                title: transaction.toNameByMMC ?? transaction.toNameByComment,
                subtitle:
                    transaction.toTypeByMMC ?? transaction.toTypeByComment,
                trailing: transaction.isDebit
                    ? '- ${transaction.amount.toMoney} ₽'
                    : '+ ${transaction.amount.toMoney} ₽',
              ),
            );
    });
  }
}

extension MoneyFormatterX on double {
  String get toMoney => AppFormatters.numberFormatter.format(this);
}

extension DateTimeX on DateTime {
  bool get isLast {
    final last = DateTime(2021, 10, 21);
    if (last.day == day && last.month == month && last.year == year) {
      return true;
    }
    return false;
  }

  String get toHuman {
    final now = DateTime.now();
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    if (now.day == day && now.month == month && now.year == year) {
      return AppLocalization.textToday;
    }
    if (yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year) {
      return AppLocalization.textYesterday;
    }

    return DateFormat('d MMMM, EE', 'Ru').format(this);
  }
}
