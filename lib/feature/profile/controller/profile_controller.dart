import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  String getFormat(String savedAt) {
    DateTime dateTime = DateTime.parse(savedAt);

    // Format it to the desired format: dd/MM/yy - h:m
    DateFormat formatter = DateFormat('dd/MM/yy - H:m');
    String formattedDate =
        formatter.format(dateTime.toLocal()); // Convert to local time if needed
    return formattedDate;
  }
}
