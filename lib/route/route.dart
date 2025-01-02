import 'package:get/get.dart';
import 'package:kilo_health/feature/message/chat_screen.dart';
import 'package:kilo_health/feature/dashboard/dashboard.dart';
import 'package:kilo_health/feature/home/view/detail/detail_screen.dart';
import 'package:kilo_health/feature/home/view/search/search_screen.dart';

class AppRoute {
  static const String daschBoard = "/dash";
  static const String home = '/home';
  static const String detail = '/detail';
  static const String search = '/search';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String message = '/message';
  static const String chat = '/chat';
  static const String saved = '/saved';
  static const String appointment = '/appointment';
  static const String payment = '/payment';
  static const String card = '/card';
  static const String internet = '/internet';
}

final routes = [
  GetPage(
    name: AppRoute.daschBoard,
    page: () => const DashBoard(),
  ),
  GetPage(name: AppRoute.detail, page: () => const DetailScreen()),
  GetPage(name: AppRoute.search, page: () => const SearchScreen()),
  GetPage(name: AppRoute.chat, page: () => const ChatScreen()),
];
