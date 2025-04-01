import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';

class TextFieldSearch extends TextField {
  TextFieldSearch({super.key,
    super.onChanged,
    super.controller,
    super.inputFormatters,
    super.focusNode,
    super.keyboardType,
    super.obscureText,
    super.expands,
    super.maxLines,
    super.maxLength,
    super.onSubmitted,
    super.onEditingComplete,
    super.textAlign = TextAlign.left,
    bool super.enabled = true,
    String? hintText,
    Widget? suffix,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Color fillColor = colorWhite,
    String? errorText,
    TextStyle? textStyle = const TS.s16w400(colorBlack),
    TextStyle? hintStyle = const TS.s16w400(colorGray500),
    String? suffixText,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
    TextAlignVertical super.textAlignVertical = TextAlignVertical.center,
    Color colorBorder = colorGray400,
    double radius = 12,
  }) : super(
    style: textStyle,
    cursorColor: colorGreen600,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      suffix: suffix,
      hintText: hintText,
      hintStyle: hintStyle,
      isDense: true,
      filled: true,
      counterStyle: const TS.s12w400(colorGray400),
      fillColor: fillColor,
      errorText: errorText,
      suffixText: suffixText,
      suffixStyle: const TS.s18w400(colorGray900),
      contentPadding: contentPadding,
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorBorder),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorBorder),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colorBorder),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorBorder),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorGreen600),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    ),
  );
}


