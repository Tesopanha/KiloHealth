class DetailModel {
  int status;
  String message;
  DetailData data;

  DetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        status: json["status"],
        message: json["message"],
        data: DetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class DetailData {
  int id;
  String type;
  String name;
  String description;
  String content;
  String thumbnail;
  int views;
  String status;
  bool favorite;
  String createdAt;
  List<Category> categories;
  List<Tag> tags;

  DetailData({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.content,
    required this.thumbnail,
    required this.views,
    required this.status,
    required this.favorite,
    required this.createdAt,
    required this.categories,
    required this.tags,
  });

  factory DetailData.fromJson(Map<String, dynamic> json) => DetailData(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        description: json["description"],
        content: json["content"],
        thumbnail: json["thumbnail"],
        views: json["views"],
        status: json["status"],
        favorite: json["favorite"],
        createdAt: json["createdAt"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "description": description,
        "content": content,
        "thumbnail": thumbnail,
        "views": views,
        "status": status,
        "favorite": favorite,
        "createdAt": createdAt,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String name;
  String icon;
  int order;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.order,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "order": order,
      };
}

class Tag {
  int id;
  String name;

  Tag({
    required this.id,
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
