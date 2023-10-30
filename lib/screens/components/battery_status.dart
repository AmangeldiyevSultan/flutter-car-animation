import 'package:flutter/material.dart';
import 'package:flutter_animation/constanins.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('220 mi',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white)),
        const Text('62%', style: TextStyle(fontSize: 24)),
        const Spacer(),
        const Text('CHARGING', style: TextStyle(fontSize: 20)),
        const Text(
          '19 min remaining',
          style: TextStyle(fontSize: 20),
        ),
        const DefaultTextStyle(
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('22 mi/hr'),
              Text('232 v'),
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        )
      ],
    );
  }
}
