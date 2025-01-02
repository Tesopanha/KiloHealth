import 'package:get/get.dart';
import 'package:kilo_health/feature/connection/connectivity_service.dart';
import 'package:kilo_health/feature/home/controller/home_controller.dart';

class ConnectivityController extends GetxController {
  final ConnectivityService _connectivityService;
  final isConnected = true.obs;
  final isInitialLoad = true.obs;

  ConnectivityController(this._connectivityService) {
    _initAsync();
  }

  void _initAsync() {
    _init().catchError((error) {
      print('Connectivity controller init error: $error');
      isConnected.value = false;
      isInitialLoad.value = false;
    });
  }

  Future<void> _init() async {
    try {
      isConnected.value = await _connectivityService.isConnected();
      isInitialLoad.value = false;

      _connectivityService.onConnectivityChanged.listen(
        (connected) {
          isConnected.value = connected;
          if (connected) {
            Get.snackbar('Connected', 'Internet connection restored');
            refreshData();
          } else {
            Get.snackbar('No Internet', 'Please check your connection');
          }
        },
        onError: (error) {
          print('Connectivity stream error: $error');
        },
      );
    } catch (e) {
      print('Init error: $e');
      rethrow;
    }
  }

  Future<void> refreshData() async {
    if (!isConnected.value) return;

    try {
      final homeController = Get.find<HomeController>();
      await Future.wait([
        homeController.fetchCategories(),
        homeController.fetchBlogPosts(),
        homeController.fetchInfo()
      ]);
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }
}
