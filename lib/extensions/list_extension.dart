extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    final result = <T>[];
    forEach((element) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element))) {
        result.add(element);
      }
    });

    return result;
  }

  List<T> findDistinctElements(
    List<T> otherList,
    bool Function(T e, T v) getCompareValue,
  ) {
    final List<T> result = <T>[];
    for (final T e in this) {
      if (!otherList.any((T v) => getCompareValue(e, v))) {
        result.add(e);
      }
    }
    return result;
  }

  String convertString() {
    return join(',');
  }
}
