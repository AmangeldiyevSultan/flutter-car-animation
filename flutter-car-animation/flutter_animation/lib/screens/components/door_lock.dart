import 'package:flutter/material.dart';
import 'package:flutter_animation/constanins.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required this.isLock,
    required this.press,
  }) : super(key: key);

  final VoidCallback press;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: AnimatedSwitcher(
          duration: defaultDuration,
          switchInCurve: Curves.easeInOutBack,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: isLock
              ? SvgPicture.asset(
                  'assets/icons/door_lock.svg',
                  key: const ValueKey('lick'),
                )
              : SvgPicture.asset(
                  'assets/icons/door_unlock.svg',
                  key: const ValueKey('unlock'),
                ),
        ));
  }
}
