enum FilterType {
  operationType,
  period,
  summa,
}

class Filter {
  final String name;
  bool isSelected = false;
  final FilterType filterType;

  Filter({
    this.name,
    this.isSelected,
    this.filterType,
  });
}

List<Filter> filters = [
  Filter(
    name: 'Категория',
    filterType: FilterType.operationType,
  ),
  Filter(
    name: 'Период',
    filterType: FilterType.period,
  ),
  Filter(
    name: 'Сумма',
    filterType: FilterType.summa,
  ),
];
