import 'package:equatable/equatable.dart';

class TransactionCategory extends Equatable {
  final String name;
  bool isSelected;

  TransactionCategory({
    this.name,
    this.isSelected = true,
  });

  @override
  List<Object> get props => [name, isSelected];
}
