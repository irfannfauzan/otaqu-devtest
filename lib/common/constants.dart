import 'package:flutter/material.dart';

String names = "Hi, Irfan Dev";
String greetings = "Welcome to Otaqu";
String loct = "Jakarta, Indonesia";

TextStyle namesStyle = TextStyle(
    color: putihOri,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Nunito');
TextStyle greetingsStyle = TextStyle(
    color: putihOri,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Nunito');
TextStyle loctStyle = TextStyle(
    color: putihOri,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    fontFamily: 'Nunito');
Color hitamMuda = Color(0xFF4C4C4C);
Color unguSoft = Color(0xFF58489D);
Color pink = Color(0xFFE91E5A);
Color putih = Color(0xffF5F6F8);
Color putihOri = Color(0xFFFFFFFF);
Color abu = Color(0XFFC8C8C8);
Color kuning = Color(0xFFFFC90E);
Color biru = Color(0xFF41C0F0);
Color ornamenRed = Color(0xFFE91E5A);
Color hijau = Color(0XFF34C900);
TextStyle selectedButtonOnBoarding = TextStyle(
    color: putih,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: 'Nunito');

TextStyle selectedButtonOnBoarding2 = TextStyle(
    color: putih,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    fontFamily: 'Nunito');
TextStyle unselectedButtonOnBoarding = TextStyle(
    color: pink,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: 'Nunito');

SnackBar requiredText = SnackBar(
  content: Text(
    'Harap Masukkan Kata Kunci!',
    style: TextStyle(fontSize: 12),
  ),
);
