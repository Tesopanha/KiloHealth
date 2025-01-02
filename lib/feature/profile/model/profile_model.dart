class ProfileModel {
  final String name;
  final String heartRate;
  final String calories;
  final String weight;
  final String img;
  ProfileModel(
      {required this.name,
      required this.heartRate,
      required this.calories,
      required this.weight,
      required this.img});

  Map<String, dynamic> toMap() => {
        'name': name,
        'heartRate': heartRate,
        'calories': calories,
        'weights': weight,
        'img': img,
      };

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      heartRate: json['heartRate'],
      calories: json['calories'],
      weight: json['weights'],
      img: json['img'],
    );
  }

  static List<ProfileModel> listIndividual = [
    ProfileModel(
        name: "panha",
        heartRate: "215",
        calories: "756",
        weight: "103",
        img: 'assets/icons/image2.png')
  ];

  static List<Map<String, dynamic>> infoList = [
    {"Heart Rate": 'assets/icons/Heartbeat.png'},
    {"Calories": 'assets/icons/Fire.png'},
    {"weight": 'assets/icons/Vector.png'},
  ];

  static List<Map<String, dynamic>> feature = [
    {
      'icon': 'assets/icons/heart.png',
      'title': 'My Saved',
    },
    {
      'icon': 'assets/icons/appoinment.png',
      'title': 'Appointment',
    },
    {
      'icon': 'assets/icons/payment.png',
      'title': 'Payment Method',
    },
    {
      'icon': 'assets/icons/faq.png',
      'title': 'FAQs',
    },
    {
      'icon': 'assets/icons/logout.png',
      'title': 'Logout',
    },
  ];
}
