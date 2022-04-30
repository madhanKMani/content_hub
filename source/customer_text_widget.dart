import 'package:flutter/widgets.dart';

class AppText extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Decoration? decoration;
  final EdgeInsets? margin, padding;
  final TextStyle? style;
  final int maxLines;
  final Alignment? alignment;

  const AppText(
    this.text, {
    Key? key,
    this.onTap,
    this.decoration,
    this.padding,
    this.margin,
    this.style,
    this.maxLines = 1,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: decoration,
          alignment: alignment,
          margin: margin,
          padding: padding,
          child: Text(text, style: style,
              textScaleFactor: mediaQuery.textScaleFactor.clamp(1.0, 1.5),
              maxLines: maxLines,),
        ));
  }
}
