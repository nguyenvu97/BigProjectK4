import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/Common/Box_Container/New_Box.dart';
import 'package:flutter_application_4/Common/ButtonNavigator.dart';
import 'package:flutter_application_4/Ticket/FindbyTicket/Find_By_Ticket.dart';
import 'package:flutter_application_4/Ticket/Tapbar/Custom_TabBar_Round_trip.dart';
import 'package:flutter_application_4/Ticket/Tapbar/Customer_TapBar_One_Way.dart';
import 'package:im_stepper/stepper.dart';

import 'package:intl/intl.dart';

class Chooseflight extends StatefulWidget {
  int customer;
  int children;
  String? childrenName;
  String? adult;
  bool category;
  String Departurn;
  String to;
  DateTime? TimeGo;
  DateTime? TimeCallBack;

  Chooseflight(
      {super.key,
      required this.adult,
      required this.customer,
      required this.Departurn,
      required this.to,
      required this.children,
      required this.category,
      required this.TimeGo,
      required this.TimeCallBack,
      required this.childrenName});

  @override
  State<Chooseflight> createState() => _ChooseflightState();
}

typedef void FindByGetBydateCallback(String datatime, String? dateTimeCallback);

class _ChooseflightState extends State<Chooseflight>
    with SingleTickerProviderStateMixin {
  int activeStep = 0;

  String selectedTimeGo = "";
  String selectedTimeCallBack = "";

  bool isRouterGoAndBack = false;
  bool _isRankUser = false;
  late TabController controller;

  // FindByTicket1 findByTicket1 = FindByTicket1();

  //! Sreach List data time flightData

  // FlightData? flightData;
  // findByTicket tickit = findByTicket();

  List<DateTime> futureDates = [];
  List<String> formattedFutureDates = [];

  // Future<void> listDateTime() async {
  //   // print(widget.category);
  //   FlightData? flightData1 = await findByTicket1.List_Date_have_Flights(
  //       widget.Departurn, widget.to, widget.category);

  //   if (flightData1 != null) {
  //     setState(() {
  //       flightData = flightData1;
  //     });
  //   }
  // }

// !findByGetBydate  data about timeGo And TimeCallback
  // SelectFlightRequest? selectFlightRequest;

  DateTime parseDate(String dateString) {
    List<String> dateParts = dateString.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    return DateTime(year, month, day);
  }

  String? choosefightCallback;

  //! check if user click choose date datetime figlt reterun ok
  // final storage = FlutterSecureStorage();

  //! getAll RankUserFor TokenDecode
  // List<Promotion> promotion = [];
  List<String> promotion = [];
  // Future<void> RankUserFor() async {
  //   try {
  //     List<Promotion>? promotion1 = await findByTicket1.rankUser();
  //     if (promotion1 != null) {
  //       setState(() {
  //         promotion = promotion1;
  //       });
  //       return;
  //     } else {
  //       print("loi he thong RankUserFor");
  //     }
  //   } catch (e) {
  //     print("loi RankUserFor line 97");
  //   }
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

  //!findByGetBydate
  // Future<void> findByGetBydate(
  //     String datatime, String? dateTimeCallback) async {
  //   DateTime timeGo = parseDate(datatime);
  //   DateTime? timeCallBack;
  //   if (dateTimeCallback != null) {
  //     timeCallBack =
  //         selectedTimeCallBack.isNotEmpty ? parseDate(dateTimeCallback) : null;
  //   }

  //   filghtInfoGo.clear();
  //   filghtInfoCallBack.clear();
  //   try {
  //     SelectFlightRequest? selectFlightRequest1 =
  //         await findByTicket1.Find_By_GetByDate(
  //             widget.Departurn,
  //             widget.to,
  //             timeGo,
  //             timeCallBack,
  //             widget.children,
  //             widget.customer,
  //             widget.category);
  //     print(selectFlightRequest1);
  //     if (selectFlightRequest1 != null) {
  //       setState(() {
  //         selectFlightRequest = selectFlightRequest1;
  //         filghtInfoGo.clear();
  //         filghtInfoCallBack.clear();
  //         print(selectFlightRequest);
  //       });
  //       return;
  //     } else {
  //       showNoFlightsAvailable(context);
  //       print("loi findByGetBydate ");
  //       return;
  //     }
  //   } catch (e) {
  //     print("findByGetBydate $e");
  //   }
  // }

  @override
  void initState() {
    // listDateTime();
    selectedTimeGo = DateFormat('dd/MM/yyyy').format(widget.TimeGo!);
    if (!isRouterGoAndBack && widget.TimeCallBack != null) {
      selectedTimeCallBack =
          DateFormat('dd/MM/yyyy').format(widget.TimeCallBack!);
    }
    filghtInfoGo.clear();
    filghtInfoCallBack.clear();
    // RankUserFor();
    // findByGetBydate(selectedTimeGo, selectedTimeCallBack);
    super.initState();
  }

// ! Infomatsion list Data fight
  // List<FlightInfo> filghtInfoGo = [];
  // List<FlightInfo> filghtInfoCallBack = [];
  List<String> filghtInfoGo = [];
  List<String> filghtInfoCallBack = [];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    // if (selectFlightRequest != null) {
    //   if (!isRouterGoAndBack) {
    //     for (FlightInfo flight in selectFlightRequest!.departureFlights) {
    //       filghtInfoGo.add(flight);
    //     }
    //   } else {
    //     for (FlightInfo flight1 in selectFlightRequest!.returnFlights) {
    //       filghtInfoCallBack.add(flight1);
    //     }
    //   }
    // }
    //!! check line 822 router go anh roter callback
    return Scaffold(
      // appBar: CustomAppBar(
      //   name: "Buy Airline Tickets",
      //   actions: [],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 70,
              child: NewBox(
                child: IconStepper(
                  stepColor: Colors.white,
                  lineLength: 20,
                  icons: [
                    Icon(
                      Icons.airplanemode_active,
                      size: 8,
                    ),
                    Icon(
                      Icons.person,
                      size: 8,
                    ),
                    // if (promotion != null && promotion.isNotEmpty)
                    //   Icon(
                    //     Icons.star,
                    //     size: 8,
                    //   ),
                    // Icon(
                    //   Icons.payment,
                    //   size: 8,
                    // ),
                  ],
                  activeStep: activeStep,
                  // onStepReached: (index) {
                  //   setState(() {
                  //     activeStep = index;
                  //   });
                  // },
                ),
              ),
            ),
            header(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(5),
            ),
            child: headerText(),
          ),
        ),
      ],
    );
  }

  // Returns the header text based on the activeStep.
  Widget headerText() {
    List<String> formattedFutureDates = [];

    // flightData?.departureFlights.forEach((flight) {
    //   DateTime departureDate = flight.date; // Assuming date is of type DateTime
    //   String formattedFutureDate =
    //       DateFormat('dd/MM/yyyy').format(departureDate);
    //   formattedFutureDates.add(formattedFutureDate);
    // });
    List<String> TimeCallBack1 = [];

    // flightData?.returnFlights.forEach((flight) {
    //   DateTime departureDate = flight.date; // Assuming date is of type DateTime
    //   String formattedFutureDate =
    //       DateFormat('dd/MM/yyyy').format(departureDate);
    //   TimeCallBack1.add(formattedFutureDate);
    // }
    // );
    //! roud_rip
    if (widget.category ?? true) {
      if (promotion.isNotEmpty) {
        if (activeStep == 1) {
          if (selectedTimeGo.isNotEmpty && isRouterGoAndBack ?? true) {
            return Container();
            // UserInfo(
            //   to: widget.to,
            //   go: widget.Departurn,
            //   isRouterGoAndBack: isRouterGoAndBack,
            //   adult: widget.adult,
            //   customer: widget.customer,
            //   children: widget.children,
            //   childrenName: widget.childrenName,
            //   promotion: promotion,
            //   onStepCompleted: () {
            //     if (mounted) {
            //       setState(() {
            //         activeStep = 2;
            //       });
            //     }
            //   },
            // );
          } else {
            setState(() {
              activeStep = 0;
            });
            return HeardFlightRoute(formattedFutureDates, TimeCallBack1);
          }
        } else if (activeStep == 2) {
          return Container();
          // Column(
          //   children: [
          //     Container(
          //         height: 650,
          //         child: RankUser(
          //           customer: widget.customer,
          //           children: widget.children,
          //           isRouterGoAndBack: isRouterGoAndBack,
          //           promotio: promotion,
          //           isRankUser: _isRankUser,
          //           onIsRouterCallbackChanged: (value) => setState(() {
          //             _isRankUser = value;
          //             print("_isRankUser + ${_isRankUser}");
          //           }),
          //           onStepCompleted: () {
          //             if (mounted) {
          //               setState(() {
          //                 activeStep = 3;
          //               });
          //             }
          //           },
          //         )),
          //   ],
          // );
        } else if (activeStep == 3) {
          return Container();
          // PaymentTicket(
          //   promotion: promotion,
          //   to: widget.to,
          //   go: widget.Departurn,
          //   childer: widget.children,
          //   customer: widget.customer,
          //   isRouterGoAndBack: isRouterGoAndBack,
          // );
        } else {
          return HeardFlightRoute(
            formattedFutureDates,
            TimeCallBack1,
          );
        }
      } else {
        if (activeStep == 1) {
          return Container();
          // UserInfo(
          //   promotion: promotion,
          //   to: widget.to,
          //   go: widget.Departurn,
          //   isRouterGoAndBack: isRouterGoAndBack,
          //   adult: widget.adult,
          //   customer: widget.customer,
          //   children: widget.children,
          //   childrenName: widget.childrenName,
          //   onStepCompleted: () {
          //     if (mounted) {a
          //       setState(() {
          //         activeStep = 2;
          //       });
          //     }
          //   },
          // );
        } else if (activeStep == 2) {
          return Container();
          // PaymentTicket(
          //   promotion: promotion,
          //   to: widget.to,
          //   go: widget.Departurn,
          //   childer: widget.children,
          //   customer: widget.customer,
          //   isRouterGoAndBack: isRouterGoAndBack,
          // );
        } else {
          return HeardFlightRoute(
            formattedFutureDates,
            TimeCallBack1,
          );
        }
      }

      //! ??????????????? Onw_Way
    } else {
      if (promotion.isNotEmpty &&
          widget.Departurn.isNotEmpty &&
          widget.to.isNotEmpty) {
        if (activeStep == 1) {
          if (selectedTimeGo.isNotEmpty) {
            return Container();
            // UserInfo(
            //   promotion: promotion,
            //   to: widget.to,
            //   go: widget.Departurn,
            //   isRouterGoAndBack: isRouterGoAndBack,
            //   adult: widget.adult,
            //   customer: widget.customer,
            //   children: widget.children,
            //   childrenName: widget.childrenName,
            //   onStepCompleted: () {
            //     if (mounted) {
            //       setState(() {
            //         activeStep = 2;
            //       });
            //     }
            //   },
            // );
          } else {
            setState(() {
              activeStep = 0;
            });

            return HeardFlightRoute1(
              formattedFutureDates,
            );
          }
        } else if (activeStep == 2) {
          return Container();
          // RankUser(
          //   customer: widget.customer,
          //   children: widget.children,
          //   isRouterGoAndBack: isRouterGoAndBack,
          //   promotio: promotion,
          //   isRankUser: _isRankUser,
          //   onIsRouterCallbackChanged: (value) => setState(() {
          //     _isRankUser = value;
          //     print("_isRankUser + ${_isRankUser}");
          //   }),
          //   onStepCompleted: () {
          //     if (mounted) {
          //       setState(() {
          //         activeStep = 3;
          //       });
          //     }
          //   },
          // );
        } else if (activeStep == 3) {
          return Container();
          // PaymentTicket(
          //   promotion: promotion,
          //   to: widget.to,
          //   go: widget.Departurn,
          //   childer: widget.children,
          //   customer: widget.customer,
          //   isRouterGoAndBack: isRouterGoAndBack,
          // );
        } else {
          return HeardFlightRoute1(formattedFutureDates);
        }
      } else {
        if (activeStep == 1) {
          return Container();
          // UserInfo(
          //   promotion: promotion,
          //   to: widget.to,
          //   go: widget.Departurn,
          //   isRouterGoAndBack: isRouterGoAndBack,
          //   adult: widget.adult,
          //   customer: widget.customer,
          //   children: widget.children,
          //   childrenName: widget.childrenName,
          //   onStepCompleted: () {
          //     if (mounted) {
          //       setState(() {
          //         activeStep = 2;
          //       });
          //     }
          //   },
          // );
        } else if (activeStep == 2) {
          return Container();
          // PaymentTicket(
          //   promotion: promotion,
          //   to: widget.to,
          //   go: widget.Departurn,
          //   childer: widget.children,
          //   customer: widget.customer,
          //   isRouterGoAndBack: isRouterGoAndBack,
          // );
        } else {
          return HeardFlightRoute1(formattedFutureDates);
        }
      }
    }
  }

//!  Time Flight
  Column HeardFlightRoute(
    List<String> formattedFutureDates,
    List<String> timeCallBack1,
  ) {
    if (!isRouterGoAndBack) {
      return Column(
        children: [
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  height: 80,
                  width: 1000,
                  child: Row(
                    children: [
                      for (String date in formattedFutureDates)
                        Container(
                          height: 80,
                          width: 100,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTimeGo = date;

                                // findByGetBydate(date, selectedTimeCallBack);
                              });
                            },

                            //! ranh thi lam con ko loz lam cung dc
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NewBox(
                                child: Text(date),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 70,
            width: 400,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: 100, child: Icon(Icons.airplanemode_active)),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          !isRouterGoAndBack
                              ? selectedTimeGo
                              : selectedTimeCallBack,
                          maxLines: 1,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          isRouterGoAndBack
                              ? "${widget.to + "----->"} ${widget.Departurn}"
                              : "${widget.Departurn + "----->"} ${widget.to}",
                          maxLines: 1,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 460,
            padding: EdgeInsets.all(20),
            child: NewBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 400,
                    //!
                    child: CustomTabBar(
                      // findByGetBydateCallback: findByGetBydate,
                      To: widget.to,
                      departure: widget.Departurn,
                      catecory: "Round_trip",
                      // filghtInfoGo: filghtInfoGo,
                      // filghtInfoCallBack: filghtInfoCallBack,
                      dateTime: selectedTimeGo.toString(),
                      isRouterCallback: isRouterGoAndBack,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ma giam gia
          Container(
            height: 70,
            width: 400,
            child: BottomNavigator(
              child: GestureDetector(
                onTap: () {
                  if (isRouterGoAndBack ?? true) {
                    setState(() {
                      activeStep = 1;
                    });
                  } else {
                    setState(() {
                      isRouterGoAndBack = !isRouterGoAndBack;
                      activeStep = 0;
                    });
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  height: 80,
                  width: 1000,
                  child: Row(
                    children: [
                      for (String date in timeCallBack1)
                        Container(
                          height: 80,
                          width: 100,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTimeCallBack = date;
                                // findByGetBydate(selectedTimeGo, date);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NewBox(
                                child: Text(
                                  date,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 70,
            width: 400,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: 100, child: Icon(Icons.airplanemode_active)),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          !isRouterGoAndBack
                              ? selectedTimeGo
                              : selectedTimeCallBack,
                          maxLines: 1,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          isRouterGoAndBack
                              ? "${widget.to + "----->"}  ${widget.Departurn}"
                              : "${widget.Departurn + "----->"} ${widget.to}",
                          maxLines: 1,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 460,
            padding: EdgeInsets.all(20),
            child: NewBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 400,
                    child: CustomTabBar(
                      To: widget.to,
                      // findByGetBydateCallback: findByGetBydate,
                      departure: widget.Departurn,
                      catecory: "Round_trip",
                      // filghtInfoGo: filghtInfoGo,
                      // filghtInfoCallBack: filghtInfoCallBack,
                      dateTime: selectedTimeGo.toString(),
                      isRouterCallback: isRouterGoAndBack,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ma giam gia
          Container(
            height: 70,
            width: 400,
            child: BottomNavigator(
              child: GestureDetector(
                onTap: () {
                  if (isRouterGoAndBack ?? true) {
                    setState(() {
                      activeStep = 1;
                    });
                  } else {
                    setState(() {
                      isRouterGoAndBack = !isRouterGoAndBack;
                      activeStep = 0;
                    });
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      );
    }
  }

  //!  ONE_Way
  Column HeardFlightRoute1(List<String> formattedFutureDates) {
    return Column(
      children: [
        Container(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                height: 80,
                width: 1000,
                child: Row(
                  children: [
                    for (String date in formattedFutureDates)
                      Container(
                        height: 80,
                        width: 100,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTimeGo = date;
                              // Navigator.pop(context);
                              // findByGetBydate(date, null);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewBox(
                              child: Text(date),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          height: 70,
          width: 400,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: 100, child: Icon(Icons.airplanemode_active)),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        // ! date time user chooise
                        selectedTimeGo,
                        maxLines: 1,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${widget.Departurn}------->${widget.to}",
                        maxLines: 1,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 460,
          padding: EdgeInsets.all(20),
          child: NewBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  child: Customer_TapBar_One_Way(
                    To: widget.to,
                    departure: widget.Departurn,
                    catecory: "Round_trip",
                    // filghtInfoGo: filghtInfoGo,
                    dateTime: selectedTimeGo.toString(),
                    isRouterCallback: isRouterGoAndBack,
                  ),
                ),
              ],
            ),
          ),
        ),
        // ma giam gia
        Container(
          height: 70,
          width: 400,
          child: BottomNavigator(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeStep = 1;
                });
              },
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}

//! dia diem di so nguoi *
