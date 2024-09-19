import 'package:flutter/material.dart';
import 'package:flutter_application_4/Common/Box_Container/New_Box.dart';
import 'package:flutter_application_4/Common/Text_Data.dart';
import 'package:flutter_application_4/Sevice_Api/Gex_Controller/Ticket_Getx.Controller.dart';
import 'package:get/get.dart';

class AdressAndTime extends StatefulWidget {
  AdressAndTime({super.key});

  @override
  State<AdressAndTime> createState() => _AdressAndTimeState();
}

class _AdressAndTimeState extends State<AdressAndTime> {
  Ticket_Getx_Controller ticket_controller = Get.put(Ticket_Getx_Controller());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white12, borderRadius: BorderRadius.circular(30)),
          height: media.height * 0.15,
          width: media.width * 0.3,
          child: Container(
              child: Column(
            children: [
              Container(
                  height: 50,
                  child: Text_Data(
                      name: "Điểm Đi",
                      color: Colors.black,
                      size: 20,
                      maxLine: 1)),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final item = ticket_controller.airpost1[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // Start = item.airportName;
                              });

                              Navigator.pop(
                                  context); // Đóng BottomSheet và trả về giá trị của chuyến bay
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: 30,
                                        child: Text(
                                          "${index}", // Hiển thị tên của chuyến bay
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      // Text(
                                      //   item.airportName, // Hiển thị tên của chuyến bay
                                      //   style: TextStyle(
                                      //     fontSize: 30,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   "( ${item.location}) ", // Hiển thị tên của chuyến bay
                                      //   style: TextStyle(
                                      //     fontSize: 30,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: ticket_controller.airpost1.length,
                      );
                    },
                  );
                },
                child: Center(
                    child: Text_Data(
                        name: ticket_controller.start.isNotEmpty
                            ? ticket_controller.start.value
                            : "+",
                        color: Colors.black,
                        size: 30,
                        maxLine: 1)),
              )
            ],
          )),
        ),
        SizedBox(
          height: media.height * 0.07,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white12, borderRadius: BorderRadius.circular(30)),
          height: media.height * 0.15,
          width: media.width * 0.3,
          child: Container(
              child: Column(
            children: [
              Container(
                height: 50,
                child: Text_Data(
                    name: "Điểm Về", color: Colors.black, size: 20, maxLine: 1),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final item = ticket_controller.airpost1[index];
                          return GestureDetector(
                            onTap: () {
                              // bool? isValid =
                              //     CheckAddress(Start, item.airportName);
                              // if (isValid != null && isValid) {
                              //   setState(() {
                              //     End = item.airportName;
                              //   });
                              //   Navigator.pop(
                              //       context); // Đóng BottomSheet và trả về giá trị của chuyến bay
                              // }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: 30,
                                        child: Text(
                                          "${index}", // Hiển thị tên của chuyến bay
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      // Text(
                                      //   item.airportName, // Hiển thị tên của chuyến bay
                                      //   style: TextStyle(
                                      //     fontSize: 30,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   "( ${item.location}) ", // Hiển thị tên của chuyến bay
                                      //   style: TextStyle(
                                      //     fontSize: 30,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: ticket_controller.airpost1.length,
                      );
                    },
                  );
                },
                child: Center(
                    child: Text_Data(
                        name: ticket_controller.end.isNotEmpty
                            ? ticket_controller.end.value
                            : "+",
                        color: Colors.black,
                        size: 30,
                        maxLine: 1)),
              )
            ],
          )),
        ),
      ],
    );
  }
}
