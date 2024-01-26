import 'package:flutter/material.dart';

String numberToWord(int num) {
  if (num <= 0 || num > 99) {
    return 'номер $num';
  }

  final units = [
    '',
    'первый',
    'второй',
    'третий',
    'четвертый',
    'пятый',
    'шестой',
    'седьмой',
    'восьмой',
    'девятый'
  ];

  final tens = [
    '',
    'десятый',
    'двадцатый',
    'тридцатый',
    'сороковой',
    'пятидесятый',
    'шестидесятый',
    'семидесятый',
    'восьмидесятый',
    'девяностый'
  ];

  if (num < 10) {
    return units[num];
  } else if (num < 20) {
    return 'десятый ${units[num % 10]}';
  } else {
    return '${tens[num ~/ 10]} ${units[num % 10]}';
  }
}
