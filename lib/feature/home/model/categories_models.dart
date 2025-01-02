class CategoryModels {
  int status;
  String message;
  List<CategoryData> data;

  CategoryModels({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryModels.fromJson(Map<String, dynamic> json) => CategoryModels(
        status: json["status"],
        message: json["message"],
        data: List<CategoryData>.from(
            json["data"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CategoryData {
  int id;
  String name;
  String? icon;
  int order;

  CategoryData({
    required this.id,
    required this.name,
    required this.icon,
    required this.order,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
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
