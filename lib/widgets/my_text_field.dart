import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    Key key,
    @required this.hintText,
    this.controller,
    this.enableInput,
    @required this.inputType,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool enableInput;
  // final String noHp;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // final bool _validate = false;

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      // errorText: validateData(widget.controller.text),
      // validator:
      // errorText: widget.noHp == null ? 'Tidak boleh kosong' : null,
      contentPadding: EdgeInsets.all(20),
  
      hintText: widget.hintText,
      hintStyle: kBodyText,
      // controller: controller,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[400],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        
        controller: widget.controller,
        enabled: widget.enableInput,
        style: kBodyText.copyWith(color: Colors.black),
        keyboardType: widget.inputType,
        textInputAction: TextInputAction.next,
        decoration: inputDecoration,
      ),
    );
  }
}
String validateData(String value) {
  if (!(value.length > 1) && value.isNotEmpty) {
    return "Data tidak boleh kosong";
  }
  return null;
}
