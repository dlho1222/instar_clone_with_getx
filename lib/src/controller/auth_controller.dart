import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instar_clone_with_getx/src/binding/init_bindings.dart';
import 'package:instar_clone_with_getx/src/models/instagram_user.dart';
import 'package:instar_clone_with_getx/src/repository/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  Rx<IUser> user = IUser().obs;
  Future<IUser?> loginUser(String uid) async {
    //DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    if (userData != null) {
      user(userData);
      InitBinding.additionalBinding();
    }
    return userData;
  }

  void signup(IUser signupUser, XFile? thumbnail) async {
    if (thumbnail == null) {
      _submitSignup(signupUser);
    } else {
      var task = uploadXFile(thumbnail,
          '${signupUser.uid}/profile.jpg${thumbnail.path.split('.').last}');
      task.snapshotEvents.listen(
        (event) async {
          print(event.bytesTransferred);
          if (event.bytesTransferred == event.totalBytes &&
              event.state == TaskState.success) {
            var downloadUrl = await event.ref.getDownloadURL();
            var updatedUserData = signupUser.copyWith(thumbnail: downloadUrl);
            _submitSignup(updatedUserData);
          }
        },
      );
    }
  }

  UploadTask uploadXFile(XFile file, String filename) {
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});
    return ref.putFile(f, metadata);

    //users/{uid}/profile.jpg or profile.png 이런식으로 저장됨
  }

  void _submitSignup(IUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) {
      loginUser(signupUser.uid!);
    }
  }
}
