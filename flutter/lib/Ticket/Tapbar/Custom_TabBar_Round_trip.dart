import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/Common/Box_Container/New_Box.dart';
import 'package:flutter_application_4/Ticket/FindbyTicket/Find_By_Ticket.dart';

import 'package:intl/intl.dart';

class CustomTabBar extends StatefulWidget {
  String catecory;
  bool isRouterCallback;
  String To;
  String departure;
  String dateTime;
  // List<FlightInfo> filghtInfoGo;
  // List<FlightInfo> filghtInfoCallBack;
  // final FindByGetBydateCallback findByGetBydateCallback;
  CustomTabBar(
      {Key? key,
      required this.catecory,
      required this.dateTime,
      // required this.filghtInfoCallBack,
      // required this.filghtInfoGo,
      required this.To,
      required this.departure,
      // required this.findByGetBydateCallback,
      required this.isRouterCallback})
      : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // void _callFindByGetBydate(String datetime, String? dateTimeCallback) {
  //   widget.findByGetBydateCallback(datetime, dateTimeCallback);
  // }

  int slectGo = 0;
  late List<bool> isSelectedGo;

  late List<bool> IsSelectCallback;

  List<String> filghtInfoGo = [];
  List<String> filghtInfoCallBack = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(_handleTabSelection);
    // widget.filghtInfoCallBack.clear();
    // widget.filghtInfoGo.clear();
    isSelectedGo = List.generate(10, (_) => false);
    IsSelectCallback = List.generate(10, (_) => false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //! add fightid in store
  String? selectedFlightId;
  // final storage = FlutterSecureStorage();
//! state vip and normal
  String ticket = "economy";
  String ticKetVip = "business";
  bool _isSelectTiket = true;
  bool _isSelectbusiness = true;

  // void _handleTabSelection() {
  //   setState(() {
  //     if (!widget.isRouterCallback) {
  //       if (_tabController.index == 0) {
  //         _isSelectTiket = true;
  //         isSelectedGo = List.generate(10, (_) => false);
  //         storage.write(key: "_isSelectTiket", value: "economy");
  //       } else {
  //         storage.write(key: "_isSelectTiket", value: "business");
  //         isSelectedGo = List.generate(10, (_) => false);
  //         _isSelectTiket = false;
  //       }
  //     } else {
  //       if (_tabController.index == 0) {
  //         _isSelectbusiness = true;
  //         IsSelectCallback = List.generate(10, (_) => false);
  //         storage.write(key: "__isSelectbusiness", value: "economy");
  //       } else {
  //         storage.write(key: "__isSelectbusiness", value: "business");
  //         IsSelectCallback = List.generate(10, (_) => false);
  //         _isSelectbusiness = false;
  //       }
  //     }
  //   });
  // }

  void showNoFlightsAvailable(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Flight Confirmation"),
          content: Text("There are no flights now?"),
          actions: [
            TextButton(
              onPressed: () async {
                // Đóng dialog
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FindByTicket()));
                // ...
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Container(
                    height: 100,
                    width: 150,
                    child: NewBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ticket,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ),
              Tab(
                child: Container(
                    height: 100,
                    width: 150,
                    child: NewBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ticKetVip,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
          InNormalAndVip(),
        ],
      ),
    );
  }

  // ! input text in container
  Container InNormalAndVip() {
    TextStyle textStyle = TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);
    if (!widget.isRouterCallback) {
      print(!widget.isRouterCallback);
      return Container(
        height: 350,
        width: 400,
        child: TabBarView(
          controller: _tabController,
          children: [
            //! Ticket
            FlightDetailsGo(textStyle),
            //! Ticket Vip
            FlightDetailsGo(textStyle),
          ],
        ),
      );
      // ! Add Data cua router call back
    } else {
      return Container(
        height: 350,
        width: 400,
        child: TabBarView(
          controller: _tabController,
          children: [
            //!!!!! Ticket
            // if(widget.filghtInfoCallBack.length >0)
            FlightDetialsCallback(textStyle),
            //!!!!! Ticket Vip
            FlightDetialsCallback(
              textStyle,
            ),
          ],
        ),
      );
    }
  }

  Container FlightDetailsGo(TextStyle textStyle) {
    List<bool> selectedStates = List.filled(slectGo, false);
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filghtInfoGo.length,
        itemBuilder: (context, index) {
          // FlightInfo
          String flight = filghtInfoGo[index];
          return Container(
            padding: EdgeInsets.all(8),
            height: 250,
            child: NewBox(
                child: Column(
              children: [
                Container(
                  height: 150,
                  width: 400,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   flight.departureTime.toString(),
                              //   maxLines: 1,
                              //   style: textStyle,
                              // ),
                              // Text(
                              //   "${flight.departureTime.hour.toString()}H${flight.departureTime.minute.toString()}M",
                              //   maxLines: 1,
                              //   style: textStyle,
                              // ),
                              Text(
                                widget.departure,
                                maxLines: 1,
                                style: textStyle,
                              ),
                            ]),
                      )),
                      Expanded(
                          child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text("---------------"),
                                    Icon(Icons.airplanemode_on)
                                  ],
                                ),
                              ),
                              // Container(
                              //   child: Text(flight.flightNumber),
                              // ),
                            ]),
                      )),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   flight.arrivalTime.toString(),
                              //   maxLines: 1,
                              //   style: textStyle,
                              // ),
                              // Text(
                              //   "${flight.arrivalTime.hour.toInt()}H${flight.arrivalTime.minute.toString()}M",
                              //   maxLines: 1,
                              //   style: textStyle,
                              // ),
                              Text(
                                widget.To,
                                maxLines: 1,
                                style: textStyle,
                              ),
                            ]),
                      )),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 400,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: [
                            Container(
                              child: Text(
                                ticket,
                                style: textStyle,
                              ),
                            ),
                            // Container(
                            //   child: Text(
                            //     _isSelectTiket ?? true
                            //         ? flight.economyFlexiblePrice.toString()
                            //         : flight.businessFlexiblePrice.toString(),
                            //     style: textStyle,
                            //   ),
                            // ),
                          ]),
                        ),
                        // Container(
                        //   height: 50,
                        //   child: Text(
                        //     _isSelectTiket ?? true
                        //         ? "Number of seats left :${flight.remainingEconomySeats.toString()}"
                        //         : "Number of seats left :${flight.remainingBusinessSeats.toString()}",
                        //     style: textStyle,
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // for (int i = 0;
                              //     i < widget.filghtInfoGo.length;
                              //     i++) {
                              //   isSelectedGo[i] = false;
                              // }
                              // if (isSelectedGo[index] = true) {
                              //   selectedFlightId = widget
                              //       .filghtInfoGo[index].flightId
                              //       .toString();
                              //   // print("selectedFlightId ${selectedFlightId}");

                              //   FlightInfoStore flightInfo = FlightInfoStore(
                              //       flightId: selectedFlightId!,
                              //       flightNumber:
                              //           widget.filghtInfoGo[index].flightNumber,
                              //       economyFlexiblePrice: widget
                              //           .filghtInfoGo[index]
                              //           .economyFlexiblePrice,
                              //       businessFlexiblePrice: widget
                              //           .filghtInfoGo[index]
                              //           .businessFlexiblePrice,
                              //       economySeats: widget.filghtInfoGo[index]
                              //           .aircraft.economySeats,
                              //       businessSeats: widget.filghtInfoGo[index]
                              //           .aircraft.businessSeats,
                              //       arrivalTime:
                              //           widget.filghtInfoGo[index].arrivalTime,
                              //       departureTime: widget
                              //           .filghtInfoGo[index].departureTime);

                              //   String flightInfoJson =
                              //       jsonEncode(flightInfo.toJson());
                              //   storage.write(
                              //       key: "fightGo", value: flightInfoJson);
                              // }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: isSelectedGo[index]
                                      ? Colors.blue
                                      : Colors.transparent,
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Choose",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                )
              ],
            )),
          );
        },
      ),
    );
  }

  Container FlightDetialsCallback(TextStyle textStyle) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filghtInfoCallBack.length,
        itemBuilder: (context, index) {
          // FlightInfo
          String flight = filghtInfoCallBack[index];
          return Container(
            padding: EdgeInsets.all(8),
            height: 250,
            child: NewBox(
                child: Column(
              children: [
                Container(
                  height: 150,
                  width: 400,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   flight.arrivalTime.toString(),
                              //   maxLines: 1,
                              //   style: textStyle,
                              // ),
                              // Text(
                              //   "${flight.departureTime.hour.toString()}H${flight.departureTime.minute.toString()}M",
                              //   maxLines: 1,
                              //   style: textStyle,
                              // ),
                              Text(
                                widget.To,
                                maxLines: 1,
                                style: textStyle,
                              ),
                            ]),
                      )),
                      Expanded(
                          child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text("-------------"),
                                    Icon(Icons.airplanemode_on)
                                  ],
                                ),
                              ),
                              // Container(
                              //   child: Text(flight.flightNumber),
                              // ),
                            ]),
                      )),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   flight.arrivalTime.toString(),
                              //   maxLines: 1,
                              //   style: textStyle,
                              // ),
                              // Text(
                              //   "${flight.arrivalTime.hour.toInt()}H${flight.arrivalTime.minute.toInt()}M",
                              //   maxLines: 1,
                              //   style: textStyle,
                              // ),
                              Text(
                                widget.departure,
                                maxLines: 1,
                                style: textStyle,
                              ),
                            ]),
                      )),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 400,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: [
                            Container(
                              child: Text(
                                ticket,
                                style: textStyle,
                              ),
                            ),
                            // Container(
                            //   child: Text(
                            //     _isSelectbusiness ?? true
                            //         ? flight.economyFlexiblePrice.toString()
                            //         : flight.businessFlexiblePrice.toString(),
                            //     style: textStyle,
                            //   ),
                            // ),
                          ]),
                        ),
                        // Container(
                        //   height: 50,
                        //   child: Text(
                        //     _isSelectbusiness ?? true
                        //         ? "Number of seats left :${flight.remainingEconomySeats.toString()}"
                        //         : "Number of seats left :${flight.remainingBusinessSeats.toString()}",
                        //     style: textStyle,
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // for (int i = 0;
                              //     i < widget.filghtInfoCallBack.length;
                              //     i++) {
                              //   IsSelectCallback[i] = false;
                              // }
                              // if (IsSelectCallback[index] = true) {
                              //   selectedFlightId = widget
                              //       .filghtInfoCallBack[index].flightId
                              //       .toString();
                              //   print("selectedFlightId ${selectedFlightId}");
                              //   FlightInfoStore flightInfo = FlightInfoStore(
                              //       flightId: selectedFlightId!,
                              //       flightNumber: widget
                              //           .filghtInfoCallBack[index].flightNumber,
                              //       economyFlexiblePrice: widget
                              //           .filghtInfoCallBack[index]
                              //           .economyFlexiblePrice,
                              //       businessFlexiblePrice: widget
                              //           .filghtInfoCallBack[index]
                              //           .businessFlexiblePrice,
                              //       economySeats: widget
                              //           .filghtInfoCallBack[index]
                              //           .aircraft
                              //           .economySeats,
                              //       businessSeats: widget
                              //           .filghtInfoCallBack[index]
                              //           .aircraft
                              //           .businessSeats,
                              //       arrivalTime: widget
                              //           .filghtInfoCallBack[index].arrivalTime,
                              //       departureTime: widget
                              //           .filghtInfoCallBack[index]
                              //           .departureTime);

                              //   String flightInfoJson =
                              //       jsonEncode(flightInfo.toJson());
                              //   storage.write(
                              //       key: "fightCallback",
                              //       value: flightInfoJson);
                              // }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: IsSelectCallback[index]
                                      ? Colors.blue
                                      : Colors.transparent,
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Choose",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                )
              ],
            )),
          );
        },
      ),
    );
  }
//! add flight datetime and infomation flight
}
