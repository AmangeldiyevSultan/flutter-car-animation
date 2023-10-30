import 'package:flutter/material.dart';
import 'package:flutter_animation/constanins.dart';
import 'package:flutter_animation/home_controller.dart';
import 'package:flutter_animation/screens/components/temp_btn.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    super.key,
    required HomeController controller,
  }) : _controller = controller;

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Temp Buttons
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  text: 'COOL',
                  svgSrc: 'assets/icons/coolShape.svg',
                  isActive: _controller.isCoolSelected,
                  press: _controller.updateCoolSelectedTab,
                  activeColor: primaryColor,
                ),
                const SizedBox(width: defaultPadding),
                TempBtn(
                  text: 'HEAT',
                  svgSrc: 'assets/icons/heatShape.svg',
                  isActive: !_controller.isCoolSelected,
                  press: _controller.updateCoolSelectedTab,
                  activeColor: redColor,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_up, size: 48),
              ),
              const Text(
                '29' '\u2103',
                style: TextStyle(fontSize: 86),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down, size: 48),
              ),
            ],
          ),

          const Spacer(),
          const Text('CURRENT TEMPERATURE'),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('INSIDE', style: TextStyle(color: Colors.white54)),
                Text(
                  '20' '\u2103',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white54),
                )
              ]),
              const SizedBox(width: defaultPadding),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('INSIDE', style: TextStyle(color: Colors.white54)),
                Text(
                  '35' '\u2103',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white54),
                )
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
