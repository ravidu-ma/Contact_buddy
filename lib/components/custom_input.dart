import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {Key? key,
        required this.hintTxt,
        required this.lableTxt,
        required this.mode,
        required this.controller,
        this.type = false})
      : super(key: key);

  final String hintTxt;
  final String lableTxt;
  final bool mode;
  final TextEditingController controller;
  bool? type;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(40, 74, 74, 74),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          keyboardType:
          widget.type == true ? TextInputType.phone : TextInputType.text,
          validator: (value) => isValidName(value.toString()),
          controller: widget.controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: widget.lableTxt,
            hintText: widget.hintTxt,
            hintStyle: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

//Validators
//Name Validation
String isValidName(String value) {
  if (value.length < 3) {
    return 'Name must be more than 3 characters long';
  }
  return '';
}
