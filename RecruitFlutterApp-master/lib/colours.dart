
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Colours {
  static const Color gray_F6F6F6= Color(0xFFF6F6F6);
  static const Color black_4B514A= Color(0xFF4B514A);
  static const Color gray_C8C7CC= Color(0xFFC8C7CC);
  static const Color bg_color= Color(0xFFfafafa);
  static const Color black_400000= Color(0x40000000);
  static const Color black_212920= Color(0xFF212920);
static const Color app_main = Color(0xFF3396FB);
static const Color blue_main = Color(0xFF37ABE3);
static const Color gray_8A8F8A= Color(0xFF8A8F8A);
static const Color gray_33A4AFA3= Color(0x33A4AFA3);
  static const Color black_1e211c= Color(0xFF1E211C);
static const Color black_120000= Color(0x12000000);
  static const Color gray_AAAAAA= Color(0xFFAAAAAA);
  static const Color red_ffd5351c= Color(0xFFD5351C);
  static const Color green_d8e0d6= Color(0xf5FD8E0D6);
static Color slRandomColor({int r = 255, int g = 255, int b = 255, a = 255}) {
  if (r == 0 || g == 0 || b == 0) return Colors.black;
  if (a == 0) return Colors.white;
  return Color.fromARGB(
    a,
    r != 255 ? r : Random.secure().nextInt(r),
    g != 255 ? g : Random.secure().nextInt(g),
    b != 255 ? b : Random.secure().nextInt(b),
  );
}
}