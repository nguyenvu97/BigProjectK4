import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_4/Common/Text_Data.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class card_test extends StatefulWidget {
  const card_test({super.key});

  @override
  State<card_test> createState() => _card_testState();
}

List<String> img = ["assets/1.jpeg", "assets/2.jpeg", "assets/3.jpeg"];

class _card_testState extends State<card_test> {
  void _addItem() {
    setState(() {
      // Thêm mục mới vào danh sách
      img.add('Item ${img.length + 1}');
    });
  }

  void _removeItem(String item) {
    setState(() {
      // Xóa mục khỏi danh sách
      img.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:
            Text_Data(name: "Card", color: Colors.amber, size: 20, maxLine: 1),
      ),
      body: Column(
        children: [
          Container(
            height: media.height * 0.2,
            width: media.width * 1,
            child: ListView(
                key: ValueKey(img),
                scrollDirection: Axis.horizontal,
                children: img.map((item) {
                  return Column(
                    children: [
                      Container(
                        height: media.height * 0.1,
                        width: media.width * 1,
                        child: Card(
                          child: Image.asset(item),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _removeItem(item);
                          },
                          icon: Icon(Icons.remove))
                    ],
                  );
                }).toList()),
          ),
          Text(
            "Hotelsndhwahd",
            style: TextStyle(fontSize: 40),
          )
              .animate()
              .tint(color: Colors.amber, duration: Duration(seconds: 5))
              .then()
              .shakeX()
          ,
          Animate(
            
          )
        ],
      ),
    );
  }
}
