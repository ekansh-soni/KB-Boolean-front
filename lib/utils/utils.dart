import 'package:flutter/material.dart';

Widget spaceHeight(double height) => SizedBox(height: height,);
Widget spaceWidth(double width) => SizedBox(width: width,);

Color getPriceColor(dynamic diff) {
  final d = double.tryParse(diff.toString()) ?? 0;

  if (d > 0) return Colors.green;
  if (d < 0) return Colors.red;
  return Colors.grey;
}

Color getDiffColor(dynamic diff) {
  final d = double.tryParse(diff.toString()) ?? 0;

  if (d > 0) return Colors.green;
  if (d < 0) return Colors.red;
  return Colors.grey;
}
Map<String, double> lastLtpMap = {};

Color getTickColor(String symbol, String? ltp) {
  final current = double.tryParse(ltp ?? '0') ?? 0;
  final previous = lastLtpMap[symbol];

  // first time → no color
  if (previous == null) {
    lastLtpMap[symbol] = current;
    return Colors.transparent;
  }

  // update map
  lastLtpMap[symbol] = current;

  if (current > previous) return Colors.green;
  if (current < previous) return Colors.red;

  return Colors.transparent;
}