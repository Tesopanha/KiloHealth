import 'package:get/get.dart';
import 'package:kilo_health/feature/dashboard/controller/navigate_controller.dart';
import 'package:kilo_health/feature/notification/controller/notification_controller.dart';
import 'package:kilo_health/feature/profile/controller/profile_controller.dart';

class Dashbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigateController(), permanent: true);

    Get.put(ProfileController());

    Get.put(NotificationController());
  }
}
