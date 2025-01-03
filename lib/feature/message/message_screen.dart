import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilo_health/feature/message/model/message_model.dart';
import 'package:kilo_health/route/route.dart';
import 'package:kilo_health/component/text_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue.shade100,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.blue,
              size: 26,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.blue,
                  size: 30,
                )),
          )
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: BigText(
              text: "Emergency consult with your recommended doctor",
              fontWeight: FontWeight.bold,
              fontSize: 26,
              overflow: TextOverflow.clip,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(height: 90, child: _buildChatProfile(context)),
          const Padding(
            padding: EdgeInsets.all(10),
            child: BigText(
              text: "All Messages",
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _listChat()
        ],
      ),
    );
  }

  Widget _buildChatProfile(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 10, right: 10),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: MessageModel.chatList.length,
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
      itemBuilder: (context, index) {
        var detail = MessageModel.chatList[index];
        return Stack(
          children: [
            CircleAvatar(
              radius: 32, // Radius of the profile circle
              backgroundImage: AssetImage(detail.image),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _listChat() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, _) => const SizedBox(
              height: 10,
            ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return _buildChatItem("assets/images/doctor.png", "Dr Rebbeka",
              "You have to more careful", "Tue", false);
        });
  }

  Widget _buildChatItem(String imgPath, String name, String lastMessage,
      String time, bool isNew) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoute.chat,
            arguments: {'name': name, 'image': imgPath}),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(imgPath),
              radius: 28,
            ),
            title: SmallText(
              text: name,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle: SmallText(
              text: lastMessage,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isNew)
                  const Icon(
                    Icons.circle,
                    color: Colors.blue,
                    size: 10,
                  ),
                SmallText(
                  text: time,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
