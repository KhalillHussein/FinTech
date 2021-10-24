part of history;

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key key,
    @required this.leading,
    @required this.title,
    @required this.subtitle,
    @required this.trailing,
    @required this.trailingColor,
    this.transaction,
  }) : super(key: key);

  final Widget leading;
  final String title;
  final String subtitle;
  final String trailing;
  final Color trailingColor;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading
            .padding(all: 10.h)
            .decorated(
              borderRadius: BorderRadius.circular(14.w),
              color: Theme.of(context).colorScheme.primary,
            )
            .constrained(width: 38.h, height: 38.h)
            .padding(right: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
        Text(
          trailing,
          style: Theme.of(context).textTheme.headline2.copyWith(
                color: trailingColor,
              ),
        )
      ],
    ).ripple().gestures(
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
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SvgPicture.asset(AppAssets.iconClose).gestures(
                            onTap: () => Navigator.pop(context),
                          ),
                          leading
                              .padding(all: 12.h)
                              .decorated(
                                borderRadius: BorderRadius.circular(24.w),
                                color: Theme.of(context).colorScheme.primary,
                              )
                              .constrained(width: 64.h, height: 64.h)
                              .center(),
                          SizedBox(height: AppInsets.insetsPadding.h),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.bodyText1,
                          ).center(),
                          SizedBox(height: 4.h),
                          Text(
                            subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 12.sp),
                          ).center(),
                          SizedBox(height: 16.h),
                          Text(
                            trailing,
                            style:
                                Theme.of(context).textTheme.headline2.copyWith(
                                      color: trailingColor,
                                      fontSize: 36.sp,
                                    ),
                          ).center(),
                          SizedBox(height: 32.h),
                          Text(
                            'Счет списания',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 13.sp),
                          ).alignment(Alignment.centerLeft),
                          SizedBox(height: 6.h),
                          Text(
                            'Основной счет ••4733',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontSize: 16.sp),
                          ).alignment(Alignment.centerLeft),
                          SizedBox(height: 16.h),
                          Text(
                            'Дата операции',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 13.sp),
                          ).alignment(Alignment.centerLeft),
                          SizedBox(height: 6.h),
                          Text(
                            DateFormat('dd MMMM yyyy', 'Ru')
                                .format(transaction.tranDate),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontSize: 16.sp),
                          ).alignment(Alignment.centerLeft),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  )),
            ));
  }
}
