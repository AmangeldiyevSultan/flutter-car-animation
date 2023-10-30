import 'package:flutter/material.dart';
import 'package:flutter_animation/constanins.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TempBtn extends StatelessWidget {
  const TempBtn({
    super.key,
    required this.isActive,
    required this.svgSrc,
    required this.text,
    required this.press,
    required this.activeColor,
  });

  final String svgSrc;
  final bool isActive;
  final String text;
  final VoidCallback press;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: press,
          // Animated Container
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutBack,
            height: isActive ? 76 : 50,
            width: isActive ? 76 : 50,
            child: SvgPicture.asset(
              svgSrc,
              colorFilter: ColorFilter.mode(
                  // BlendMode.srcIn colored exactly just icon
                  isActive ? activeColor : Colors.white38,
                  BlendMode.srcIn),
            ),
          ),
        ),
        const SizedBox(
          height: defaultPadding / 2,
        ),
        // Animated Text
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: isActive ? activeColor : Colors.white38,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : null,
          ),
          child: Text(
            text,
          ),
        ),
      ],
    );
  }
}
