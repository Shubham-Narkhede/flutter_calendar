import 'package:flutter/material.dart';

enum ButtonWidth { max, min }

enum ButtonSize { md, lr, sm }

enum ButtonType {
  textButton,
  filledButton,
}

class WidgetButton extends StatefulWidget {
  final IconData? frontIcon;
  final IconData? backIcon;
  final Widget? widgetFrontIcon;
  final Widget? widgetBackIcon;
  final String? frontIconUrl;
  final String? backIconUrl;
  final String? title;
  final TextStyle? textStyle;
  final Color? color;
  final Color? progressColor;
  final BorderSide? borders;
  final Function onPressed;
  final OutlinedBorder? borderRadius;
  final ButtonSize? size;
  final ButtonWidth? enumButtonWidth;
  final ButtonType? enumButtonType;
  final Color? iconColor;
  final double? iconSize;
  WidgetButton(
      {this.frontIcon,
      this.backIcon,
      required this.title,
      this.textStyle,
      this.color,
      this.borders,
      this.borderRadius,
      this.size,
      this.enumButtonWidth,
      this.enumButtonType,
      required this.onPressed,
      this.widgetFrontIcon,
      this.widgetBackIcon,
      this.progressColor,
      this.iconColor,
      this.frontIconUrl,
      this.backIconUrl,
      this.iconSize});

  @override
  State<WidgetButton> createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  @override
  void initState() {
    super.initState();
  }

  Widget showIconImage(
      {IconData? iconData,
      Widget? widgetIcon,
      String? imageUrl,
      double rightMargin = 0,
      double leftMargin = 0}) {
    return Container(
        margin: EdgeInsets.only(
            right: imageUrl != null || widgetIcon != null || iconData != null
                ? rightMargin
                : 0,
            left: imageUrl != null || widgetIcon != null || iconData != null
                ? leftMargin
                : 0),
        child: widgetIcon != null
            ? widgetIcon
            : imageUrl != null
                ? Image.asset(
                    imageUrl,
                    color: widget.iconColor != null
                        ? widget.iconColor
                        : widget.enumButtonType == ButtonType.filledButton ||
                                widget.enumButtonType == null
                            ? Colors.white
                            : Theme.of(context).primaryColorDark,
                  )
                : iconData != null
                    ? Icon(
                        iconData,
                        size: widget.iconSize != null
                            ? widget.iconSize
                            : () {
                                switch (widget.size) {
                                  case ButtonSize.lr:
                                    return 32.0;
                                  case ButtonSize.md:
                                    return 26.0;
                                  case ButtonSize.sm:
                                    return 20.0;
                                  default:
                                    return 26.0;
                                }
                              }(),
                        color: widget.iconColor != null
                            ? widget.iconColor
                            : widget.enumButtonType ==
                                        ButtonType.filledButton ||
                                    widget.enumButtonType == null
                                ? Colors.white
                                : Theme.of(context).primaryColorDark,
                      )
                    : null);
  }

  Widget child({icon}) {
    return icon != null
        ? Icon(
            icon,
            color: () {
              switch (widget.enumButtonType) {
                case ButtonType.filledButton:
                  return Colors.white;
                case ButtonType.textButton:
                  return Colors.green;
                default:
                  return Colors.white;
              }
            }(),
            size: iconHeightWidth(),
          )
        : Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.frontIcon != null ||
                    widget.widgetFrontIcon != null ||
                    widget.frontIconUrl != null)
                  showIconImage(
                      iconData: widget.frontIcon,
                      widgetIcon: widget.widgetFrontIcon,
                      imageUrl: widget.frontIconUrl,
                      rightMargin: () {
                        switch (widget.size) {
                          case ButtonSize.lr:
                            return 8.0;
                          case ButtonSize.md:
                            return 5.0;
                          case ButtonSize.sm:
                            return 7.0;
                          default:
                            return 5.0;
                        }
                      }()),
                Text(
                  widget.title == null ? "Title" : widget.title!,
                  style: widget.textStyle != null
                      ? widget.textStyle
                      : TextStyle(
                          color: widget.enumButtonType ==
                                      ButtonType.filledButton ||
                                  widget.enumButtonType == null
                              ? Colors.white
                              : Theme.of(context).primaryColorDark,
                          fontSize: () {
                            switch (widget.size) {
                              case ButtonSize.lr:
                                return 17.0;
                              case ButtonSize.md:
                                return 15.0;
                              case ButtonSize.sm:
                                return 12.0;
                              default:
                                return 15.0;
                            }
                          }()),
                ),
                if (widget.backIcon != null ||
                    widget.widgetBackIcon != null ||
                    widget.backIconUrl != null)
                  showIconImage(
                      iconData: widget.backIcon,
                      widgetIcon: widget.widgetBackIcon,
                      imageUrl: widget.backIconUrl,
                      leftMargin: () {
                        switch (widget.size) {
                          case ButtonSize.lr:
                            return 8.0;
                          case ButtonSize.md:
                            return 5.0;
                          case ButtonSize.sm:
                            return 7.0;
                          default:
                            return 5.0;
                        }
                      }()),
              ],
            ),
          );
  }

  double iconHeightWidth() {
    switch (widget.size) {
      case ButtonSize.lr:
        return 30;
      case ButtonSize.md:
        return 24;
      case ButtonSize.sm:
        return 15;
      default:
        return 20;
    }
  }

  double heightWidth() {
    switch (widget.size) {
      case ButtonSize.lr:
        return 27;
      case ButtonSize.md:
        return 17;
      case ButtonSize.sm:
        return 10;
      default:
        return 15;
    }
  }

  double height() {
    switch (widget.size) {
      case ButtonSize.lr:
        return 48;
      case ButtonSize.md:
        return 40;
      case ButtonSize.sm:
        return 32;
      default:
        return 40;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(),
      child: ElevatedButton(
        child: Row(
          mainAxisSize: () {
            switch (widget.enumButtonWidth) {
              case ButtonWidth.max:
                return MainAxisSize.max;
              case ButtonWidth.min:
                return MainAxisSize.min;
              default:
                return MainAxisSize.min;
            }
          }(),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: heightWidth(),
              width: heightWidth(),
              child: CircularProgressIndicator(
                strokeWidth: () {
                  switch (widget.size) {
                    case ButtonSize.lr:
                      return 4.0;
                    case ButtonSize.md:
                      return 4.0;
                    case ButtonSize.sm:
                      return 3.0;
                    default:
                      return 3.0;
                  }
                }(),
                backgroundColor: Colors.white,
                valueColor: widget.color == null
                    ? widget.progressColor != null
                        ? AlwaysStoppedAnimation(widget.progressColor)
                        : AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColorDark)
                    : widget.progressColor != null
                        ? AlwaysStoppedAnimation(widget.progressColor)
                        : AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColorDark),
              ),
            )
          ],
        ),
        onPressed: () {
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
            elevation: widget.enumButtonType == ButtonType.filledButton ? 1 : 0,
            side: () {
              switch (widget.enumButtonType) {
                case ButtonType.filledButton:
                  return widget.borders;
                case ButtonType.textButton:
                  return null;
                default:
                  return widget.borders;
              }
            }(),
            primary: () {
              switch (widget.enumButtonType) {
                case ButtonType.filledButton:
                  return widget.color ?? Theme.of(context).primaryColor;
                case ButtonType.textButton:
                  return Colors.white;
                default:
                  return widget.color ?? Theme.of(context).primaryColor;
              }
            }(),
            padding: () {
              switch (widget.size) {
                case ButtonSize.lr:
                  return EdgeInsets.only(
                      left: leftPadding(13, 25), right: rightPadding(13, 20));
                case ButtonSize.md:
                  return EdgeInsets.only(
                      left: leftPadding(13, 25), right: rightPadding(10, 22));
                case ButtonSize.sm:
                  return EdgeInsets.only(
                      left: leftPadding(13, 20), right: rightPadding(10, 17));
                default:
                  return EdgeInsets.only(
                      left: leftPadding(13, 25), right: rightPadding(10, 22));
              }
            }(),
            shape: () {
              switch (widget.enumButtonType) {
                case ButtonType.filledButton:
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40));
                case ButtonType.textButton:
                  return null;
                default:
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40));
              }
            }()),
      ),
    );
  }

  double leftPadding(double left, double withoutIconPadding) {
    return widget.widgetFrontIcon != null || widget.frontIcon != null
        ? left
        : withoutIconPadding;
  }

  double rightPadding(double right, double withoutIconPadding) {
    return widget.backIcon != null || widget.widgetBackIcon != null
        ? right
        : withoutIconPadding;
  }
}
