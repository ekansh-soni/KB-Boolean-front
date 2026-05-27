import 'package:flutter/cupertino.dart';
import 'package:kb_boolean/theme/style_helper.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double? fontSize ;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.color,
    this.textAlign,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: StyleHelper.customStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        family: fontFamily,
        color: color
      ),
      maxLines: maxLines,
      textAlign: textAlign ?? .left,
    );
  }
}
