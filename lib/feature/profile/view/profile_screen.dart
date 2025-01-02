import 'package:flutter/material.dart';
import 'package:kilo_health/feature/profile/model/profile_model.dart';
import 'package:kilo_health/component/text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                maxRadius: 50,
                child: Image.asset(ProfileModel.listIndividual[0].img),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: BigText(
                text: ProfileModel.listIndividual[0].name,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: _inforWidget(),
            ),
            _featureWidget(),
          ],
        ),
      )),
    );
  }

  Widget _inforWidget() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: ProfileModel.infoList.length,
        separatorBuilder: (context, index) => SizedBox(
              width: 10,
              child: VerticalDivider(
                indent: 40,
                endIndent: 40,
                thickness: 1,
                color: Colors.blue.shade200,
              ),
            ),
        itemBuilder: (context, index) {
          var detail = ProfileModel.infoList[index];
          var iconKey = detail.keys.first;
          var iconValue = detail[iconKey];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                Image.asset(
                  iconValue,
                  height: 50,
                  width: 50,
                ),
                SmallText(
                  text: iconKey,
                  color: Colors.blue.shade600,
                ),
                BigText(
                  text: "215",
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade600,
                )
              ],
            ),
          );
        });
  }

  Widget _featureWidget() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ProfileModel.feature.length,
      itemBuilder: (context, index) {
        return _buildFeatureListItem(
          iconPath: ProfileModel.feature[index]['icon'],
          title: ProfileModel.feature[index]['title'],
        );
      },
    );
  }

  Widget _buildFeatureListItem({
    required String iconPath,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            iconPath,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        title: SmallText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
