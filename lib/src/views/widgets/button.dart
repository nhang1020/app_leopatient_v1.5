import 'package:app/src/utils/variables.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    this.isGradient,
    this.width,
    this.height,
    this.label,
    this.fontSize,
    this.icon,
    this.onPressed,
    this.radius,
    this.colors,
    this.boxShadows,
    this.textColor,
    this.subfixIcon,
    this.color,
    this.borderRadius,
    this.padding,
    this.border,
    this.duration,
    this.enabled,
    this.maxLines,
    this.textAlign,
    this.labelStyle,
  });
  bool? isGradient;
  double? width;
  double? height;
  String? label;
  double? fontSize;
  Widget? icon;
  Function()? onPressed;
  double? radius;
  List<Color>? colors;
  List<BoxShadow>? boxShadows;
  Color? textColor;
  Widget? subfixIcon;
  Color? color;
  BorderRadius? borderRadius;
  EdgeInsets? padding;
  Border? border;
  Duration? duration;
  bool? enabled;
  int? maxLines;
  TextAlign? textAlign;
  TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      duration: duration ?? Duration(seconds: 0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        boxShadow: boxShadows ?? [],
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10),
        gradient: LinearGradient(
            colors: enabled != null && enabled == false
                ? [myColor.withOpacity(.4), myColor.withOpacity(.4)]
                : (isGradient != null && isGradient == true
                    ? colors ?? [myColor, Colors.blueAccent]
                    : [color ?? myColor, color ?? myColor])),
      ),
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        elevation: 0,
        child: InkWell(
          onTap:
              enabled != null && enabled == false ? null : (onPressed ?? null),
          child: Container(
            width: width ?? 120,
            margin:
                padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                icon ?? Container(),
                SizedBox(width: label != null ? 5 : 0),
                label != null
                    ? Expanded(
                        child: Text(
                          "${label}",
                          style: labelStyle ??
                              TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSize ?? 14,
                                color: textColor ?? Theme.of(context).cardColor,
                              ),
                          textAlign: textAlign ?? TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: maxLines ?? 1,
                        ),
                      )
                    : SizedBox(),
                SizedBox(width: label != null ? 5 : 0),
                subfixIcon ?? SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
