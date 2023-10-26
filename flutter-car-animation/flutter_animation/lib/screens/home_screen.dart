import 'package:flutter/material.dart';
import 'package:flutter_animation/home_controller.dart';
import 'package:flutter_animation/screens/components/door_lock.dart';
import 'package:flutter_animation/screens/components/tesla_navigation_bottombar.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavigationBar(
              selectedTap: 3,
              onTap: (index) {},
            ),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: constains.maxHeight * 0.1),
                      child: SvgPicture.asset(
                        'assets/icons/Car.svg',
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                        right: constains.maxWidth * 0.05,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLock,
                          press: _controller.updateRightDoorLock,
                        )),
                    Positioned(
                        left: constains.maxWidth * 0.05,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLock,
                          press: _controller.updateLeftDoorLock,
                        )),
                    Positioned(
                        top: constains.maxHeight * 0.13,
                        child: DoorLock(
                          isLock: _controller.isBonnetDoorLock,
                          press: _controller.updateBonnetDoorLock,
                        )),
                    Positioned(
                        bottom: constains.maxHeight * 0.17,
                        child: DoorLock(
                          isLock: _controller.isTrunkDoorLock,
                          press: _controller.updateTrunkDoorLock,
                        )),
                  ],
                );
              }),
            ),
          );
        });
  }
}
