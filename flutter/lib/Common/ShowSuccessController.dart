import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Show_Dia_log extends GetxController {
  void showSuccessDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text("Xác Nhận"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void confirm_Dialog(BuildContext context, String content, Widget widget) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông Báo"),
          content: Text(content),
          actions: [
            Row(
              children: [
                TextButton(
                  child: Text("Hủy"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Xác Nhận"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => widget));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
