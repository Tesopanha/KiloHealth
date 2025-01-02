class NotificationModel {
  int status;
  String message;
  List<NotificationData> data;
  Paging paging;

  NotificationModel({
    required this.status,
    required this.message,
    required this.data,
    required this.paging,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"],
        message: json["message"],
        data: List<NotificationData>.from(
            json["data"].map((x) => NotificationData.fromJson(x))),
        paging: Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };
}

class NotificationData {
  int id;
  String type;
  String name;
  String description;
  String thumbnail;
  bool favorite;
  String createdAt;
  DateTime viewAt;

  NotificationData({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.favorite,
    required this.createdAt,
    required this.viewAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        favorite: json["favorite"],
        createdAt: json["createdAt"],
        viewAt: DateTime.parse(json["viewAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "favorite": favorite,
        "createdAt": createdAt,
        "viewAt": viewAt.toIso8601String(),
      };
}

class Paging {
  int page;
  int size;
  int total;
  int totalPages;

  Paging({
    required this.page,
    required this.size,
    required this.total,
    required this.totalPages,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        page: json["page"],
        size: json["size"],
        total: json["total"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "size": size,
        "total": total,
        "totalPages": totalPages,
      };
}
