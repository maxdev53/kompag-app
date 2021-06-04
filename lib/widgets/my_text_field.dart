import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    Key key,
    @required this.hintText,
    this.controller,
    this.enableInput,
    @required this.inputType,
    @required this.formKey,
    @required this.withIcon,
    this.textIcon,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool enableInput;
  final formKey;
  final IconButton textIcon;
  final bool withIcon;

  // final String noHp;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // final bool _validate = false;
  bool _withIcon;
  @override
  void initState() {
    super.initState();
    setState(() {
      _withIcon = widget.withIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      filled: true,
      suffixIcon: widget.withIcon
          ? widget.textIcon
          : Icon(
              Icons.check,
            ),
      // suffix: ()=>,
      fillColor: Colors.white,
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
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          minLines: 1,
          maxLines: 20,
          validator: (value) {
            Pattern pattern = '^([0]:?[82])?[0-9]{10,14}';
            // Pattern pattern = '/^([08])[0-9]{6,14}';
            RegExp regex = new RegExp(pattern);
            if (widget.inputType == TextInputType.phone) {
              if (value == null || value.isEmpty || !regex.hasMatch(value)) {
                return value.isEmpty
                    ? "No HP tidak boleh kosong"
                    : 'No HP tidak valid';
              }
              return null;
            } else {
              if (value == null || value.isEmpty) {
                return '${(widget.inputType == TextInputType.name) ? 'Nama' : (widget.inputType == TextInputType.emailAddress) ? 'Email' : 'Data'} harus disi';
              }
              return null;
            }
          },
          controller: widget.controller,
          enabled: widget.enableInput,
          style: kBodyText.copyWith(color: Colors.black),
          keyboardType: widget.inputType,
          textInputAction: TextInputAction.next,
          decoration: inputDecoration,
        ),
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
