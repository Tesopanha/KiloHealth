class ApiClient {
  final String baseUrl = 'https://dev-api.kiloit.com/';

  String getFullUrl(String endpoint) {
    return baseUrl.endsWith('/') ? '$baseUrl$endpoint' : '$baseUrl/$endpoint';
    // return '$baseUrl/$endpoint';
  }
}

class Endpoint {
  final String category = 'front/blog/api/v1/categories';
  final String blog = 'front/blog/api/v1/posts/blog';
  final String info = 'front/blog/api/v1/info';
  final String detail = 'front/blog/api/v1/posts/blog';
  final String favorite = 'front/blog/api/v1/favorites';
  final String notification = 'front/blog/api/v1/histories';
  final String search = 'front/blog/api/v1/posts/search';
}
