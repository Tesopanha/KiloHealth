import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilo_health/feature/connection/connectivity_controller.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget child;
  final Widget? loadingWidget;

  const NetworkAwareWidget({
    Key? key,
    required this.child,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConnectivityController>();

    return Obx(() {
      if (controller.isInitialLoad.value) {
        if (!controller.isConnected.value) {
          return Center(
            child: loadingWidget ?? const CircularProgressIndicator(),
          );
        }
      }
      return child;
    });
  }
}
