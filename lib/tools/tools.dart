import 'dart:math';
import 'package:flutter/material.dart';

Random random = new Random();

int randInt(int min, int max) {
  // [min; max[
  return min + random.nextInt(max - min);
}

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double sh(BuildContext context, {double dividedBy = 1}) {
  return getScreenSize(context).height / dividedBy;
}

double sw(BuildContext context, {double dividedBy = 1}) {
  return getScreenSize(context).width / dividedBy;
}
