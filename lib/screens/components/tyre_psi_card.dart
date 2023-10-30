import 'package:flutter/material.dart';
import 'package:flutter_animation/constanins.dart';
import 'package:flutter_animation/models/tyre_psi.dart';

class TyrePsiCard extends StatelessWidget {
  const TyrePsiCard({
    super.key,
    required this.isBottomTwoTyre,
    required this.tyrePsi,
  });

  final bool isBottomTwoTyre;
  final TyrePsi tyrePsi;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color:
            tyrePsi.isLowPressure ? redColor.withOpacity(0.1) : Colors.white10,
        border: Border.all(
          color:
              tyrePsi.isLowPressure ? redColor.withOpacity(0.1) : primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: isBottomTwoTyre
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                lowPressureText(context),
                const Spacer(),
                psiText(context, psi: tyrePsi.psi.toString()),
                const SizedBox(height: defaultPadding),
                Text(
                  '${tyrePsi.temp}\u2103',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                psiText(context, psi: tyrePsi.psi.toString()),
                const SizedBox(height: defaultPadding),
                Text(
                  '${tyrePsi.temp}\u2103',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                lowPressureText(context),
              ],
            ),
    );
  }

  Column lowPressureText(BuildContext context) {
    return Column(
      children: [
        Text(
          'LOW',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Text(
          'PRESSURE',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Text psiText(BuildContext context, {required String psi}) {
    return Text.rich(
      TextSpan(
        text: psi,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
        children: const [
          TextSpan(
            text: 'psi',
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
    );
  }
}
