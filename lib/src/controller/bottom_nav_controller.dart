import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instar_clone_with_getx/src/components/message_popup.dart';
import 'package:instar_clone_with_getx/src/pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  GlobalKey<NavigatorState> searchPageNavigationKey =
      GlobalKey<NavigatorState>();
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];
  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value]; //0번째1번째2번째~~
    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => Upload());
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          title: '시스템',
          message: '종료하시겠습니까?',
          okCallback: () {
            exit(0);
          },
          cancelCallback: Get.back,
        ),
      );

      return true;
    } else {
      var page = PageName.values[bottomHistory.last]; //지금현재 페이지 추출
      if (page == PageName.SEARCH) {
        //서치페이지라면
        var value = await searchPageNavigationKey.currentState!
            .maybePop(); //pop할게있는지 없는지
        if (value) return false;
      }
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);

      return false;
    }
  }
}
