import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> tyres(BoxConstraints constrains, bool isShowTyre) {
  const duration = Duration(milliseconds: 408);
  return [
    AnimatedPositioned(
      duration: duration,
      left: constrains.maxWidth * 0.2,
      top: isShowTyre ? constrains.maxHeight * 0.22 : -200,
      child: SvgPicture.asset("assets/icons/FL_Tyre.svg"),
    ),
    AnimatedPositioned(
      duration: duration,
      right: constrains.maxWidth * 0.2,
      top: isShowTyre ? constrains.maxHeight * 0.22 : -200,
      child: SvgPicture.asset("assets/icons/FL_Tyre.svg"),
    ),
    AnimatedPositioned(
      duration: duration,
      right: constrains.maxWidth * 0.2,
      top: isShowTyre ? constrains.maxHeight * 0.63 : -200,
      child: SvgPicture.asset("assets/icons/FL_Tyre.svg"),
    ),
    AnimatedPositioned(
      duration: duration,
      left: constrains.maxWidth * 0.2,
      top: isShowTyre ? constrains.maxHeight * 0.63 : -200,
      child: SvgPicture.asset("assets/icons/FL_Tyre.svg"),
    ),
  ];
}
