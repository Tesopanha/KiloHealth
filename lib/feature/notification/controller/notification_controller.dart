import 'package:get/get.dart';
import 'package:kilo_health/feature/notification/model/notification_model.dart';
import 'package:kilo_health/repository/api_service.dart';

class NotificationController extends GetxController {
  var notificationData = <NotificationData>[].obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    getNotificationData();
  }

  Future<void> getNotificationData() async {
    try {
      NotificationModel model = await _apiService.fetchNotification();
      notificationData.value = model.data;
    } catch (e) {
      // Handle error
      print('Error fetching categories: $e');
    }
  }
}
