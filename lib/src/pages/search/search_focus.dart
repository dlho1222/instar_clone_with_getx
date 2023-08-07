import 'package:flutter/material.dart';
import 'package:instar_clone_with_getx/src/components/image_data.dart';
import 'package:instar_clone_with_getx/src/controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({super.key});

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
        length: 5, vsync: this); //this 사용하려면 with TickerProviderStateMixin
  }

  Widget _tabMenuOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        menu,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        width: Size.infinite.width,
        height: AppBar().preferredSize.height, //device의 앱바만큼 높이주는것
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffe4e4),
            ),
          ),
        ),
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          tabs: [
            _tabMenuOne('인기'),
            _tabMenuOne('계정'),
            _tabMenuOne('오디오'),
            _tabMenuOne('태그'),
            _tabMenuOne('장소'),
          ],
        ),
      ), //50이면 만큼 떨어져서 컨텐츠~ //
    );
  }

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: const [
        Center(
          child: Text('인기페이지'),
        ),
        Center(
          child: Text('계정페이지'),
        ),
        Center(
          child: Text('오디오페이지'),
        ),
        Center(
          child: Text('태그페이지'),
        ),
        Center(
          child: Text('장소페이지'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //간격없애는옵션
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            BottomNavController.to.willPopAction();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.backBtnIcon),
          ),
        ),
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(
            right: 15,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffefefef)),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true, //간격좁히는옵션
            ),
          ),
        ),
        bottom: _tabMenu(),
      ),
      body: _body(),
    );
  }
}
