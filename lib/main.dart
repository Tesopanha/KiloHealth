import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilo_health/feature/connection/connectivity_controller.dart';
import 'package:kilo_health/feature/connection/connectivity_service.dart';

import 'package:kilo_health/feature/dashboard/binding/home_binding.dart';
import 'package:kilo_health/feature/home/controller/home_controller.dart';
import 'package:kilo_health/route/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final connectivityService = ConnectivityService();
    Get.put(HomeController());
    Get.put(ConnectivityController(connectivityService));

    runApp(const MyApp());
  } catch (e) {
    print('Initialization error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kilo Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.daschBoard,
      getPages: routes,
      initialBinding: Dashbinding(),
    );
  }
}
