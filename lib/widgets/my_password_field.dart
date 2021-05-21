import 'package:flutter/material.dart';
import '../constants.dart';

class MyPasswordField extends StatelessWidget {
  const MyPasswordField(
      {Key key,
      this.controller,
      this.hintText,
      @required this.isPasswordVisible,
      @required this.onTap,
      @required this.formKey})
      : super(key: key);
  final formKey;
  final bool isPasswordVisible;
  final Function onTap;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: formKey,
        child: TextFormField(
          validator: (value) {
            if (value == null && value.isEmpty) {
              return 'tidak boleh kosong';
            }
            return null;
          },
          controller: controller,
          style: kBodyText.copyWith(
            color: Colors.black,
          ),
          obscureText: isPasswordVisible,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: onTap,
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(20),
            hintText: hintText,
            hintStyle: kBodyText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    );
  }
}
