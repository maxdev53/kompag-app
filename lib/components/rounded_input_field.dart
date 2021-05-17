import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  // var attController;
  final controller;
  final IconData icon;
  final Color colorIcon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText = "Masukan Email",
    this.icon = Icons.email,
    this.onChanged,
    this.colorIcon,
    this.controller,
    // this._emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              icon,
              color: colorIcon
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
