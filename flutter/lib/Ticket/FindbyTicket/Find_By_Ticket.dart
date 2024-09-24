import 'package:flutter/material.dart';

import 'package:flutter_application_4/Common/Box_Container/New_Box.dart';
import 'package:flutter_application_4/Common/Text_Data.dart';
import 'package:flutter_application_4/Sevice_Api/Gex_Controller/Ariport_Getx_Controller.dart';
import 'package:flutter_application_4/Sevice_Api/Gex_Controller/Ticket_Getx.Controller.dart';
import 'package:flutter_application_4/Ticket/FindbyTicket/Adress_Time.dart';
import 'package:flutter_application_4/Ticket/FindbyTicket/Choose_Customer_Child.dart';
import 'package:flutter_application_4/Ticket/FindbyTicket/Show_Menu.dart';
import 'package:flutter_application_4/Ticket/FindbyTicket/TimeGo_CallBack.dart';
import 'package:flutter_application_4/home/Home_page.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class FindByTicket extends StatefulWidget {
  const FindByTicket({super.key});

  @override
  State<FindByTicket> createState() => _FindByTicketState();
}

class _FindByTicketState extends State<FindByTicket>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // List<Airport> airpost1 = [];
  List<String> airpost1 = [];

  // Future<void> sreachAirport() async {
  //   List<Airport>? airpost2 =
  //       await Airport_Service().GetallSreachFind_by_ticket();
  //   print(airpost2);
  //   if (airpost2 != null) {
  //     setState(() {
  //       airpost1 = airpost2;
  //     });
  //   } else {
  //     print("loi he thong");
  //   }
  // }

  Ticket_Getx_Controller ticket_controller = Get.put(Ticket_Getx_Controller());

  void handleTabSelection() {
    if (_tabController.index == 0) {
      ticket_controller.isSelectFindBy.value = true;
      print(ticket_controller.isSelectFindBy.value);
    } else if (_tabController.index == 1) {
      ticket_controller.isSelectFindBy.value = false;
      print(ticket_controller.isSelectFindBy.value);
    }
  }

  @override
  void initState() {
    super.initState();
    // ticket_controller.sreachAirport();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/homepage.jpg"),
                      fit: BoxFit.cover)),
            )),
            Obx(
              () => Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text_Data(
                                name: 'Tìm Kiếm Chuyến Bay',
                                color: Colors.white,
                                size: 25,
                                maxLine: 1),
                            SizedBox(width: 50), // To balance the row
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(30)),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.white,
                            indicatorColor: Colors.white,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(
                                child: Center(
                                  child: Text_Data(
                                      name: 'Khứ Hồi',
                                      color: null,
                                      size: 20,
                                      maxLine: 1),
                                ),
                              ),
                              Tab(
                                child: Center(
                                  child: Text_Data(
                                      name: 'Một Chiều',
                                      color: null,
                                      size: 20,
                                      maxLine: 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      // page 1
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AdressAndTime(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          ariport_controller.swapItems();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          height: 70,
                                          width: 70,
                                          child: Container(
                                            child: Icon(Icons.refresh),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  GoAndCallBack()
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Khách Hàng",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: media.width * 0.55,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "0${ticket_controller.customer.toString()}",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      ticket_controller
                                                                  .children >
                                                              0
                                                          ? "Người Lớn , 0${ticket_controller.children} Trẻ Em"
                                                          : "Người Lớn",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  child:
                                                      ChooseBigUserAndKiss()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      // page 2
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AdressAndTime(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          ariport_controller.swapItems();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          height: 70,
                                          width: 70,
                                          child: Container(
                                            child: Icon(Icons.refresh),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  GoAndCallBack()
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Khách Hàng",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: media.width * 0.55,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "0${ticket_controller.customer.toString()}",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      ticket_controller
                                                                  .children >
                                                              0
                                                          ? "Người Lớn , 0${ticket_controller.children} Trẻ Em"
                                                          : "Người Lớn",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  child:
                                                      ChooseBigUserAndKiss()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                            child: Checkbox(
                          value: ticket_controller.isChecked.value,
                          onChanged: (value) {
                            ticket_controller.onCheckboxChanged(value);
                          },
                        )),
                        Text_Data(
                            name: "Hiển Thị Loại Vé Loại Giá Được Phép Hoàn",
                            color: Colors.black,
                            size: 15,
                            maxLine: 1),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      String? number = ticket_controller.userType.entries
                          .firstWhere((entry) => entry.value == "Adult")
                          .key
                          .toString();

                      String? children = ticket_controller.userType.entries
                          .firstWhere((entry) => entry.value == "Children")
                          .key
                          .toString();
                      //! ?? round_trip
                      if (ticket_controller.isSelectFindBy.value ?? true) {
                        if (
                            // ticket_controller.start.isNotEmpty &&
                            //   ticket_controller.end.isNotEmpty &&
                            ticket_controller.timeGo != null &&
                                ticket_controller.timeCallBack != null) {
                          setState(() {
                            // final storage = FlutterSecureStorage();
                            // storage.write(key: "_isSelectTiket", value: "economy");
                            // storage.write(key: "__isSelectbusiness", value: "economy");
                          });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Chooseflight(
                          //               category: _isSelectFindBy,
                          //               adult: number,
                          //               customer: Customer,
                          //               children: Children,
                          //               TimeGo: TimeGo,
                          //               TimeCallBack: TimeCallBack,
                          //               childrenName: children,
                          //               Departurn: Start,
                          //               to: End,
                          //             )));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(ticket_controller.notification.value),
                              content:
                                  Text('Please enter your information for us'),
                            ),
                          );
                          Navigator.of(context);
                        }
                        //! ?? One Way
                      } else {
                        if (
                            // ticket_controller.start.isNotEmpty &&
                            //   ticket_controller.end.isNotEmpty &&
                            ticket_controller.timeGo != null) {
                          setState(() {
                            // final storage = FlutterSecureStorage();
                            // storage.write(key: "_isSelectTiket", value: "economy");
                            // storage.write(key: "__isSelectbusiness", value: "economy");
                          });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Chooseflight(
                          //               category: _isSelectFindBy,
                          //               adult: number,
                          //               customer: Customer,
                          //               children: Children,
                          //               TimeGo: TimeGo,
                          //               TimeCallBack: TimeCallBack,
                          //               childrenName: children,
                          //               Departurn: Start,
                          //               to: End,
                          //             )));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(ticket_controller.notification.value),
                              content:
                                  Text('Please enter your information for us'),
                            ),
                          );
                          Navigator.of(context);
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: media.width * 0.8,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 157, 157, 3),
                          borderRadius: BorderRadius.circular(30)),
                      height: media.height * 0.07,
                      child: Container(
                        child: Center(
                            child: Text_Data(
                                name: "Tìm Kiếm Chuyến Bay",
                                color: Colors.white,
                                size: 20,
                                maxLine: 1)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// OK
}
