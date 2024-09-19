import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/Common/Box_Container/New_Box.dart';

class Customer_TapBar_One_Way extends StatefulWidget {
  String catecory;
  bool isRouterCallback;
  String To;
  String departure;
  String dateTime;
  // List<FlightInfo> filghtInfoGo;

  Customer_TapBar_One_Way(
      {Key? key,
      required this.catecory,
      required this.dateTime,
      // required this.filghtInfoGo,
      required this.To,
      required this.departure,
      required this.isRouterCallback})
      : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

GlobalKey<ScaffoldState> sideMenuScaffoldKey = GlobalKey<ScaffoldState>();

class _CustomTabBarState extends State<Customer_TapBar_One_Way>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late List<bool> isSelectedGo;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(_handleTabSelection);
    // widget.filghtInfoGo.clear();
    isSelectedGo = List.generate(10, (_) => false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //! state vip and normal

  String ticket = "economy";
  String ticKetVip = "business";
  bool _isSelectTiket = true;

  List<String> filghtInfoGo = [];
  // final storage = FlutterSecureStorage();

  // void _handleTabSelection() {
  //   setState(() {
  //     if (_tabController.index == 0) {
  //       storage.delete(key: "_isSelectTiket");
  //       _isSelectTiket = true;
  //       print(_isSelectTiket);
  //       isSelectedGo = List.generate(10, (_) => false);
  //       storage.write(key: "_isSelectTiket", value: "economy");
  //     } else {
  //       storage.delete(key: "_isSelectTiket");
  //       print(_isSelectTiket);
  //       isSelectedGo = List.generate(10, (_) => false);
  //       _isSelectTiket = false;
  //       storage.write(key: "_isSelectTiket", value: "business");
  //     }
  //   });
  // }

  String? selectedFlightId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
      ),
    );
  }

  Container InNormalAndVip() {
    TextStyle textStyle = TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);

    return Container(
      height: 350,
      width: 400,
      child: TabBarView(
        controller: _tabController,
        children: [
          // Ticket
          FlightDetailsGo1(textStyle),
          // Ticket Vip
          FlightDetailsGo1(textStyle),
        ],
      ),
    );
  }

  //! add flight datetime and infomation flight
  Container FlightDetailsGo1(TextStyle textStyle) {
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
}
