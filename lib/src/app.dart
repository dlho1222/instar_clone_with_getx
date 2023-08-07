import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instar_clone_with_getx/src/components/image_data.dart';
import 'package:instar_clone_with_getx/src/controller/bottom_nav_controller.dart';
import 'package:instar_clone_with_getx/src/pages/active_history.dart';
import 'package:instar_clone_with_getx/src/pages/home.dart';
import 'package:instar_clone_with_getx/src/pages/mypage.dart';
import 'package:instar_clone_with_getx/src/pages/srarch.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //백버튼 이벤트
      onWillPop: controller.willPopAction,
      //백버튼 이벤트
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            // 인덱스별로 화면처리
            index: controller.pageIndex.value,
            children: [
              const Home(),
              Navigator(
                  //bottomNav살리리면 중첩관리해줘야함
                  key: controller.searchPageNavigationKey,
                  onGenerateRoute: (routSetting) {
                    return MaterialPageRoute(
                      builder: (context) => const Search(),
                    );
                  }),
              Container(),
              const ActiveHistory(),
              const MyPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon), label: 'home'),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    width: 30,
                    height: 30,
                  ),
                  label: 'home'),
            ],
          ),
        ),
      ), // false -> 닫지않음
    );
  }
}
