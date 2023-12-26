import 'package:flutter/material.dart';

class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
  });
}

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    img: 'assets/images/slide01.png',
    text: "Welcome, ",
    desc: "Welcome to the Contact Buddy Contact Manager",
    bg: Colors.white,
    button: Color(0xFF4756DF),
  ),
  OnboardModel(
    img: 'assets/images/slide02.png',
    text: "Expand Your Social",
    desc: "Easily connect your peoples via Contact Buddy",
    bg: Colors.white,
    button: Color(0xFF4756DF),
  ),
  OnboardModel(
    img: 'assets/images/slide03.png',
    text: "Close with Your Favorites",
    desc: "Add your contacts to the favorites list with Contact Buddy",
    bg: Colors.white,
    button: Color(0xFF4756DF),
  ),
];
