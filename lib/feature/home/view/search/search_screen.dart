import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilo_health/feature/home/controller/home_controller.dart';

import 'package:kilo_health/component/text_widget.dart';
import 'package:kilo_health/feature/home/model/home_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  HomeController controller = Get.find();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: controller.categories.length,
        vsync: this); // Adjust length based on the number of tabs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search, article, information...",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 32, // Customize the color if needed
              ),
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
                width: 2.0,
                color: Colors.black), // Set the width and color of the line
            insets: EdgeInsets.zero, // Adjust the horizontal padding
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: controller.categories.map((category) {
            return Tab(
                child: SmallText(
              text: category.name,
              fontSize: 20,
            ));
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: controller.categories.map((category) {
          // var filteredPosts = controller.blogPosts
          //     .where((post) => post.id == category.order)
          //     .toList();

          return ArticleList(
            blogPosts: controller.blogPosts,
          );
        }).toList(),
      ),
    );
  }
}

class ArticleList extends GetView<HomeController> {
  final List<HomeData> blogPosts;
  const ArticleList({super.key, required this.blogPosts});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: blogPosts.length, // Replace with dynamic data
      itemBuilder: (context, index) {
        var post = blogPosts[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                      text: post.name,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    SmallText(
                      text: post.description,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    post.thumbnail,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
