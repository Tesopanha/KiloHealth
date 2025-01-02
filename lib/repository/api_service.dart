import 'package:dio/dio.dart';
import 'package:kilo_health/feature/home/model/categories_models.dart';
import 'package:kilo_health/feature/home/model/detail_model.dart';
import 'package:kilo_health/feature/home/model/home_model.dart';
import 'package:kilo_health/feature/home/model/info_model.dart';
import 'package:kilo_health/feature/notification/model/notification_model.dart';
import 'package:kilo_health/repository/api_client.dart';

class ApiService {
  final Dio _dio = Dio();

  final ApiClient _apiClient = ApiClient();

  Future<CategoryModels> fetchCategories() async {
    try {
      String url = _apiClient.getFullUrl(Endpoint().category);

      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        return CategoryModels.fromJson(response.data);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e'); // Log the error
      rethrow;
    }
  }

  Future<HomeModel> fetchBlog({int? categoryId, int? page}) async {
    try {
      String url = _apiClient.getFullUrl(Endpoint().blog);

      Map<String, dynamic> queryParameters = {};

      if (categoryId != null) queryParameters['category'] = categoryId;
      if (page != null) queryParameters['page'] = page;

      final response = await _dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        return HomeModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load blog');
      }
    } catch (e) {
      throw Exception('Failed to load blog: $e');
    }
  }

  Future<InfoModel> fetchInfo() async {
    try {
      String url = _apiClient.getFullUrl(Endpoint().info);

      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return InfoModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load info');
      }
    } catch (e) {
      print('Error fetching info: $e'); // Log the error
      rethrow;
    }
  }

  Future<DetailModel> fetchDetail(int id) async {
    try {
      String url = _apiClient.getFullUrl('${Endpoint().detail}/$id');

      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return DetailModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load detail');
      }
    } catch (e) {
      print('Error fetching detail: $e'); // Log the error
      rethrow;
    }
  }

  Future<NotificationModel> fetchNotification() async {
    try {
      // Build the full URL for the favorite endpoint
      String url = _apiClient.getFullUrl(Endpoint().notification);

      Map<String, String> headers = {
        'X-User-ID':
            '669e142544e1c41ced9a737f', // Ensure you pass the correct user ID
      };
      // Make the GET request with headers
      Response response = await _dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return NotificationModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load Notification - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Unknown Error fetching Notification: $e');
      rethrow; // Re-throw the exception to be handled elsewhere
    }
  }
}
