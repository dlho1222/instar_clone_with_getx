import 'package:flutter/material.dart';
import 'package:instar_clone_with_getx/src/components/avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String description;
  const UserCard({super.key, required this.userId, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            right: 15,
            bottom: 0,
            top: 0,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  AvatarWidget(
                    type: AvatarType.TYPE2,
                    thumbPath:
                        'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
                    size: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    userId,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Follow')),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
