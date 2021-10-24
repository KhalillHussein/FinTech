part of credit;

class CreditScreen extends StatelessWidget {
  const CreditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalization.textCredits,
          style: Theme.of(context).textTheme.headline1,
        ),
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        leading: SvgPicture.asset(
          AppAssets.iconChevronLeft,
          color: Theme.of(context).textTheme.headline1.color,
        ).padding(all: 14.h).constrained(width: 24.h, height: 24.h).gestures(
              onTap: () => Navigator.pop(context),
            ),
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
                        SizedBox(
                          height: 150.h,
                          child: Stack(
                            children: [
                              Chart(),
                              Center(
                                  child: Text(
                                '13 000 ₽',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
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
}
