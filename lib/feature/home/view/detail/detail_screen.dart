import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kilo_health/feature/home/controller/home_controller.dart';

import 'package:kilo_health/component/text_widget.dart';
import 'package:kilo_health/route/route.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final int detailId;
  final HomeController homeController = Get.find();
  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    detailId = args['id'] as int;
    homeController.fetchDetail(detailId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var detail = homeController.detail;
      if (detail.value == null) {
        return const Center(
            child: CircularProgressIndicator()); // Show loading indicator
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                size: 24, color: Colors.white),
          ),
          leadingWidth: 30,
          centerTitle: true,
          title: BigText(
            text: detail.value?.data.name ?? "",
            color: Colors.white,
            overflow: TextOverflow.fade,
            fontSize: 18,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_add,
                    size: 24, color: Colors.white)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, size: 24, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _buildImage(detail.value?.data.thumbnail ?? ''),
                ),
                const SizedBox(height: 16),
                BigText(
                    text: detail.value?.data.name ?? '',
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 16,
                ),
                HtmlWidget(
                  detail.value?.data.content ?? '',
                  textStyle: const TextStyle(fontSize: 18)
                      .merge(GoogleFonts.notoSansKhmer()),
                ),
                const SmallText(
                    text: "Share to Social Media",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                const SizedBox(height: 16),
                _buildShareButtons(),
                const SizedBox(height: 16),
                _buildRelatedPostsHeader(),
                const SizedBox(height: 6),
                SizedBox(height: 200, child: _buildRalatePost()),
              ],
            ),
          ]),
        ),
      );
    });
  }

  Widget _buildImage(String image) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildRalatePost() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemCount: homeController.filterBlogPosts.length,
      itemBuilder: (context, index) {
        var relatePost = homeController.filterBlogPosts[index];
        return InkWell(
          onTap: () {
            Future.delayed(const Duration(milliseconds: 300), () {
              Get.offAndToNamed(
                AppRoute.detail,
                arguments: {'id': relatePost.id},
              );
            });
          },
          child: SizedBox(
            child: Column(
              children: [
                Container(
                  height: 110,
                  width: 270,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(relatePost.thumbnail),
                        fit: BoxFit.cover),
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
                Container(
                  width: 270,
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
                          text: relatePost.name,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: SmallText(
                          text: relatePost.description,
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShareButtons() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Divider(
                color: Colors.lightBlueAccent.withOpacity(0.5), thickness: 1),
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.link, size: 32, color: Colors.grey),
            onPressed: () {
              // Add link sharing functionality here
            },
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.facebook, size: 32, color: Colors.blue),
            onPressed: () {
              // Add Facebook sharing functionality here
            },
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.telegram, size: 32, color: Colors.lightBlue),
            onPressed: () {
              // Add Telegram sharing functionality here
            },
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 40,
            child: Divider(
                color: Colors.lightBlueAccent.withOpacity(0.5), thickness: 1),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedPostsHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallText(
            text: "Related Posts", fontSize: 18, fontWeight: FontWeight.bold),
        Row(
          children: [
            Expanded(
              child: Divider(color: Colors.blue, thickness: 3),
            ),
            SizedBox(
              width: 300,
              child: Divider(color: Colors.black, thickness: 1),
            ),
          ],
        ),
      ],
    );
  }
}
