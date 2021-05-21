import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  // var attController;
  final controller;
  final TextInputType inputType;
  final IconData icon;
  final Color colorIcon;
  final formKey;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText = "Masukan Email",
    this.icon = Icons.email,
    this.onChanged,
    this.colorIcon,
    this.controller,
    @required this.formKey,
    @required this.inputType,
    // this._emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFieldContainer(
        child: TextFormField(
          validator: (value) {
           
            if (inputType == TextInputType.text) {
              if (value == null || value.isEmpty) {
                return "tidak boleh kosong";
              }
              return null;
            } else {
              if (value == null || value.isEmpty) {
                return 'error';
              }
              return null;
            }
          },
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(icon, color: colorIcon),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
