import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instar_clone_with_getx/src/pages/search/search_focus.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //statflull로 바꾸고 initstate에서 그리드뷰를 틀을만듦
  List<List<int>> groupBox = [[], [], []]; //1번라인 2번라인 3번라인,,
  List<int> groupIndex = [0, 0, 0]; //역할 : size를 각 맞는위치를 찾는역할
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      var gi = groupIndex.indexOf(min<int>(groupIndex)!);
      var size = 1;
      if (gi != 1) {
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2; //긴 상자 랜덤하게
      }
      groupBox[gi].add(size);
      groupIndex[gi] += size; // size를 더해주는것
    }
  }

  Widget _appbar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Get.to(SearchFocus());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchFocus(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: const EdgeInsets.only(
                left: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(
                  0xffefefef,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(
                        0xff838383,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.location_pin),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          groupBox.length,
          (index) => Expanded(
            child: Column(
              children: List.generate(
                groupBox[index].length,
                (jndex) => Container(
                  height: Get.width *
                      0.33 * //이미지 화면3등분
                      groupBox[index][jndex], //3등분된 사이즈만큼 정사각형 쭉쌓임
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://taegon.kim/wp-content/uploads/2018/05/image-5.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ).toList(),
            ),
          ),
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold 안해도됨
      body: SafeArea(
        child: Column(
          //컬럼에서 앱바를 사용하는 이유? 앱바로 구성하면 고정되기때문(예제는 앱바가 같이 스크롤됨)
          children: [
            _appbar(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }
}
