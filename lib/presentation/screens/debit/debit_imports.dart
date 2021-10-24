library debit;

import 'dart:math';

import 'package:date_ranger/date_ranger.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fintech_app/core/constants/assets.dart';
import 'package:fintech_app/core/constants/colors.dart';
import 'package:fintech_app/core/constants/formatters.dart';
import 'package:fintech_app/core/constants/insets.dart';
import 'package:fintech_app/core/constants/localization.dart';
import 'package:fintech_app/data/models/category.dart';
import 'package:fintech_app/data/models/filter.dart';
import 'package:fintech_app/data/models/transaction.dart';
import 'package:fintech_app/data/repositories/transactions.dart';
import 'package:fintech_app/logic/debits_controller.dart';
import 'package:fintech_app/presentation/widgets/basic_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/app_theme.dart';

part 'view/debit_screen.dart';
part 'widgets/list_header.dart';
part 'widgets/transaction_card.dart';
part 'widgets/transaction_list.dart';
part 'widgets/chart.dart';
