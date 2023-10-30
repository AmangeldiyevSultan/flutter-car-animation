import 'package:flutter/material.dart';
import 'package:flutter_animation/constanins.dart';
import 'package:flutter_animation/home_controller.dart';
import 'package:flutter_animation/screens/components/battery_status.dart';
import 'package:flutter_animation/screens/components/door_lock.dart';
import 'package:flutter_animation/screens/components/tesla_navigation_bottombar.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
// SingleTickerProviderStateMixin for animation to count Ticker
    with
        SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  void setupBatteryAnimation() {
    // Duration of any animation by deafault 600
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    // Should complete in interval 0 - 0.5 that mean 300 millisec.
    _animationBattery = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(0.0, 0.5));

    // Should start completing after 0.6 and till end, so from 360 till 600 ms
    _animationBatteryStatus = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(0.6, 1));
  }

  @override
  void initState() {
    super.initState();
    setupBatteryAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _batteryAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // do not work without animated builder, because its counts tickers
    return AnimatedBuilder(
        // List of controllers
        animation: Listenable.merge([_controller, _batteryAnimationController]),
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavigationBar(
              selectedTap: _controller.selectedBottomTab,
              onTap: (index) {
                // index = 1 than start animation to forward
                if (index == 1) {
                  _batteryAnimationController.forward();
                } else if (_controller.selectedBottomTab == 1 && index != 1) {
                  // while selected tab on page and index start changing
                  // without changing selectTab in provider animation started
                  // start reversing from 0.7
                  _batteryAnimationController.reverse(from: 0.7);
                }
                _controller.onBottomNavigatorTabChange(index);
              },
            ),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: constrains.maxHeight * 0.1),
                      child: SvgPicture.asset(
                        'assets/icons/Car.svg',
                        width: double.infinity,
                      ),
                    ),
                    AnimatedPositioned(
                        duration: defaultDuration,
                        right: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            isLock: _controller.isRightDoorLock,
                            press: _controller.updateRightDoorLock,
                          ),
                        )),
                    AnimatedPositioned(
                        duration: defaultDuration,
                        left: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          duration: defaultDuration,
                          child: DoorLock(
                            isLock: _controller.isLeftDoorLock,
                            press: _controller.updateLeftDoorLock,
                          ),
                        )),
                    AnimatedPositioned(
                        duration: defaultDuration,
                        top: _controller.selectedBottomTab == 0
                            ? constrains.maxHeight * 0.13
                            : constrains.maxHeight / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            isLock: _controller.isBonnetDoorLock,
                            press: _controller.updateBonnetDoorLock,
                          ),
                        )),
                    AnimatedPositioned(
                        duration: defaultDuration,
                        bottom: _controller.selectedBottomTab == 0
                            ? constrains.maxHeight * 0.17
                            : constrains.maxHeight / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            isLock: _controller.isTrunkDoorLock,
                            press: _controller.updateTrunkDoorLock,
                          ),
                        )),
                    // Battery
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        "assets/icons/Battery.svg",
                        width: constrains.maxWidth * 0.45,
                      ),
                    ),
                    // changing by animation battery status
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(
                          constraints: constrains,
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        });
  }
}
