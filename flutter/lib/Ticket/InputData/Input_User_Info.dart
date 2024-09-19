// import 'dart:convert';
// import 'package:airlinesk3/Box/New_Book_container.dart';
// import 'package:airlinesk3/Box/New_Box.dart';
// import 'package:airlinesk3/LogicService/Find_By_TicketOfDate_Service/Find_by_Ticket_of_date.dart';
// import 'package:airlinesk3/LogicService/Model/Fightinfo.dart';
// import 'package:airlinesk3/LogicService/Model/FlightTicket.dart';
// import 'package:airlinesk3/LogicService/Model/Order_ticket.dart';
// import 'package:airlinesk3/LogicService/Model/Promotion.dart';

// import 'package:airlinesk3/LogicService/Model/SelectFlightRequest.dart';
// import 'package:airlinesk3/LogicService/funcCheck/Check_Anything.dart';
// import 'package:airlinesk3/Views/Appbar/ButtonNavigator.dart';
// import 'package:airlinesk3/Views/Appbar/MyAppbar.dart';
// import 'package:airlinesk3/Views/Appbar/Text_Input.dart';
// import 'package:airlinesk3/Views/Find_By_Order_Ok/Find_By_Order.dart';
// import 'package:airlinesk3/Views/Home/Home_pape.dart';
// import 'package:airlinesk3/Views/Ticket/FindbyTicket/Find_By_Ticket.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:gap/gap.dart';
// import 'package:intl/intl.dart';

// class UserInfo extends StatefulWidget {
//   int customer;
//   int children;
//   bool isRouterGoAndBack;

//   String? childrenName;
//   String? adult;
//   String to;
//   String go;

//   List<Promotion> promotion;
//   final Function()? onStepCompleted;
//   UserInfo(
//       {super.key,
//       required this.adult,
//       required this.customer,
//       required this.children,
//       required this.isRouterGoAndBack,
//       required this.go,
//       required this.to,
//       required this.promotion,
//       required this.onStepCompleted,
//       required this.childrenName});

//   @override
//   State<UserInfo> createState() => _UserInfoState();
// }

// late List<TextEditingController> adultNameControllers;
// late List<TextEditingController> adultPhoneController;
// late List<TextEditingController> childNameControllers;
// late List<TextEditingController> childPhoneControllers;
// late List<TextEditingController> adultEmailController;

// class _UserInfoState extends State<UserInfo> {
//   String? choosefightCallback;
//   String? chooseFightGO;

//   void checkStoreHavedata() async {
//     final storage = FlutterSecureStorage();
//     if (widget.isRouterGoAndBack ?? true) {
//       String? kqgo = await storage.read(key: "fightGo");
//       String? kq = await storage.read(key: "fightCallback");

//       if (kq != null && kqgo != null) {
//         setState(() {
//           choosefightCallback = kq;
//           chooseFightGO = kqgo;
//         });
//         return;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Please select a flight!'),
//             duration: Duration(seconds: 5), // Duration of the snackbar display
//           ),
//         );
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => FindByTicket()));
//       }
//     } else {
//       String? kqgo = await storage.read(key: "fightGo");
//       if (kqgo != null) {
//         setState(() {
//           chooseFightGO = kqgo;
//         });
//         return;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Please select a flight!'),
//             duration: Duration(seconds: 5), // Duration of the snackbar display
//           ),
//         );
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => FindByTicket()));
//       }
//     }
//   }

//   //! in put User
//   @override
//   void initState() {
//     super.initState();

//     checkStoreHavedata();
//     selectFightandSeat();
//     // calculateTotalMoney();

//     CheckTikiet();
//     adultNameControllers = List.generate(
//       widget.customer,
//       (index) => TextEditingController(),
//     );

//     adultPhoneController = List.generate(
//       widget.customer,
//       (index) => TextEditingController(),
//     );
//     adultEmailController = List.generate(
//       widget.customer,
//       (index) => TextEditingController(),
//     );
//     print(widget.customer);
//     if (widget.children == 0) {
//       childNameControllers = [];
//     } else {
//       childNameControllers = List.generate(
//         widget.children,
//         (index) => TextEditingController(),
//       );
//       childPhoneControllers = List.generate(
//         widget.children,
//         (index) => TextEditingController(),
//       );
//     }
//   }

//   Future<bool> checkEmailData() async {
//     for (int i = 0; i < adultEmailController.length; i++) {
//       String email = adultEmailController[i].text;
//       if (!CheckAnything().isEmailValid(email)) {
//         print('Địa chỉ email không hợp lệ: $email');
//         return false;
//       }
//     }
//     return true;
//   }

//   Future<bool> checkPhoneData() async {
//     for (int i = 0; i < adultPhoneController.length; i++) {
//       String phone = adultPhoneController[i].text;
//       if (!CheckAnything().isPhoneNumberValid(phone)) {
//         print('Số điện thoại không hợp lệ: $phone');
//         return false;
//       }
//     }
//     return true;
//   }

//   Future<bool> checkInputDataForUser() async {
//     bool isEmailValid = await checkEmailData();
//     bool isPhoneValid = await checkPhoneData();

//     if (!isEmailValid && !isPhoneValid) {
//       return false;
//     }
//     return true;
//   }

//   int? checkNumber() {
//     if (widget.customer >= 1 && widget.children == 0) {
//       return 1;
//     } else {
//       return 2;
//     }
//   }

// // ! check input if use not input sate can not choose
//   bool? checkInput() {
//     if (adultNameControllers.any((controller) => controller.text.isEmpty)) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Notification"),
//           content:
//               Text('Please input all the information before choosing a seat'),
//         ),
//       );
//       return false;
//     } else {
//       return true;
//     }
//   }

// //  storage.write(key: "__isSelectbusiness", value: "economy");
//   //! check tiket vip and nomal
//   final storage = FlutterSecureStorage();
//   bool _ischeckTiket = true;
//   bool _isCheckTiketCallback = true;
//   void CheckTikiet() async {
//     if (widget.isRouterGoAndBack ?? true) {
//       String? _isSelectTiket =
//           await storage.read(key: "_isSelectTiket"); //! check gia tri go
//       String? _isSelectTiketCallback =
//           await storage.read(key: "__isSelectbusiness"); //! chekc gia tri ve

//       if (_isSelectTiket != null &&
//           _isSelectTiket.contains("economy") &&
//           _isSelectTiketCallback != null &&
//           _isSelectTiketCallback.contains("economy")) {
//         setState(() {
//           _ischeckTiket = true;
//           _isCheckTiketCallback = true;
//         });
//       } else if (_isSelectTiket != null &&
//           _isSelectTiket.contains("economy") &&
//           _isSelectTiketCallback != null &&
//           !_isSelectTiketCallback.contains("economy")) {
//         setState(() {
//           _ischeckTiket = true;
//           _isCheckTiketCallback = false;
//         });
//       } else if (_isSelectTiket != null &&
//           !_isSelectTiket.contains("economy") &&
//           _isSelectTiketCallback != null &&
//           _isSelectTiketCallback.contains("economy")) {
//         setState(() {
//           _ischeckTiket = false;
//           _isCheckTiketCallback = true;
//         });
//       } else {
//         setState(() {
//           _ischeckTiket = false;
//           _isCheckTiketCallback = false;
//         });
//       }
//       calculateTotalMoney();
//     } //!! one way
//     else {
//       String? _isSelectTiket = await storage.read(key: "_isSelectTiket");

//       if (_isSelectTiket != null && _isSelectTiket.contains("economy")) {
//         setState(() {
//           _ischeckTiket = true;
//         });
//       } else {
//         setState(() {
//           _ischeckTiket = false;
//         });
//       }
//       calculateTotalMoney();
//     }
//   }

//   //!  total money children and customer
//   double moneyGo = 0;
//   double moneyCallback = 0;
//   double amoutAdultGo = 0;
//   double amountchilderGo = 0;
//   double amoutAdultCallback = 0;
//   double amountchilderCallback = 0;

//   double totalMoney = 0;
//   NumberFormat currencyFormatter =
//       NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

//   int businessSeat = 0;
//   int economySeat = 0;
//   int totalSeats = 0;
//   int onwayseat = 0;
//   int callbackSeate = 0;
//   int callbackSeate1 = 0;

//   void calculateTotalMoney() async {
//     try {
//       if (widget.isRouterGoAndBack) {
//         String? flightInfoGo = await storage.read(key: "fightGo");
//         String? flightInfoCallBack = await storage.read(key: "fightCallback");

//         if (flightInfoGo == null || flightInfoCallBack == null) {
//           return;
//         }
//         FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo);
//         FlightInfoStore flightCallback =
//             FlightInfoStore.fromString(flightInfoCallBack);
//         if (_ischeckTiket) {
//           print(_ischeckTiket);
//           economySeat = flightGo.economySeats;
//         } else {
//           print(_ischeckTiket);
//           economySeat = flightGo.businessSeats;
//         }
//         if (_isCheckTiketCallback) {
//           print(_isCheckTiketCallback);
//           businessSeat = flightCallback.economySeats;
//         } else {
//           print(_isCheckTiketCallback);
//           businessSeat = flightCallback.businessSeats;
//         }
//         setState(() {
//           callbackSeate = economySeat;
//           callbackSeate1 = businessSeat;
//           print("callbackSeate ${callbackSeate}");
//           print("callbackSeate1 ${callbackSeate1}");
//         });
//         return;
//       }
//       //! one way
//       else {
//         String? flightInfoGo = await storage.read(key: "fightGo");
//         String? _isSelectTiket = await storage.read(key: "_isSelectTiket");
//         if (flightInfoGo == null) {
//           return;
//         }

//         FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo);

//         if (_ischeckTiket) {
//           totalSeats = flightGo.economySeats;
//         } else {
//           totalSeats = flightGo.businessSeats;
//         }

//         setState(() {
//           onwayseat = totalSeats;
//           print("onwayseat ${onwayseat}");
//         });
//       }
//     } catch (e) {
//       print("Error in calculateTotalMoney: $e");
//     }
//   }

//   //! textStyle
//   TextStyle textStyle =
//       TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);
//   //! select flight selectFightTakeSeat

//   SelectFlightRequest? selectFlightRequest;
//   Future<void> selectFightandSeat() async {
//     try {
//       if (widget.isRouterGoAndBack ?? true) {
//         String? _isSelectTiket = await storage.read(key: "_isSelectTiket");
//         String? _isSelectTiketCallback =
//             await storage.read(key: "__isSelectbusiness");
//         String? flightInfoGo = await storage.read(key: "fightGo");
//         String? flightInfoCallBack = await storage.read(key: "fightCallback");
//         FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo!);
//         FlightInfoStore flightCallback =
//             FlightInfoStore.fromString(flightInfoCallBack!);
//         SelectFlightRequest? selectFlightRequest1 = await FindByTicket1()
//             .selectFightTakeSeat(
//                 _isSelectTiket!,
//                 _isSelectTiketCallback!,
//                 int.parse(flightGo.flightId),
//                 int.parse(flightCallback.flightId),
//                 widget.children,
//                 widget.customer,
//                 widget.isRouterGoAndBack);
//         if (selectFlightRequest1 != null) {
//           setState(() {
//             selectFlightRequest = selectFlightRequest1;
//             if (selectFlightRequest!.departureFlights.isNotEmpty) {
//               selectFlightRequest!.departureFlights.forEach((flight) {
//                 double? price = flight.price!.totalPrice;
//                 moneyGo = price!;
//                 amoutAdultGo = flight.price!.adultPrice!;
//                 if (widget.children > 0) {
//                   amountchilderGo = flight.price!.childPrice!;
//                 }
//                 flight.seatNumberResults?.forEach((seat) {
//                   String seatNumberGo = seat.seatNumber;
//                   seatGo.add(seatNumberGo);
//                   print(seatNumberGo);
//                 });
//               });
//             }
//             if (selectFlightRequest!.returnFlights.isNotEmpty) {
//               selectFlightRequest!.returnFlights.forEach((flight) {
//                 double? price = flight.price!.totalPrice;
//                 moneyCallback = price!;
//                 amoutAdultCallback = flight.price!.adultPrice!;
//                 if (widget.children > 0) {
//                   amoutAdultCallback = flight.price!.childPrice!;
//                 }
//                 flight.seatNumberResults?.forEach((seat) {
//                   String seateCallback = seat.seatNumber;
//                   print(seateCallback);
//                   seatCallback.add(seateCallback);
//                 });
//               });
//             }
//             totalMoney = moneyGo + moneyCallback;
//           });
//           return;
//         } else {
//           print(selectFightandSeat);
//         }
//       } else {
//         String? _isSelectTiket = await storage.read(key: "_isSelectTiket");
//         String? flightInfoGo = await storage.read(key: "fightGo");
//         FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo!);
//         SelectFlightRequest? selectFlightRequest1 = await FindByTicket1()
//             .selectFightTakeSeat(
//                 _isSelectTiket!,
//                 '',
//                 int.parse(flightGo.flightId),
//                 0,
//                 widget.children,
//                 widget.customer,
//                 widget.isRouterGoAndBack);
//         if (selectFlightRequest1 != null) {
//           setState(() {
//             selectFlightRequest = selectFlightRequest1;
//             if (selectFlightRequest1.departureFlights.isNotEmpty) {
//               selectFlightRequest1.departureFlights.forEach((flight) {
//                 double? price = flight.price!.totalPrice;
//                 moneyGo = price!;
//                 flight.seatNumberResults?.forEach((seat) {
//                   String seatNumberGo = seat.seatNumber;
//                   seatGo.add(seatNumberGo);
//                   print(seatNumberGo);
//                   print(seatGo);
//                 });
//               });
//             }
//             totalMoney = moneyGo;
//           });
//           return;
//         } else {
//           print(selectFightandSeat);
//         }
//       }
//     } catch (e) {
//       print("Error in selectFightandSeat: $e");
//     }
//   }

//   //! list Customer Choose seat input in list data
//   List<String> customerChooseSeatGo = [];

//   List<String> customerChooseSeatCallback = [];

//   List<String> seatGo = []; //! da co data tu api roi

//   List<String> seatCallback = []; //! da co data tu api roi

//   bool checkSeatGoANdOnWay() {
//     // check dk nua
//     int sumCustomer = widget.children + widget.customer;
//     print(customerChooseSeatGo.length);

//     if (customerChooseSeatGo.length == sumCustomer) {
//       return true;
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Too Many Seats Selected"),
//             content: Text("Please select up to $sumCustomer seats."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     customerChooseSeatGo.clear();
//                     print(customerChooseSeatGo);
//                   });
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//       return false;
//     }
//   }

//   bool checkSeatGoAndCallback() {
//     // check dk nua
//     int sumCustomer = widget.children + widget.customer;

//     if (customerChooseSeatCallback.length == sumCustomer) {
//       return true;
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Too Many Seats Selected"),
//             content: Text("Please select up to $sumCustomer seats."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     customerChooseSeatCallback.clear();
//                     print(customerChooseSeatCallback);
//                   });
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//       return false;
//     }
//   }

//   FlightTicket? flightTicket;
// //! add infoUserAndSeate

//   void infoUserAndSeate() async {
//     // Kiểm tra xem widget có phải là đặt vé đi và về hay không
//     if (widget.isRouterGoAndBack) {
//       // Đọc thông tin vé đi và vé về từ bộ nhớ
//       String? _isSelectTiket = await storage.read(key: "_isSelectTiket");
//       String? _isSelectTiketCallback =
//           await storage.read(key: "__isSelectbusiness");
//       String? flightInfoGo = await storage.read(key: "fightGo");
//       String? flightInfoCallBack = await storage.read(key: "fightCallback");

//       // Chuyển đổi thông tin chuyến bay từ chuỗi thành đối tượng FlightInfoStore
//       FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo!);
//       FlightInfoStore flightCallback =
//           FlightInfoStore.fromString(flightInfoCallBack!);

//       // Kiểm tra số ghế đã chọn cho cả chuyến đi và chuyến về
//       if (checkSeatGoAndCallback() && checkSeatGoANdOnWay()) {
//         List<OrderTicket> orderTicketGo = [];
//         storage.write(key: "totalMoney", value: totalMoney.toString());
//         storage.write(
//             key: "customerChooseSeatGo",
//             value: jsonEncode(customerChooseSeatGo));
//         storage.write(
//             key: "customerChooseSeatCallback",
//             value: jsonEncode(customerChooseSeatCallback));
//         for (int i = 0; i < widget.customer; i++) {
//           orderTicketGo.add(OrderTicket(
//             fullName: adultNameControllers[i].text,
//             phone: adultPhoneController[i].text,
//             email: adultEmailController[i].text,
//             numberSeats: customerChooseSeatGo[i],
//             typeSeats: _isSelectTiket!,
//             customType: "adult",
//             ticketType: "Round_trip",
//             aliases: aliases,
//           ));
//         }
//         if (widget.children > 0) {
//           for (int j = 0; j < widget.children; j++) {
//             orderTicketGo.add(OrderTicket(
//               fullName: childNameControllers[j].text,
//               phone: childPhoneControllers[j].text,
//               email: adultEmailController[0].text,
//               typeSeats: _isSelectTiket!,
//               customType: "children",
//               aliases: aliases,
//               ticketType: "Round_trip",
//               numberSeats: customerChooseSeatGo[widget.customer + j],
//             ));
//           }
//         }
//         // Chuyển danh sách đặt vé đi thành chuỗi JSON và lưu vào bộ nhớ
//         String orderTicketGoJson = jsonEncode(orderTicketGo);
//         storage.write(key: "orderTiketGo", value: orderTicketGoJson);

//         // Tạo danh sách đặt vé về orderTiketCallback orderTiketGo
//         List<OrderTicket> orderTicketCallback = [];
//         for (int i = 0; i < widget.customer; i++) {
//           orderTicketCallback.add(OrderTicket(
//             fullName: adultNameControllers[i].text,
//             phone: adultPhoneController[i].text,
//             email: adultEmailController[i].text,
//             numberSeats: customerChooseSeatCallback[i],
//             typeSeats: _isSelectTiketCallback!,
//             ticketType: "Round_trip",
//             customType: "adult",
//             promotionId: 0,
//             aliases: aliases,
//           ));
//         }
//         // Nếu có trẻ em thì thêm vào danh sách đặt vé về
//         if (widget.children > 0) {
//           for (int j = 0; j < widget.children; j++) {
//             orderTicketCallback.add(OrderTicket(
//               fullName: childNameControllers[j].text,
//               phone: childPhoneControllers[j].text,
//               numberSeats: customerChooseSeatCallback[widget.customer + j],
//               typeSeats: _isSelectTiketCallback!,
//               email: adultEmailController[0].text,
//               customType: "children",
//               ticketType: "Round_trip",
//               promotionId: 0,
//               aliases: aliases,
//             ));
//           }
//         }
//         // Chuyển danh sách đặt vé về thành chuỗi JSON và lưu vào bộ nhớ
//         String orderTicketCallbackJson = jsonEncode(orderTicketCallback);
//         storage.write(
//             key: "orderTiketCallback", value: orderTicketCallbackJson);

//         storage.write(
//             key: "customerChooseSeatGo",
//             value: jsonEncode(customerChooseSeatGo));
//         if (widget.promotion.isEmpty) {
//           FlightTicket? flightTicket1 = await FindByTicket1().createTicket(
//             int.parse(flightGo.flightId),
//             int.parse(flightCallback.flightId),
//             widget.children,
//             widget.customer,
//             orderTicketGo,
//             orderTicketCallback,
//           );
//           if (flightTicket1 != null) {
//             setState(() {
//               flightTicket = flightTicket1;
//               print(flightTicket);
//               String orderNo = jsonEncode(flightTicket1);
//               storage.write(key: "orderNo", value: orderNo);
//             });
//           }
//           widget.onStepCompleted?.call();
//         } else {
//           widget.onStepCompleted?.call();
//           return;
//         }
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Too Many Seats Selected"),
//               content: Text("Please select up to seats."),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       customerChooseSeatCallback.clear();
//                       print(customerChooseSeatCallback);
//                     });
//                     Navigator.pop(context);
//                   },
//                   child: Text("OK"),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//     //! onw way

//     else {
//       String? _isSelectTiket = await storage.read(key: "_isSelectTiket");
//       String? _isSelectTiketCallback =
//           await storage.read(key: "__isSelectbusiness");
//       String? flightInfoGo = await storage.read(key: "fightGo");

//       FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo!);
//       if (checkSeatGoANdOnWay()) {
//         List<OrderTicket> orderTicketGo = [];
//         storage.write(key: "totalMoney", value: totalMoney.toString());
//         for (int i = 0; i < widget.customer; i++) {
//           orderTicketGo.add(OrderTicket(
//             fullName: adultNameControllers[i].text,
//             phone: adultPhoneController[i].text,
//             email: adultEmailController[i].text,
//             numberSeats: customerChooseSeatGo[i],
//             typeSeats: _isSelectTiket!,
//             customType: "adult",
//             ticketType: "OneWay",
//             promotionId: 0,
//             aliases: aliases,
//           ));
//         }

//         if (widget.children > 0) {
//           for (int j = 0; j < widget.children; j++) {
//             orderTicketGo.add(OrderTicket(
//               fullName: childNameControllers[j].text,
//               phone: childPhoneControllers[j].text,
//               email: adultEmailController[0].text,
//               typeSeats: _isSelectTiket!,
//               customType: "children",
//               aliases: aliases,
//               promotionId: 0,
//               ticketType: "OneWay",
//               numberSeats: customerChooseSeatGo[widget.customer + j],
//             ));
//           }
//         }

//         String orderTicketGoJson = jsonEncode(orderTicketGo);
//         storage.write(key: "orderTiketGo", value: orderTicketGoJson);

//         if (widget.promotion.isEmpty) {
//           FlightTicket? flightTicket1 = await FindByTicket1().createTicket(
//             int.parse(flightGo.flightId),
//             0,
//             widget.children,
//             widget.customer,
//             orderTicketGo,
//             null,
//           );
//           if (flightTicket1 != null) {
//             setState(() {
//               flightTicket = flightTicket1;
//               String orderNo = jsonEncode(flightTicket1);
//               storage.write(key: "orderNo", value: orderNo);
//             });
//           }
//           widget.onStepCompleted?.call();
//         } else {
//           widget.onStepCompleted?.call();
//           return;
//         }
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Too Many Seats Selected"),
//               content: Text("Please select up to seats."),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       customerChooseSeatCallback.clear();
//                       print(customerChooseSeatCallback);
//                     });
//                     Navigator.pop(context);
//                   },
//                   child: Text("OK"),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }

// //! buttom down ?????
//   List<String> Aliases1 = [" Mr", "Ms", " Mrs"];
//   String aliases = "";

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Container(
//       height: media.height * 0.7,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Container(
//               height: media.height * 0.1,
//               padding: EdgeInsets.all(10),
//               width: 400,
//               child: NewBox(
//                   child: Row(
//                 children: [
//                   Expanded(
//                       child: Container(
//                     height: media.height * 0.1,
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             child: Text(
//                               "Total Money",
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             child: Text(
//                               currencyFormatter.format(totalMoney),
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//                   Expanded(
//                       child: Container(
//                     margin: EdgeInsets.only(left: media.width * 0.15),
//                     height: media.height * 0.1,
//                     child: IconButton(
//                         onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
//                   )),
//                 ],
//               )),
//             ),

//             // Input Customer
//             //! Customer Information
//             Container(
//               height: 200,
//               child: GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Scaffold(
//                         appBar: CustomAppBar(
//                           name: "Enter Information",
//                         ),
//                         body: SingleChildScrollView(
//                           scrollDirection: Axis.vertical,
//                           child: Column(
//                             children: [
//                               for (int i = 0; i < widget.customer; i++)
//                                 Column(
//                                   children: [
//                                     NewBox(
//                                       child: Text(
//                                         "Adult${i + 1}",
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),

//                                     //!!   Adult
//                                     Container(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               padding: EdgeInsets.all(5),
//                                               width: 70,
//                                               height: 60,
//                                               child: NewBox(
//                                                 child: DropdownButton<String>(
//                                                   value: aliases.isNotEmpty
//                                                       ? aliases
//                                                       : null,
//                                                   items: Aliases1.map(
//                                                       (String value) {
//                                                     return DropdownMenuItem<
//                                                         String>(
//                                                       value: value,
//                                                       child: Text(value),
//                                                     );
//                                                   }).toList(),
//                                                   onChanged:
//                                                       (String? newValue) {
//                                                     setState(() {
//                                                       aliases = newValue!;
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 4,
//                                             child: Container(
//                                               width: media.width * 0.8,
//                                               child: TextFailInput(
//                                                 obscureText: false,
//                                                 controller:
//                                                     adultNameControllers[i],
//                                                 textName: "FullName",
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     TextFailInput(
//                                       obscureText: false,
//                                       textName: "Phone",
//                                       controller: adultPhoneController[i],
//                                     ),
//                                     TextFailInput(
//                                       obscureText: false,
//                                       textName: "email",
//                                       controller: adultEmailController[i],
//                                     ),
//                                   ],
//                                 ),
//                               // Hiển thị thông tin cho trẻ em
//                               Column(
//                                 children: [
//                                   for (int i = 0; i < widget.children; i++)
//                                     Column(
//                                       children: [
//                                         NewBox(
//                                           child: Text(
//                                             "Child${i + 1}",
//                                             maxLines: 1,
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   padding: EdgeInsets.all(5),
//                                                   width: 70,
//                                                   height: 60,
//                                                   child: NewBox(
//                                                     child:
//                                                         DropdownButton<String>(
//                                                       value: aliases.isNotEmpty
//                                                           ? aliases
//                                                           : null,
//                                                       items: Aliases1.map(
//                                                           (String value) {
//                                                         return DropdownMenuItem<
//                                                             String>(
//                                                           value: value,
//                                                           child: Text(value),
//                                                         );
//                                                       }).toList(),
//                                                       onChanged:
//                                                           (String? newValue) {
//                                                         setState(() {
//                                                           aliases = newValue!;
//                                                         });
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 4,
//                                                 child: Container(
//                                                   width: media.width * 0.8,
//                                                   child: TextFailInput(
//                                                     obscureText: false,
//                                                     controller:
//                                                         childNameControllers[i],
//                                                     textName: "FullName",
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         TextFailInput(
//                                           obscureText: false,
//                                           textName: "Phone",
//                                           controller: childPhoneControllers[i],
//                                         ),
//                                       ],
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         // bottomNavigationBar: GestureDetector(
//                         //   onTap: () {
//                         //     Navigator.pop(context);
//                         //   },
//                         //   child: Container(
//                         //     height: 70,
//                         //     child: BottomNavigator(child: Text("Complete")),
//                         //   ),
//                         // ),
//                       );
//                     },
//                   );
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   width: 400,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: NewBooxCOntainer(
//                         child: Column(
//                       children: [
//                         Container(
//                           height: 30,
//                           child: Row(
//                             children: [
//                               Icon(Icons.person_add_alt_1),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 "Customer information",
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w800),
//                               )
//                             ],
//                           ),
//                         ),

//                         //
//                         Container(
//                           height: 400,
//                           child: ListView.builder(
//                             itemCount: checkNumber(),
//                             itemBuilder: (context, index) {
//                               if (index == 0 || widget.children == 0) {
//                                 return Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         child: Text(
//                                           "Passengers - Adults",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Row(
//                                           children: [
//                                             Icon(
//                                               Icons.add_box,
//                                               color: Color.fromARGB(
//                                                   255, 173, 157, 8),
//                                             ),
//                                             SizedBox(width: 2),
//                                             Container(
//                                               margin: EdgeInsets.only(
//                                                   right: media.width * 0.1),
//                                               child: Text(
//                                                 "Enter Information for Adult",
//                                                 maxLines: 1,
//                                                 style: TextStyle(
//                                                   fontSize: 15,
//                                                   color: Color.fromARGB(
//                                                       255, 173, 157, 8),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               } else if (index == 1) {
//                                 // Container cho trẻ em
//                                 return Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         child: Text(
//                                           "Passengers - Children",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Row(
//                                           children: [
//                                             Icon(
//                                               Icons.add_box,
//                                               color: Color.fromARGB(
//                                                   255, 173, 157, 8),
//                                             ),
//                                             SizedBox(width: 2),
//                                             Container(
//                                               margin: EdgeInsets.only(
//                                                   right: media.width * 0.1),
//                                               child: Text(
//                                                 "Enter Information for Child",
//                                                 maxLines: 1,
//                                                 style: TextStyle(
//                                                   fontSize: 15,
//                                                   color: Color.fromARGB(
//                                                       255, 173, 157, 8),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               } else {
//                                 // Trường hợp không xác định, không hiển thị gì cả
//                                 return SizedBox.shrink();
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     )),
//                   ),
//                 ),
//               ),
//             ),

//             //! Hành lý
//             Luggage(media),
//             //!  Seat
//             SeatTicketVipAndEcomy(context, media),
//             Gap(20),
//             GestureDetector(
//               onTap: () async {
//                 bool isValid = await checkInputDataForUser();
//                 print(isValid);
//                 if (isValid == true) {
//                   infoUserAndSeate();
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text("Invalid information"),
//                         content: Text(
//                             "Please check your input and try again email,fullname,phone"),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text("Close"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: Container(
//                 height: 70,
//                 width: 400,
//                 child: NewBox(
//                   child: Text(
//                     "Continue",
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget SeatTicketVipAndEcomy(BuildContext context, Size media) {
//     if (widget.isRouterGoAndBack) {
//       return Container(
//         height: 250,
//         width: 430,
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 bool? abc = checkInput();
//                 if (abc ?? true) {
//                   showModalBottomSheet(
//                     context: context,
//                     isScrollControlled: true,
//                     builder: (BuildContext context) {
//                       final double bottomSheetHeight = media.height * 0.9;
//                       return Container(
//                         height: bottomSheetHeight,
//                         child: Scaffold(
//                           appBar: CustomAppBar(
//                             name: "Choose Your Seat",
//                           ),
//                           body: SingleChildScrollView(
//                             scrollDirection: Axis.vertical,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       if (_ischeckTiket)
//                                         Expanded(child: GoogleMapGo("A")),
//                                       if (_ischeckTiket)
//                                         Expanded(child: GoogleMapGo("B")),
//                                       if (_ischeckTiket)
//                                         Expanded(child: GoogleMapGo("C")),
//                                       if (_ischeckTiket)
//                                         Expanded(child: GoogleMapGo("D")),
//                                       if (!_ischeckTiket)
//                                         Expanded(child: GoogleMapGo("V")),
//                                       if (!_ischeckTiket)
//                                         Expanded(child: GoogleMapGo("I")),
//                                       if (!_ischeckTiket)
//                                         Expanded(child: GoogleMapGo("P")),
//                                       if (!_ischeckTiket)
//                                         Expanded(child: GoogleMapGo("Z")),
//                                     ],
//                                   ),
//                                 ),
//                                 Gap(20),
//                                 Container(
//                                   height: 50,
//                                   width: 400,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "number of chairs you need to choose ${widget.children + widget.customer} : ${customerChooseSeatGo}",
//                                         style: textStyle,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Gap(20),
//                                 Container(
//                                   height: 200,
//                                   width: 300,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           width: 0.5, color: Colors.black),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Expanded(
//                                                 child: Icon(
//                                                     Icons
//                                                         .airline_seat_recline_normal,
//                                                     size: 20,
//                                                     color: Colors.red
//                                                     // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                     ),
//                                               ),
//                                               Expanded(
//                                                 child: Center(
//                                                   child: Text(
//                                                     "seats have been selected",
//                                                     style: textStyle,
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   width: 40,
//                                                   height: 40,
//                                                   padding: EdgeInsets.all(10),
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.grey[300],
//                                                       // Đổi màu của ghế nếu đã được chọn
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5)),
//                                                   child: Icon(
//                                                       Icons
//                                                           .airline_seat_recline_normal,
//                                                       size: 20,
//                                                       color: Colors.blue

//                                                       // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                       ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Center(
//                                                   child: Text(
//                                                     "seats your choose",
//                                                     style: textStyle,
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   width: 40,
//                                                   height: 40,
//                                                   padding: EdgeInsets.all(10),
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       // Đổi màu của ghế nếu đã được chọn
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5)),
//                                                   child: Icon(
//                                                       Icons
//                                                           .airline_seat_recline_normal,
//                                                       size: 20,
//                                                       color: Colors.blue

//                                                       // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                       ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Center(
//                                                   child: Text(
//                                                     "Nobody chooses this seat",
//                                                     style: textStyle,
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       ]),
//                                 )
//                               ],
//                             ),
//                           ),
//                           bottomNavigationBar: GestureDetector(
//                             onTap: () {
//                               checkSeatGoANdOnWay() ?? true
//                                   ? Navigator.pop(context)
//                                   : null;
//                             },
//                             child: Container(
//                               height: 70,
//                               child: BottomNavigator(child: Text("Complete")),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },

//               //! callback
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 width: 400,
//                 child: NewBox(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 50,
//                         child: Row(
//                           children: [
//                             Icon(Icons.airline_seat_recline_extra),
//                             SizedBox(width: 10),
//                             Text(
//                               "Seat",
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.w800),
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: media.width * 0.8,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(right: media.width * 0.4),
//                               child: Text(
//                                 "${widget.go} ---> ${widget.to}",
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(right: media.width * 0.4),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.add_box,
//                                       color: Color.fromARGB(255, 173, 157, 8)),
//                                   SizedBox(width: 2),
//                                   Text(
//                                     "Seat",
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color:
//                                             Color.fromARGB(255, 173, 157, 8)),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 bool? abc = checkInput();
//                 if (abc ?? true) {
//                   showModalBottomSheet(
//                     context: context,
//                     isScrollControlled: true,
//                     builder: (BuildContext context) {
//                       final double bottomSheetHeight = media.height * 0.9;
//                       return Container(
//                         height: bottomSheetHeight,
//                         child: Scaffold(
//                           appBar: CustomAppBar(
//                             name: "Choose Your Seat",
//                           ),
//                           body: SingleChildScrollView(
//                             scrollDirection: Axis.vertical,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       if (_isCheckTiketCallback)
//                                         Expanded(child: GoogleMapCallback("A")),
//                                       if (_isCheckTiketCallback)
//                                         Expanded(child: GoogleMapCallback("B")),
//                                       if (_isCheckTiketCallback)
//                                         Expanded(child: GoogleMapCallback("C")),
//                                       if (_isCheckTiketCallback)
//                                         Expanded(child: GoogleMapCallback("D")),
//                                       if (!_isCheckTiketCallback)
//                                         Expanded(child: GoogleMapCallback("V")),
//                                       if (!_isCheckTiketCallback)
//                                         Expanded(child: GoogleMapCallback("I")),
//                                       if (!_isCheckTiketCallback)
//                                         Expanded(child: GoogleMapCallback("P")),
//                                       if (!_isCheckTiketCallback)
//                                         Expanded(child: GoogleMapCallback("Z")),
//                                     ],
//                                   ),
//                                 ),
//                                 Gap(20),
//                                 Container(
//                                   height: 50,
//                                   width: 400,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "number of chairs you need to choose ${widget.children + widget.customer} : ${customerChooseSeatCallback}",
//                                         style: textStyle,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Gap(20),
//                                 Container(
//                                   height: 200,
//                                   width: 300,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           width: 0.5, color: Colors.black),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Expanded(
//                                                 child: Icon(
//                                                     Icons
//                                                         .airline_seat_recline_normal,
//                                                     size: 20,
//                                                     color: Colors.red
//                                                     // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                     ),
//                                               ),
//                                               Expanded(
//                                                 child: Center(
//                                                   child: Text(
//                                                     "seats have been selected",
//                                                     style: textStyle,
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   width: 40,
//                                                   height: 40,
//                                                   padding: EdgeInsets.all(10),
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.grey[300],
//                                                       // Đổi màu của ghế nếu đã được chọn
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5)),
//                                                   child: Icon(
//                                                       Icons
//                                                           .airline_seat_recline_normal,
//                                                       size: 20,
//                                                       color: Colors.blue

//                                                       // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                       ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Center(
//                                                   child: Text(
//                                                     "seats your choose",
//                                                     style: textStyle,
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   width: 40,
//                                                   height: 40,
//                                                   padding: EdgeInsets.all(10),
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       // Đổi màu của ghế nếu đã được chọn
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5)),
//                                                   child: Icon(
//                                                       Icons
//                                                           .airline_seat_recline_normal,
//                                                       size: 20,
//                                                       color: Colors.blue

//                                                       // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                       ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Center(
//                                                   child: Text(
//                                                     "Nobody chooses this seat",
//                                                     style: textStyle,
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       ]),
//                                 )
//                               ],
//                             ),
//                           ),
//                           bottomNavigationBar: GestureDetector(
//                             onTap: () {
//                               checkSeatGoAndCallback() ?? true
//                                   ? Navigator.pop(context)
//                                   : null;
//                             },
//                             child: Container(
//                               height: 70,
//                               child: BottomNavigator(child: Text("Complete")),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 width: 400,
//                 child: NewBox(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 50,
//                         child: Row(
//                           children: [
//                             Icon(Icons.airline_seat_recline_extra),
//                             SizedBox(width: 10),
//                             Text(
//                               "Seat",
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.w800),
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: media.width * 0.8,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(right: media.width * 0.4),
//                               child: Text(
//                                 "${widget.to} ---> ${widget.go}",
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(right: media.width * 0.4),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.add_box,
//                                       color: Color.fromARGB(255, 173, 157, 8)),
//                                   SizedBox(width: 2),
//                                   Text(
//                                     "Seat",
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color:
//                                             Color.fromARGB(255, 173, 157, 8)),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );

//       // !! one way
//     } else {
//       return Container(
//         height: 150,
//         width: 400,
//         child: GestureDetector(
//           onTap: () {
//             bool? abc = checkInput();
//             if (abc ?? true) {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 builder: (BuildContext context) {
//                   final double bottomSheetHeight = media.height * 0.9;
//                   return Container(
//                     height: bottomSheetHeight,
//                     child: Scaffold(
//                       appBar: CustomAppBar(
//                         name: "Choose Your Seat",
//                       ),
//                       body: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   if (_ischeckTiket)
//                                     Expanded(child: GoogleMapOnway("A")),
//                                   if (_ischeckTiket)
//                                     Expanded(child: GoogleMapOnway("B")),
//                                   if (_ischeckTiket)
//                                     Expanded(child: GoogleMapOnway("C")),
//                                   if (_ischeckTiket)
//                                     Expanded(child: GoogleMapOnway("D")),
//                                   if (!_ischeckTiket)
//                                     Expanded(child: GoogleMapOnway("V")),
//                                   if (!_ischeckTiket)
//                                     Expanded(child: GoogleMapOnway("I")),
//                                   if (!_ischeckTiket)
//                                     Expanded(child: GoogleMapOnway("P")),
//                                   if (!_ischeckTiket)
//                                     Expanded(child: GoogleMapOnway("Z")),
//                                 ],
//                               ),
//                             ),
//                             Gap(20),
//                             Container(
//                               height: 50,
//                               width: 400,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "number of chairs you need to choose ${widget.children + widget.customer} : ${customerChooseSeatGo}",
//                                     style: textStyle,
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Gap(20),
//                             Container(
//                               height: 200,
//                               width: 300,
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       width: 0.5, color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(10),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Expanded(
//                                             child: Icon(
//                                                 Icons
//                                                     .airline_seat_recline_normal,
//                                                 size: 20,
//                                                 color: Colors.red
//                                                 // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                 ),
//                                           ),
//                                           Expanded(
//                                             child: Center(
//                                               child: Text(
//                                                 "seats have been selected",
//                                                 style: textStyle,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.all(10),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               width: 40,
//                                               height: 40,
//                                               padding: EdgeInsets.all(10),
//                                               decoration: BoxDecoration(
//                                                   color: Colors.grey[300],
//                                                   // Đổi màu của ghế nếu đã được chọn
//                                                   borderRadius:
//                                                       BorderRadius.circular(5)),
//                                               child: Icon(
//                                                   Icons
//                                                       .airline_seat_recline_normal,
//                                                   size: 20,
//                                                   color: Colors.blue

//                                                   // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                   ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Center(
//                                               child: Text(
//                                                 "seats your choose",
//                                                 style: textStyle,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.all(10),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               width: 40,
//                                               height: 40,
//                                               padding: EdgeInsets.all(10),
//                                               decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   // Đổi màu của ghế nếu đã được chọn
//                                                   borderRadius:
//                                                       BorderRadius.circular(5)),
//                                               child: Icon(
//                                                   Icons
//                                                       .airline_seat_recline_normal,
//                                                   size: 20,
//                                                   color: Colors.blue

//                                                   // Đổi màu của biểu tượng ghế nếu đã được chọn
//                                                   ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Center(
//                                               child: Text(
//                                                 "Nobody chooses this seat",
//                                                 style: textStyle,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   ]),
//                             )
//                           ],
//                         ),
//                       ),
//                       bottomNavigationBar: GestureDetector(
//                         onTap: () {
//                           checkSeatGoANdOnWay() ?? true
//                               ? Navigator.pop(context)
//                               : null;
//                         },
//                         child: Container(
//                           height: 70,
//                           child: BottomNavigator(child: Text("Complete")),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.all(10),
//             width: 400,
//             child: NewBox(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 50,
//                     child: Row(
//                       children: [
//                         Icon(Icons.airline_seat_recline_extra),
//                         SizedBox(width: 10),
//                         Text(
//                           "Seat",
//                           maxLines: 1,
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.w800),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: media.width * 0.8,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(right: media.width * 0.4),
//                           child: Text(
//                             "${widget.go} ---> ${widget.to}",
//                             maxLines: 1,
//                             style: TextStyle(
//                                 fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: media.width * 0.4),
//                           child: Row(
//                             children: [
//                               Icon(Icons.add_box,
//                                   color: Color.fromARGB(255, 173, 157, 8)),
//                               SizedBox(width: 2),
//                               Text(
//                                 "Seat",
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Color.fromARGB(255, 173, 157, 8)),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }

//   Widget Luggage(Size media) {
//     if (widget.isRouterGoAndBack ?? true) {
//       return Container(
//         height: 150,
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               checkInput();
//             });
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             width: 400,
//             child: NewBox(
//                 child: Column(
//               children: [
//                 Container(
//                   height: 40,
//                   child: Row(
//                     children: [
//                       Icon(Icons.work_history),
//                       Text(
//                         "Luggage",
//                         maxLines: 1,
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w800),
//                       )
//                     ],
//                   ),
//                 ),
//                 //
//                 Container(
//                   width: media.width * 0.8,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(right: media.width * 0.4),
//                         child: Text(
//                           "${widget.go} ---> ${widget.to}",
//                           //Departure + return
//                           maxLines: 1,
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: media.width * 0.4),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.add_box,
//                               color: Color.fromARGB(255, 173, 157, 8),
//                             ),
//                             SizedBox(
//                               width: 2,
//                             ),
//                             Text(
//                               "Extra Luggage Pack",
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Color.fromARGB(255, 173, 157, 8)),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: media.width * 0.8,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(right: media.width * 0.4),
//                         child: Text(
//                           "${widget.to} ---> ${widget.go}",
//                           //Departure + return
//                           maxLines: 1,
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: media.width * 0.4),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.add_box,
//                               color: Color.fromARGB(255, 173, 157, 8),
//                             ),
//                             SizedBox(
//                               width: 2,
//                             ),
//                             Text(
//                               "Extra Luggage Pack",
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Color.fromARGB(255, 173, 157, 8)),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             )),
//           ),
//         ),
//       );
//     } else {
//       return Container(
//         height: 150,
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               checkInput();
//             });
//           },
//           child: Container(
//             padding: EdgeInsets.all(10),
//             width: 400,
//             child: NewBox(
//                 child: Column(
//               children: [
//                 Container(
//                   height: 50,
//                   child: Row(
//                     children: [
//                       Icon(Icons.work_history),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "Luggage",
//                         maxLines: 1,
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w800),
//                       )
//                     ],
//                   ),
//                 ),
//                 //
//                 Container(
//                   width: media.width * 0.8,
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(right: media.width * 0.4),
//                         child: Text(
//                           "${widget.go} ---> ${widget.to}",
//                           //Departure + return
//                           maxLines: 1,
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: media.width * 0.4),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.add_box,
//                               color: Color.fromARGB(255, 173, 157, 8),
//                             ),
//                             SizedBox(
//                               width: 2,
//                             ),
//                             Text(
//                               "Extra Luggage Pack",
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Color.fromARGB(255, 173, 157, 8)),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             )),
//           ),
//         ),
//       );
//     }
//   }

//   Center GoogleMapGo(String map) {
//     return Center(
//       child: Container(
//         child: Column(
//           children: [
//             Text(map),
//             SizedBox(height: 10), // Khoảng cách giữa Text và hàng ghế
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     for (int i = 1; i <= callbackSeate / 4; i++)
//                       SeatGoAndOnwWay('$map$i')
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Center GoogleMapCallback(String map) {
//     return Center(
//       child: Container(
//         child: Column(
//           children: [
//             Text(map),
//             SizedBox(height: 10), // Khoảng cách giữa Text và hàng ghế
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     for (int i = 1; i <= callbackSeate1 / 4; i++)
//                       SeatCallback('$map$i')
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   //! one way
//   Center GoogleMapOnway(String map) {
//     return Center(
//       child: Container(
//         child: Column(
//           children: [
//             Text(map),
//             SizedBox(height: 10), // Khoảng cách giữa Text và hàng ghế
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     for (int i = 1; i <= onwayseat / 4; i++)
//                       SeatGoAndOnwWay('$map$i') // Tạo các ghế trong hàng A
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget SeatGoAndOnwWay(String seatNumber) {
//     bool isLocked = seatGo.contains(seatNumber);
//     //! list<seateGo>
//     bool isAlreadySelected = customerChooseSeatGo.contains(seatNumber);

//     return GestureDetector(
//       onTap: () {
//         if (isLocked) {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Seat Unavailable"),
//                 content: Text(
//                     "This seat has already been selected by someone else."),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text("OK"),
//                   ),
//                 ],
//               );
//             },
//           );
//         } else if (isAlreadySelected) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Seat $seatNumber has already been selected."),
//             ),
//           );
//           // print("Seat $seatNumber is already selected.");
//         } else {
//           // Nếu ghế có sẵn và chưa được chọn, người dùng có thể chọn ghế
//           print("Seat $seatNumber selected.");
//           customerChooseSeatGo.add(seatNumber);

//           // Thực hiện các hành động khác khi người dùng chọn ghế
//         }
//       },
//       child: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: isAlreadySelected
//               ? Colors.grey[300]
//               : Colors.white, // Đổi màu của ghế nếu đã được chọn
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.airline_seat_recline_normal,
//               size: 20,
//               color: isLocked
//                   ? Colors.red
//                   : Colors.blue, // Đổi màu của biểu tượng ghế nếu đã được chọn
//             ),
//             Text(
//               seatNumber,
//               style: TextStyle(fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget SeatCallback(String seatNumber) {
//     bool isLocked =
//         seatCallback.contains(seatNumber); // Kiểm tra xem ghế có bị khóa không

//     bool isAlreadySelected = customerChooseSeatCallback.contains(seatNumber);

//     return GestureDetector(
//       onTap: () {
//         if (isLocked) {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Seat Unavailable"),
//                 content: Text(
//                     "This seat has already been selected by someone else."),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text("OK"),
//                   ),
//                 ],
//               );
//             },
//           );
//         } else if (isAlreadySelected) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Seat $seatNumber has already been selected."),
//             ),
//           );
//           // print("Seat $seatNumber is already selected.");
//         } else {
//           // Nếu ghế có sẵn và chưa được chọn, người dùng có thể chọn ghế
//           print("Seat $seatNumber selected.");
//           customerChooseSeatCallback.add(seatNumber);

//           // Thực hiện các hành động khác khi người dùng chọn ghế
//         }
//       },
//       child: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: isAlreadySelected
//               ? Colors.grey[300]
//               : Colors.white, // Đổi màu của ghế nếu đã được chọn
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.airline_seat_recline_normal,
//               size: 20,
//               color: isLocked
//                   ? Colors.red
//                   : Colors.blue, // Đổi màu của biểu tượng ghế nếu đã được chọn
//             ),
//             Text(
//               seatNumber,
//               style: TextStyle(fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //! search Theo email tra ra cua nguoi nao thi nguoi do dc huong
