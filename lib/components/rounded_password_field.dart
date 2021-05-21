import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final controller;
  final Color colorIcon;
  // final TextInputType inputType;
  final formKey;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controller,
    this.colorIcon,
    @required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFieldContainer(
        child: TextFormField(
          // key: formKey,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'password harus diisi';
            }
            return null;
          },
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
      ),
    );
  }
}
