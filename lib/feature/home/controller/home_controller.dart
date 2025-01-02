import 'dart:async';

import 'package:get/get.dart';

import 'package:kilo_health/feature/home/model/categories_models.dart';
import 'package:kilo_health/feature/home/model/detail_model.dart';

import 'package:kilo_health/feature/home/model/home_model.dart';
import 'package:kilo_health/feature/home/model/info_model.dart';
import 'package:kilo_health/repository/api_service.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var opacity = 1.0.obs;
  Timer? timer;
  final ApiService _apiService = ApiService();

  var selectedCategory = 0.obs;
  var categories = <CategoryData>[].obs;
  var blogPosts = <HomeData>[].obs;
  var filterBlogPosts = <HomeData>[].obs;
  List<HomeData> result = <HomeData>[].obs;
  var detail = Rxn<DetailModel>();

  var infoData = Data(
    slides: [],
    name: '',
    description: '',
    facebook: '',
    telegram: '',
    tiktok: '',
    youtube: '',
    email: '',
    phoneNumbers: [],
  ).obs;

  var currentPage = 1.obs;
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
    //filterBlogPostsByCategory(selectedCategory.value);
  }

  void fetchInitialData() {
    fetchCategories();
    fetchBlogPosts();
    fetchInfo();
    initializeAutoSlide();
  }

  @override
  void onClose() {
    timer?.cancel(); // Clean up the timer when controller is disposed
    super.onClose();
  }

  Future<void> fetchBlogPosts({int? categoryId, int? page}) async {
    try {
      HomeModel homeModel =
          await _apiService.fetchBlog(categoryId: categoryId, page: page);
      blogPosts.value = homeModel.data;
      filterBlogPosts.value = blogPosts;

      currentPage.value = homeModel.paging.page;
      totalPages.value = homeModel.paging.totalPages;
    } catch (e) {
      // Error handling is already managed in fetchBlogPosts
      print('Error fetching blog posts: $e');
    }
  }

  void goToNextPage() {
    if (currentPage.value < totalPages.value) {
      fetchBlogPosts(
          categoryId: selectedCategory.value, page: currentPage.value + 1);
    }
  }

  // Function to go to the previous page
  void goToPreviousPage() {
    if (currentPage.value > 1) {
      fetchBlogPosts(
          categoryId: selectedCategory.value, page: currentPage.value - 1);
    }
  }

  Future<void> fetchCategories() async {
    try {
      var categoryModels = await _apiService.fetchCategories();

      categories.value = categoryModels.data
        ..sort((a, b) => a.order.compareTo(b.order));
    } catch (e) {
      // Handle error
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchDetail(int id) async {
    try {
      DetailModel detailModel = await _apiService.fetchDetail(id);

      detail.value = detailModel;
    } catch (e) {
      // Handle error
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchInfo() async {
    try {
      InfoModel infoModel = await _apiService.fetchInfo();
      infoData.value = infoModel.data;
    } catch (e) {
      // Handle error
      print('Error fetching categories: $e');
    }
  }

  void setCategory(CategoryData category) {
    selectedCategory.value = category.order;
    fetchBlogPosts(categoryId: category.id);
    // filterBlogPostsByCategory(category.order);
  }

  // void filterBlogPostsByCategory(int categoryOrder) async {
  //   if (categoryOrder == 0) {
  //     filterBlogPosts.value = blogPosts;
  //   } else {}
  // }

  Future<void> startAutoSlide() async {
    if (infoData.value.slides.isEmpty) {
      print("No slides available");
      return; // Exit if there are no slides
    }

    if (opacity.value == 0.0) {
      // Change image once fade-out is complete
      await Future.delayed(const Duration(milliseconds: 500));
      currentIndex.value =
          (currentIndex.value + 1) % infoData.value.slides.length;
      // await Future.delayed(Duration(milliseconds: 500));
      opacity.value = 1.0; // Start fade-in
    }
  }

  void initializeAutoSlide() {
    Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      opacity.value = 0.0; // Start fade-out
      startAutoSlide();
    });
  }
}
