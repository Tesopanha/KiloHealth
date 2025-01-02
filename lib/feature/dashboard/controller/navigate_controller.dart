import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kilo_health/feature/home/view/home/home_screen.dart';
import 'package:kilo_health/feature/message/message_screen.dart';
import 'package:kilo_health/feature/notification/notification_screen.dart';
import 'package:kilo_health/feature/profile/view/profile_screen.dart';

class NavigateController extends GetxController {
  final selectedIndex = 0.obs;
  final screen = [
    const HomeScreen(),
    const MessageScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];

  PageController pageController = PageController();

  void changeScreenIndex(int index) {
    selectedIndex(index);
    pageController.jumpToPage(index);
  }
}
