import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilo_health/feature/dashboard/controller/navigate_controller.dart';

class DashBoard extends GetView<NavigateController> {
  const DashBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: controller.screen,
        onPageChanged: (index) => controller.changeScreenIndex(index),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeScreenIndex(index);
          },
          selectedLabelStyle: const TextStyle(fontSize: 12),
          iconSize: 24,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message_outlined,
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
