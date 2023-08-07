import 'package:get/get.dart';
import 'package:instar_clone_with_getx/src/models/post.dart';
import 'package:instar_clone_with_getx/src/repository/post_repository.dart';

class HomeController extends GetxController {
  RxList<Post> postList = <Post>[].obs;
  @override
  void onInit() {
    super.onInit();
    _loadFeedList();
  }

  void _loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.addAll(feedList);
  }
}
