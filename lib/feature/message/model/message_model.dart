class MessageModel {
  final String name;
  final String image;
  final String email;
  final bool active;
  final String detail;

  MessageModel({
    required this.name,
    required this.email,
    required this.image,
    required this.active,
    required this.detail,
  });
  Map<String, dynamic> toMap() => {
        'name': name,
        'image': image,
        'active': active,
        'detail': detail,
        'email': email
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        name: json['name'],
        image: json['image'],
        email: json['email'],
        active: json['active'],
        detail: json['detail']);
  }

  static List<MessageModel> chatList = [
    MessageModel(
        name: "Dr Robbieks",
        image: 'assets/images/doctor3.png',
        email: "",
        active: true,
        detail: "you have to be more careful"),
    MessageModel(
        name: "Dr Robbieks",
        image: 'assets/images/doctor2.png',
        email: "",
        active: true,
        detail: "you have to be more careful"),
    MessageModel(
        name: "Dr Robbieks",
        image: 'assets/images/doctor5.png',
        email: "",
        active: true,
        detail: "you have to be more careful"),
    MessageModel(
        name: "Dr Robbieks",
        image: 'assets/images/doctor4.png',
        email: "",
        active: true,
        detail: "you have to be more careful"),
    MessageModel(
        name: "Dr Robbieks",
        image: 'assets/images/doctor4.png',
        email: "",
        active: true,
        detail: "you have to be more careful"),
    MessageModel(
        name: "Dr Robbieks",
        image: 'assets/images/doctor4.png',
        email: "",
        active: true,
        detail: "you have to be more careful"),
    MessageModel(
        name: "Dr Robbieks",
        image: 'assets/images/doctor4.png',
        email: "",
        active: true,
        detail: "you have to be more careful"),
  ];
}

class ChatModel {
  final String sender;
  final String receiver;
  final DateTime time;
  final String content;

  ChatModel(
      {required this.sender,
      required this.receiver,
      required this.time,
      required this.content});

  Map<String, dynamic> toMap() => {
        'sender': sender,
        'receiver': receiver,
        'time': time,
        'content': content,
      };

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        sender: json['sender'],
        receiver: json['receiver'],
        time: json['time'],
        content: json['content']);
  }
}
