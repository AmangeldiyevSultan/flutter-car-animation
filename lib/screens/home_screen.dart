import 'package:flutter/material.dart';
import 'package:flutter_animation/constanins.dart';
import 'package:flutter_animation/home_controller.dart';
import 'package:flutter_animation/screens/components/battery_status.dart';
import 'package:flutter_animation/screens/components/door_lock.dart';
import 'package:flutter_animation/screens/components/temp_details.dart';
import 'package:flutter_animation/screens/components/tesla_navigation_bottombar.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
// TickerProviderStateMixin for animation to count Ticker
// If there is just one animation controller than use just SingleTickerProviderStateMixin
    with
        TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;

  void setUpTempAnimationContoller() {
    // Duration of any animation by deafault 1500
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Should complete in interval 0.2 - 0.4.
    _animationCarShift = CurvedAnimation(
        // Firstly wait until previous animation done and start this animation from 0.2
        parent: _tempAnimationController,
        curve: const Interval(0.2, 0.4));

    // Should complete in interval 0.7 - 1.
    _animationCoolGlow = CurvedAnimation(
        // Firstly wait until previous animation done and start this animation from 0.7
        parent: _tempAnimationController,
        curve: const Interval(0.7, 1));

    // Should complete in interval 0.45 - 0.65.
    _animationTempShowInfo = CurvedAnimation(
        // Firstly wait until previous animation done and start this animation from 0.45
        parent: _tempAnimationController,
        curve: const Interval(0.45, 0.65));
  }

  void setUpBatteryAnimation() {
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
    setUpBatteryAnimation();
    setUpTempAnimationContoller();
  }

  @override
  void dispose() {
    super.dispose();
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // do not work without animated builder, because its counts tickers
    return AnimatedBuilder(
        // List of controllers
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController
        ]),
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
                if (index == 2) {
                  // Say that animation should start forward
                  _tempAnimationController.forward();
                } else if (_controller.selectedBottomTab == 2 && index != 2) {
                  // Should go back
                  _tempAnimationController.reverse(from: 0.4);
                }
                _controller.onBottomNavigatorTabChange(index);
              },
            ),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                    ),
                    // Lock Screen
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrains.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                        ),
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
                    // Changing by animation battery status
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
                    ),
                    // Temperature
                    Positioned(
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                        top: 60 * (1 - _animationTempShowInfo.value),
                        child: Opacity(
                            opacity: _animationTempShowInfo.value,
                            child: TempDetails(controller: _controller))),

                    // Car head/cool color
                    Positioned(
                        right: -180 * (1 - _animationCoolGlow.value),
                        child: AnimatedSwitcher(
                            duration: defaultDuration,
                            child: _controller.isCoolSelected
                                ? Image.asset(
                                    "assets/images/Cool_glow_2.png",
                                    key: UniqueKey(),
                                    width: 200,
                                  )
                                : Image.asset(
                                    "assets/images/Hot_glow_4.png",
                                    key: UniqueKey(),
                                    width: 200,
                                  ))),
                  ],
                );
              }),
            ),
          );
        });
  }
}
