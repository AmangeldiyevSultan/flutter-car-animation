import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetDoorLock = true;
  bool isTrunkDoorLock = true;

  bool isCoolSelected = true;

  bool isShowTyre = false;
  bool isShowTyreStatus = false;

  int selectedBottomTab = 0;

  void onBottomNavigatorTabChange(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateBonnetDoorLock() {
    isBonnetDoorLock = !isBonnetDoorLock;
    notifyListeners();
  }

  void updateTrunkDoorLock() {
    isTrunkDoorLock = !isTrunkDoorLock;
    notifyListeners();
  }

  void updateCoolSelectedTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  void showTyreConroller(int index) {
    if (selectedBottomTab != 3 && index == 3) {
      // should present tyres little bit later because
      // it cover previous page with yourself
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyre = true;
        notifyListeners();
      });
    } else {
      isShowTyre = false;
      notifyListeners();
    }
  }

  void tyreStatusController(int index) {
    if (selectedBottomTab != 3 && index == 3) {
      isShowTyreStatus = true;
      notifyListeners();
    } else {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyreStatus = false;
        notifyListeners();
      });
    }
  }
}
