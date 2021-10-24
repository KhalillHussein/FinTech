import 'package:equatable/equatable.dart';
import 'package:fintech_app/core/constants/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// class Transaction extends Equatable {
//   final int id;
//   final String name;
//   final String category;
//   final DateTime date;
//   final double amount;
//   final bool isRefill;

//   const Transaction({
//     this.id,
//     this.name,
//     this.category,
//     this.date,
//     this.amount,
//     this.isRefill,
//   });

//   Map<dynamic, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'category': category,
//       'date': date.toString(),
//       'amount': amount,
//       'isRefill': isRefill,
//     };
//   }

//   factory Transaction.fromMap(Map<dynamic, dynamic> map) {
//     return Transaction(
//       id: map['id'],
//       name: map['name'],
//       category: map['category'],
//       date: DateTime.parse(map['date'] as String),
//       amount: map['amount'].toDouble(),
//       isRefill: map['isRefill'],
//     );
//   }

//   @override
//   List<Object> get props => [
//         id,
//         name,
//         category,
//         date,
//         amount,
//         isRefill,
//       ];
// }

// List<Transaction> transactions = [
//   Transaction(
//     id: 1,
//     name: 'Магнит',
//     category: 'Супермаркеты',
//     date: DateTime.now(),
//     amount: 152.5,
//     isRefill: false,
//   ),
//   Transaction(
//     id: 2,
//     name: 'Горизонт Cinema&Emotion',
//     category: 'Развлечения',
//     date: DateTime.now(),
//     amount: 900,
//     isRefill: false,
//   ),
//   Transaction(
//     id: 3,
//     name: 'H&M',
//     category: 'Одежда и обувь',
//     date: DateTime.now(),
//     amount: 1300,
//     isRefill: false,
//   ),
//   Transaction(
//     id: 4,
//     name: 'Александр Б.',
//     category: 'Переводы',
//     date: DateTime.now().subtract(Duration(days: 1)),
//     amount: 2600,
//     isRefill: false,
//   ),
//   Transaction(
//     id: 5,
//     name: 'Сергей А.',
//     category: 'Переводы',
//     date: DateTime.now().subtract(Duration(days: 1)),
//     amount: 1700,
//     isRefill: true,
//   ),
//   Transaction(
//     id: 6,
//     name: 'Магнит',
//     category: 'Развлечения',
//     date: DateTime.now().subtract(Duration(days: 1)),
//     amount: 59.99,
//     isRefill: false,
//   ),
//   Transaction(
//     id: 7,
//     name: 'ФОРАБАНК',
//     category: 'Зачисление',
//     date: DateTime.now().subtract(Duration(days: 1)),
//     amount: 30000,
//     isRefill: true,
//   ),
//   Transaction(
//     id: 8,
//     name: 'Александр Б.',
//     category: 'Переводы',
//     date: DateTime.now().subtract(Duration(days: 2)),
//     amount: 350,
//     isRefill: false,
//   ),
// ];

class Transaction extends Equatable {
  final String type;
  final DateTime date;
  final DateTime tranDate;
  final String operationType;
  final double amount;
  final String comment;
  final String accountNumber;
  final int currencyCodeNumeric;
  final String merchantName;
  final FastPaymentData fastPaymentData;
  final int mcc;

  const Transaction({
    @required this.type,
    @required this.date,
    @required this.tranDate,
    @required this.operationType,
    @required this.amount,
    @required this.comment,
    @required this.accountNumber,
    @required this.currencyCodeNumeric,
    @required this.merchantName,
    @required this.fastPaymentData,
    @required this.mcc,
  });

  @override
  List<Object> get props {
    return [
      type,
      date,
      tranDate,
      operationType,
      amount,
      comment,
      accountNumber,
      currencyCodeNumeric,
      merchantName,
      fastPaymentData,
      mcc,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'date': date,
      'tranDate': tranDate,
      'operationType': operationType,
      'amount': amount,
      'comment': comment,
      'accountNumber': accountNumber,
      'currencyCodeNumeric': currencyCodeNumeric,
      'merchantName': merchantName,
      'fastPaymentData': fastPaymentData.toMap(),
      'MCC': mcc,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      type: map['type'],
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      tranDate: DateTime.fromMillisecondsSinceEpoch(map['tranDate']),
      operationType: map['operationType'],
      amount: map['amount'],
      comment: map['comment'],
      accountNumber: map['accountNumber'],
      currencyCodeNumeric: map['currencyCodeNumeric'],
      merchantName: map['merchantName'],
      fastPaymentData: map['fastPaymentData'] != null
          ? FastPaymentData.fromMap(map['fastPaymentData'])
          : null,
      mcc: map['MCC'] ?? 0,
    );
  }

  String get toAssetByMMC {
    switch (mcc) {
      case 5814: //фастфуд
        return AppAssets.iconBurger;
      case 5999: //разл. товары
        return AppAssets.iconShoppingBag;
      case 7372: //бизнес услуги
        return AppAssets.iconBriefcase;
      case 6012: //поставщик услуг
        return AppAssets.iconBriefcase;
      case 6011: //снятие наличных
        return AppAssets.iconCollection;
      case 0:
        return null;
      default:
        return AppAssets.iconTag;
    }
  }

  String get toTypeByMMC {
    switch (mcc) {
      case 5814: //фастфуд
        return 'Фастфуд';
      case 5999: //разл. товары
        return 'Различные товары';
      case 7372: //бизнес услуги
        return 'Бизнес услуги';
      case 6012: //поставщик услуг
        return 'Поставщик услуг';
      case 6011: //снятие наличных
        return 'Снятие наличных автоматически';
      case 0:
        return null;
      default:
        return 'Неопознано';
    }
  }

  Color get toColorByMMC {
    switch (mcc) {
      case 5814: //фастфуд
        return Color(0xFFF3872F);
      case 5999: //разл. товары
        return Color(0xFF628AF6);
      case 7372: //бизнес услуги
        return Color(0xFF628AF6);
      case 6012: //поставщик услуг
        return Color(0xFFE4B5FE);
      case 6011: //снятие наличных
        return Color(0xFF9F25CB);
      case 0:
        return Color(0xFFFDE445);
      default:
        return Color(0xFFFDE445);
    }
  }

  bool get isDebit => operationType == "DEBIT";

  String get toAssetByComment {
    if (comment.contains(RegExp('Перевод', caseSensitive: false))) {
      return AppAssets.iconSortHorizontal;
    }
    if (comment.contains(RegExp('Овер', caseSensitive: false))) {
      return AppAssets.iconCrosshair;
    }
    if (comment.contains(RegExp('Пополн', caseSensitive: false))) {
      return AppAssets.iconSaveAlt;
    }
    if (comment.contains(
        RegExp('для оплаты услуги Мобильная связь', caseSensitive: false))) {
      return AppAssets.iconDeviceMobile;
    }
    if (comment.contains(RegExp('для оплаты услуги', caseSensitive: false))) {
      return AppAssets.iconHome;
    }
    if (comment.contains(RegExp('Перечисление', caseSensitive: false))) {
      return AppAssets.iconSaveAlt;
    }
    if (comment.contains(RegExp('Возврат', caseSensitive: false))) {
      return AppAssets.iconReply;
    }
    if (comment.contains(RegExp('Комисс', caseSensitive: false))) {
      return AppAssets.iconPercent;
    }
    if (comment.contains(RegExp('Кэш', caseSensitive: false))) {
      return AppAssets.iconDatabase;
    }
    return AppAssets.iconTag;
  }

  String get toTypeByComment {
    if (comment.contains(RegExp('Перевод', caseSensitive: false))) {
      return 'Перевод';
    }
    if (comment.contains(RegExp('Овер', caseSensitive: false))) {
      return 'Овердрафт';
    }
    if (comment.contains(RegExp('Пополн', caseSensitive: false))) {
      return 'Пополнение';
    }
    if (comment.contains(
        RegExp('для оплаты услуги Мобильная связь', caseSensitive: false))) {
      return 'Мобильная связь';
    }
    if (comment.contains(RegExp('для оплаты услуги', caseSensitive: false))) {
      return 'Коммунальные платежи';
    }
    if (comment.contains(RegExp('Перечисление', caseSensitive: false))) {
      return 'Зачисление';
    }
    if (comment.contains(RegExp('Возврат', caseSensitive: false))) {
      return 'Возврат';
    }
    if (comment.contains(RegExp('Комисс', caseSensitive: false))) {
      return 'Комиссия';
    }
    if (comment.contains(RegExp('Кэш', caseSensitive: false))) {
      return 'Кешбэк';
    }
    return 'Неопознано';
  }

  String get toNameByComment {
    if (comment.contains(RegExp('Перевод', caseSensitive: false))) {
      return 'Иванов И.И.';
    }
    if (comment.contains(RegExp('Овер', caseSensitive: false))) {
      return 'Петрова П.П.';
    }
    if (comment.contains(RegExp('Спис', caseSensitive: false))) {
      return 'MOSCOW-ZUBOVS, 110101, Moscow';
    }
    if (comment.contains(RegExp('Пополн', caseSensitive: false))) {
      return 'VISA MONEY TR';
    }
    if (comment.contains(
        RegExp('для оплаты услуги Мобильная связь', caseSensitive: false))) {
      return '+7 (915) 999-99-99';
    }
    if (comment.contains(RegExp('для оплаты услуги', caseSensitive: false))) {
      return 'Мосэнергосбыт';
    }
    if (comment.contains(RegExp('Перечисление', caseSensitive: false))) {
      return 'Иванов И. И.';
    }
    if (comment.contains(RegExp('Возврат', caseSensitive: false))) {
      return 'Возврат';
    }
    if (comment.contains(RegExp('Комисс', caseSensitive: false))) {
      return 'Иванов И. И.';
    }
    if (comment.contains(RegExp('Кэш', caseSensitive: false))) {
      return 'CASHBACK';
    }
    return 'Unknown';
  }

  String get toNameByMMC {
    switch (mcc) {
      case 5814: //фастфуд
        return 'MCDONALDS 290, 21195041, KHIMKI.';
      case 5999: //разл. товары
        return 'AFIMOLKEITERI, J338434, MOSKVA.';
      case 7372: //бизнес услуги
        return 'TILDA.CC, 24110225, Moskva.';
      case 6012: //поставщик услуг
        return 'CARD2CARD ALF, 809216, MOSCOW.';
      case 6011: //снятие наличных
        return 'MOSCOW-ZUBOVS, 110101, Moscow.';
      case 0:
        return null;
      default:
        return 'Unknown';
    }
  }
}

class FastPaymentData {
  final String foreignName;
  final String foreignPhoneNumber;
  final String foreignBankBIC;
  final String foreignBankID;
  final String foreignBankName;
  final String documentComment;

  const FastPaymentData({
    @required this.foreignName,
    @required this.foreignPhoneNumber,
    @required this.foreignBankBIC,
    @required this.foreignBankID,
    @required this.foreignBankName,
    @required this.documentComment,
  });

  Map<String, dynamic> toMap() {
    return {
      'foreignName': foreignName,
      'foreignPhoneNumber': foreignPhoneNumber,
      'foreignBankBIC': foreignBankBIC,
      'foreignBankID': foreignBankID,
      'foreignBankName': foreignBankName,
      'documentComment': documentComment,
    };
  }

  factory FastPaymentData.fromMap(Map<String, dynamic> map) {
    return FastPaymentData(
      foreignName: map['foreignName'],
      foreignPhoneNumber: map['foreignPhoneNumber'],
      foreignBankBIC: map['foreignBankBIC'],
      foreignBankID: map['foreignBankID'],
      foreignBankName: map['foreignBankName'],
      documentComment: map['documentComment'],
    );
  }
}

//  {
//             "type": "INSIDE",
//             "date": 1634763600000,
//             "tranDate": 1634820242000,
//             "operationType": "DEBIT",
//             "amount": 25.0000,
//             "comment": "Комиссия за межбанковский перевод. Перевод от Иванов Иван Иванович получателю Петров Петр Петрович на сумму 5,000.00 в валюте Российский рубль. ОПКЦ: B12941243397882E99999999999999D9. ДД: 21/10/2021. ДК: 21/10/2021.",
//             "accountNumber": "70601810111111111111",
//             "currencyCodeNumeric": 810,
//             "merchantName": "",
//             "fastPaymentData": {
//                 "foreignName": "Петров Петр Петрович",
//                 "foreignPhoneNumber": "79031111111                                       ",
//                 "foreignBankBIC": "044525341",
//                 "foreignBankID": "2000",
//                 "foreignBankName": "АКБ \"ФОРА-БАНК\" (АО)",
//                 "documentComment": ""
//             },
//             "MCC": 0
//         },