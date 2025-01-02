import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilo_health/feature/connection/connectivity_controller.dart';

import 'package:kilo_health/feature/home/controller/home_controller.dart';

import 'package:kilo_health/feature/home/model/home_model.dart';
import 'package:kilo_health/route/route.dart';

import 'package:kilo_health/component/text_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityController = Get.find<ConnectivityController>();
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/icons/image2.png',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.blue,
                size: 40,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (!connectivityController.isConnected.value) {
            Get.snackbar("No Internet", "Please check your connection");
            return;
          }
          await connectivityController.refreshData();
        },
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              _searchButton(context),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => SizedBox(
                    height: 170,
                    child: controller.infoData.value.slides.isNotEmpty
                        ? fadeInImage(
                            context,
                            controller.infoData.value
                                .slides[controller.currentIndex.value],
                            controller.opacity.value)
                        : const Center(
                            child:
                                CircularProgressIndicator())), // Show loading indicator if slides are empty
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: BigText(
                  text: "Categories",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 80,
                child: _buildCategoryList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    _buildGridItems(),
                    _buildPageButton(),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  Widget _searchButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoute.search),
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        height: 50,
        width: double.infinity,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallText(
              text: "Search",
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
            Icon(
              Icons.search,
              size: 32,
              color: Colors.grey.shade600,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.separated(
          padding: const EdgeInsets.only(left: 8, right: 8),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 15),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            var category = controller.categories[index];
            bool isSelected =
                controller.selectedCategory.value == category.order;

            return InkWell(
              onTap: () {
                controller.setCategory(category);
              },
              child: Container(
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1),
                  color: isSelected ? Colors.blue : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      category.icon!,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        // Return a placeholder image when there's an error loading the network image
                        return const Icon(Icons
                            .error); // Replace with your placeholder image path
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SmallText(
                      text: category.name,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  Widget _buildGridItems() {
    return Obx(
      () => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 180,
        ),
        itemCount: controller.filterBlogPosts.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var detail = controller.filterBlogPosts[index];
          return _buildGridItem(detail);
        },
      ),
    );
  }

  Widget _buildGridItem(HomeData detail) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.detail, arguments: {'id': detail.id});
      },
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(detail.thumbnail), fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            Positioned(
                top: -8,
                right: -8,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.lightBlue.shade200,
                      size: 20,
                    )))
          ]),
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: BigText(
                    text: detail.name,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: SmallText(
                    text: detail.description,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageButton() {
    return Obx(() {
      int totalPages = controller.totalPages.value;
      int currentPage = controller.currentPage.value;

      List<int> pagesToDisplay = _getPagesToDisplay(currentPage, totalPages);

      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left Arrow
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: currentPage > 1
                  ? () {
                      controller.fetchBlogPosts(
                          page: currentPage - 1,
                          categoryId: controller.selectedCategory.value);
                    }
                  : null, // Disable if on first page
            ),

            // Page Numbers
            ...pagesToDisplay.map((page) {
              if (page == -1) {
                // Display dots `...`
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text("...", style: TextStyle(fontSize: 20)),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.fetchBlogPosts(
                          page: page,
                          categoryId: controller.selectedCategory.value);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            8), // Make them squares instead of circles
                        color: currentPage == page
                            ? Colors.blue
                            : Colors.transparent, // Highlight current page
                        border: Border.all(
                          color:
                              currentPage == page ? Colors.blue : Colors.grey,
                          width: 3,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        page.toString(),
                        style: TextStyle(
                          color:
                              currentPage == page ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),

            // Right Arrow
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: currentPage < totalPages
                  ? () {
                      controller.fetchBlogPosts(
                          page: currentPage + 1,
                          categoryId: controller.selectedCategory.value);
                    }
                  : null, // Disable if on last page
            ),
          ],
        ),
      );
    });
  }

// Helper function to get pages to display with dots
  List<int> _getPagesToDisplay(int currentPage, int totalPages) {
    List<int> pages = [];

    if (totalPages <= 5) {
      // If there are less than 6 total pages, show them all
      for (int i = 1; i <= totalPages; i++) {
        pages.add(i);
      }
    } else {
      // Always show first and last page
      pages.add(1);

      if (currentPage > 3) {
        // Add dots if needed
        pages.add(-1); // Using -1 to represent "..."
      }

      // Show up to 2 pages before and after the current page
      int start = max(2, currentPage);
      int end = min(totalPages - 1, currentPage + 1);

      for (int i = start; i <= end; i++) {
        pages.add(i);
      }

      if (currentPage < totalPages - 2) {
        // Add dots if needed
        pages.add(-1); // Using -1 to represent "..."
      }

      // Always show last page
      pages.add(totalPages);
    }

    return pages;
  }

  Widget fadeInImage(BuildContext context, String imagePath, double opacity,
      {Duration duration = const Duration(milliseconds: 500)}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedOpacity(
          duration: duration,
          opacity: opacity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imagePath, fit: BoxFit.cover, errorBuilder:
                (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              // This is where you handle errors and provide a default image
              return Image.asset(
                'assets/images/default.png', // Your default/fallback image
              );
            }),
          )),
    );
  }
}
