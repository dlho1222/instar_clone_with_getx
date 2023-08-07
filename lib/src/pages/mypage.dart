import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instar_clone_with_getx/src/components/avatar_widget.dart';
import 'package:instar_clone_with_getx/src/components/image_data.dart';
import 'package:instar_clone_with_getx/src/components/user_card.dart';
import 'package:instar_clone_with_getx/src/controller/mypage_controller.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({super.key});
  Widget _statisticsOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                AvatarWidget(
                  type: AvatarType.TYPE3,
                  thumbPath: controller.targetUser.value.thumbnail!,
                  size: 80,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: _statisticsOne('Post', 15)),
                      Expanded(child: _statisticsOne('Followers', 11)),
                      Expanded(child: _statisticsOne('Following', 3)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              controller.targetUser.value.description!,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 7,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: const Color(0xffdedede),
                ),
              ),
              child: const Text(
                'Edit profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: const Color(0xffdedede),
              ),
              color: const Color(0xffefefef),
            ),
            child: ImageData(
              IconsPath.addFriend,
            ),
          ),
        ],
      ),
    );
  }

  Widget _discoverPeople() {
    return Column(
      //컬럼을두는이유 /title이있기때문 Row는 양옆에 제목,버튼이있어서
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discover People',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            children: [
              ...List.generate(
                10,
                (index) => UserCard(
                  userId: '개남$index',
                  description: '개남e$index님이 팔로우합니다.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabMenu() {
    return TabBar(
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      controller: controller.tabController,
      tabs: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ImageData(
            IconsPath.gridViewOn,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ImageData(
            IconsPath.myTagImageOff,
          ),
        )
      ],
    );
  }

  Widget _tabView() {
    return GridView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //상위에 싱글차일드스크롤뷰가있어서 설정해줘서 스크롤링없애줘야함
      shrinkWrap: true,
      itemCount: 100,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //간격
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.grey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Obx(
          () => Text(
            controller.targetUser.value.nickname!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ImageData(
              IconsPath.uploadIcon,
              width: 50,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.menuIcon,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _information(),
            _menu(),
            _discoverPeople(),
            const SizedBox(
              height: 20,
            ),
            _tabMenu(),
            _tabView(),
          ],
        ),
      ),
    );
  }
}
