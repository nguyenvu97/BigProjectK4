import 'package:flutter/material.dart';

import 'package:get/get.dart';

class Ticket_Getx_Controller extends GetxController {
  /**
   *  find_by_ticket
   * 
   */
  RxList<String> airpost1 = <String>[].obs;

  var selectFindBy = "Round_trip".obs;
  final Map<int, String> userType = {
    0: "Trẻ Em",
    1: "Người Lớn",
  }.obs;
  var isChecked = false.obs;
  var customer = 1.obs;
  var children = 0.obs;
  var isSelectFindBy = true.obs;
  var start = "".obs;
  var end = "".obs;
  Rx<DateTime?> timeGo = Rx<DateTime?>(null);
  Rx<DateTime?> timeCallBack = Rx<DateTime?>(null);
  var dateTime = DateTime.now().obs;
  var notification = "Notification".obs;

  void updateUserType(int key) {
    if (key == 1) {
      customer++;
      return;
    } else {
      children += 1;
      return;
    }
  }

  //! sreach list Datetime for herder

  void removeUserType(int key, BuildContext context) {
    if (key == 1) {
      customer--;
      if (customer < 1) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(notification.value),
            content: Text('The number of customers is less than zero'),
          ),
        );
        customer = customer + 1;
        return;
      }
    } else {
      children--;
      return;
    }
  }

  void swapItems() {
    String swap = start.value;
    start = end;
    end.value = swap;
  }

  bool? CheckAddress(String start, String end, BuildContext context) {
    if (start.contains(end)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(notification.value),
          content: Text(
              'The origin address and destination address cannot be the same. Please select again.'),
        ),
      );
      return null;
    } else {
      return true;
    }
  }

  DateTime checkTime(BuildContext context) {
    if (timeGo.value != null && timeCallBack.value != null) {
      if (timeGo.value!.isAfter(timeCallBack.value!)) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(notification.value),
            content: Text(
                'The return date cannot be before the departure date. Please select again.'),
          ),
        );
        throw Exception("loi me roi");
      }
    }
    return timeCallBack.value!;
  }

  void onCheckboxChanged(bool? value) {
    isChecked.value =
        value ?? true; // Update the state when checkbox value changes
  }

  //!
}
