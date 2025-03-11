import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';

class ButtonConfirm extends StatefulWidget {
  final String boxText;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Color textColor;
  final Color boxColor;
  final void Function()? onTap;

  const ButtonConfirm({
    required this.boxText,
    this.textStyle = const TS.s16w500(colorGray600),
    this.width = double.infinity,
    this.height = 48,
    this.textColor = colorWhite,
    this.boxColor = colorGray500,
    this.onTap,
    super.key,
  });

  @override
  State<ButtonConfirm> createState() => _ButtonConfirmState();
}

class _ButtonConfirmState extends State<ButtonConfirm> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.boxColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            widget.boxText,
            style: TS.s18w600(colorWhite),
          ),
        ),
      ),

    );
  }
}
