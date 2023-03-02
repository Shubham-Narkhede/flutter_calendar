import 'package:flutter/material.dart';

Widget widgetText(
    {final String? text,
    final TextAlign? textAlign,
    final int maxLine = 1,
    final double latterSpacing = 0.5,
    final bool textAllCaps = false,
    final isLongText = false,
    final TextStyle? style}) {
  return Text(textAllCaps ? text!.toUpperCase() : text!,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.clip,
      style: style);
}
