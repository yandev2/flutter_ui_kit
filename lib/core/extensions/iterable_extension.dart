import 'package:flutter/material.dart';

/// Ekstensi untuk mempermudah manipulasi List / Iterable saat merender UI.
extension IterableExtension<T> on Iterable<T> {
  /// Mendapatkan elemen pertama yang memenuhi syarat, atau null jika tidak ada.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Melakukan mapping dengan menyertakan index (sangat berguna untuk [Row] atau [Column]).
  Iterable<E> mapIndexed<E>(E Function(int index, T item) f) sync* {
    var index = 0;
    for (final item in this) {
      yield f(index, item);
      index++;
    }
  }

  /// Menambahkan separator (seperti [SizedBox] atau [Divider]) di antara setiap elemen.
  List<Widget> separateWith(Widget separator) {
    if (isEmpty) return [];
    if (length == 1) return [first as Widget];
    
    final result = <Widget>[];
    final iterator = this.iterator;
    
    if (iterator.moveNext()) {
      result.add(iterator.current as Widget);
      while (iterator.moveNext()) {
        result.add(separator);
        result.add(iterator.current as Widget);
      }
    }
    return result;
  }
}
