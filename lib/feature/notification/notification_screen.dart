import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilo_health/feature/notification/controller/notification_controller.dart';
import 'package:kilo_health/feature/notification/model/notification_model.dart';
import 'package:kilo_health/component/text_widget.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const BigText(
          text: "Notifications",
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const BigText(
                text: "Clear All",
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ))
        ],
      ),
      body: Obx(
        () => controller.notificationData.isEmpty
            ? SafeArea(
                child:
                    Center(child: Image.asset("assets/icons/empty_logo.png")),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.separated(
                  itemCount: controller.notificationData.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    var notificationData = controller.notificationData[index];

                    return _buildNotificationItem(context, notificationData);
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, NotificationData detail) {
    return Row(
      children: [
        SizedBox(
            height: 100, width: 100, child: Image.network(detail.thumbnail)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: detail.name,
                fontSize: 18,
                overflow: TextOverflow.clip,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: detail.createdAt,
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline_sharp))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
