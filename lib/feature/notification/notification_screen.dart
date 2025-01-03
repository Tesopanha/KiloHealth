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
                fontSize: 16,
              ))
        ],
      ),
      body: Obx(
        () => controller.notificationData.isEmpty
            ? SafeArea(
                child:
                    Center(child: Image.asset("assets/icons/empty_logo.png")),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: controller.notificationData.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 18,
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
    );
  }

  Widget _buildNotificationItem(BuildContext context, NotificationData detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 90,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: Image.network(
              detail.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.image_not_supported, color: Colors.grey.shade400),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              BigText(
                text: detail.name,
                fontSize: 16,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  SmallText(
                    text: detail.createdAt,
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
