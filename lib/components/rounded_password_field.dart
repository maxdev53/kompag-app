import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final controller;
  final Color colorIcon;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controller,
    this.colorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey),
            icon: Icon(
              Icons.lock,
              color: colorIcon,
            ),
            // suffixIcon: Icon(Icons.visibility, color: Colors.blue),
            border: InputBorder.none),
      ),
    );
  }
}
