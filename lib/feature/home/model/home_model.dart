class HomeModel {
  int status;
  String message;
  List<HomeData> data;
  Paging paging;

  HomeModel({
    required this.status,
    required this.message,
    required this.data,
    required this.paging,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        data:
            List<HomeData>.from(json["data"].map((x) => HomeData.fromJson(x))),
        paging: Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };
}

class HomeData {
  int id;
  Type type;
  String name;
  String description;
  String thumbnail;
  bool favorite;
  String createdAt;

  HomeData({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.favorite,
    required this.createdAt,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
        id: json["id"],
        type: typeValues.map[json["type"]]!,
        name: json["name"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        favorite: json["favorite"],
        createdAt: json["createdAt"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "favorite": favorite,
        "createdAt": createdAt,
      };
}

enum Type { BLOG }

final typeValues = EnumValues({"blog": Type.BLOG});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
