import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilo_health/component/text_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String name;
  late String image;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments ?? {};

    // Assign the arguments to your variables
    name = arguments['name'] ??
        'Unknown Name'; // Default to 'Unknown Name' if not found
    image = arguments['image'] ??
        'default_image.png'; // Default image path if not found
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildTimestamp("Tue 12:30"),
                _buildChatBubble(image, "Hello Zesan, how can I help you",
                    isUser: false),
                _buildTimestamp("Tue 12:32"),
                _buildChatBubble(
                  "assets/icons/image2.png",
                  "Hey Rebbeka, thanks for your instant response. I am going through a lot of problems, I want to share my situation by giving a video call.",
                  isUser: true,
                ),
                _buildTimestamp("Tue 12:32"),
                _buildChatBubble(
                    "assets/images/doctor.png", "I see, sure you can",
                    isUser: false),
                _buildTimestamp("Tue 12:33"),
                _buildChatBubble("assets/icons/image2.png", "Okay",
                    isUser: true),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    // Attachment Button
                    IconButton(
                      icon: Icon(Icons.add_circle_outline,
                          color: Colors.blue.shade400),
                      onPressed: () {},
                    ),
                    // Emoji Button
                    IconButton(
                      icon: Icon(Icons.emoji_emotions_outlined,
                          color: Colors.blue.shade400),
                      onPressed: () {},
                    ),
                    // Message Input Field
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Message',
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade600),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                maxLines: null,
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ),
                            // Camera Button
                            IconButton(
                              icon: Icon(Icons.camera_alt,
                                  color: Colors.blue.shade400),
                              onPressed: () {
                                // Handle camera
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Send/Voice Button
                    Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue.shade400,
                          ),
                          onPressed: () {},
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
          ),
        ),
      ),
      title: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/doctor.png'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: name,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.videocam_rounded,
            color: Colors.blue.shade400,
            size: 28,
          ),
          onPressed: () {
            // Handle video call
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Icon(
              Icons.phone_outlined,
              color: Colors.blue.shade400,
              size: 24,
            ),
            onPressed: () {
              // Handle voice call
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimestamp(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Center(
        child: SmallText(
          text: text,
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildChatBubble(String imgPath, String message,
      {required bool isUser}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            _buildAvatar(imgPath),
            const SizedBox(
              width: 8,
            )
          ],
          Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                  ),
                  child: SmallText(
                    text: message,
                    overflow: TextOverflow.clip,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          if (isUser) ...[const SizedBox(width: 8), _buildAvatar(imgPath)],
        ],
      ),
    );
  }

  Widget _buildAvatar(String imgPath) {
    return CircleAvatar(
      radius: 18,
      backgroundImage: AssetImage(imgPath),
    );
  }
}
