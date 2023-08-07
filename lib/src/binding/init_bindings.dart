import 'package:get/get.dart';
import 'package:instar_clone_with_getx/src/controller/bottom_nav_controller.dart';

import '../controller/auth_controller.dart';
import '../controller/mypage_controller.dart';
import '../controller/upload_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinding() {
    Get.put(MyPageController(), permanent: true);
    Get.put(UploadController(), permanent: true);
  }
}
