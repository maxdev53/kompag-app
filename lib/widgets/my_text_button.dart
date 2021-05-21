import 'package:flutter/material.dart';
import '../constants.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key key,
    @required this.buttonName,
    @required this.onTap,
    @required this.bgColor,
    @required this.textColor, 
    @required this.borderColor,
  }) : super(key: key);
  final String buttonName;
  final Function onTap;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: borderColor),
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.black12,
          ),
        ),
        onPressed: onTap,
        child: Text(
          buttonName,
          style: kButtonText.copyWith(color: textColor),
        ),
      ),
    );
  }
}
