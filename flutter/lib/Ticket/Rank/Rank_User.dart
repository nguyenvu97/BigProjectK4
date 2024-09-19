// import 'dart:convert';

// import 'package:airlinesk3/Box/Infomation_Flight.dart';
// import 'package:airlinesk3/Box/New_Book_container.dart';
// import 'package:airlinesk3/Box/New_Box.dart';
// import 'package:airlinesk3/LogicService/Find_By_TicketOfDate_Service/Find_by_Ticket_of_date.dart';
// import 'package:airlinesk3/LogicService/Model/Fightinfo.dart';
// import 'package:airlinesk3/LogicService/Model/FlightTicket.dart';
// import 'package:airlinesk3/LogicService/Model/Order_ticket.dart';
// import 'package:airlinesk3/LogicService/Model/Promotion.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:gap/gap.dart';

// class RankUser extends StatefulWidget {
//   final ValueChanged<bool> onIsRouterCallbackChanged;
//   bool isRankUser;
//   List<Promotion> promotio;
//   bool isRouterGoAndBack;
//   int children;
//   int customer;
//   final Function()? onStepCompleted;
//   RankUser(
//       {super.key,
//       required this.promotio,
//       required this.customer,
//       required this.children,
//       required this.isRouterGoAndBack,
//       required this.onIsRouterCallbackChanged,
//       required this.onStepCompleted,
//       required this.isRankUser});

//   @override
//   State<RankUser> createState() => _RankUserState();
// }

// late List<bool> isSelectedGo;

// class _RankUserState extends State<RankUser> {
//   @override
//   void initState() {
//     super.initState();
//     isSelectedGo = List.generate(10, (_) => false);
//   }

//   int promotionId = 0;
//   double value = 0.0;

//   final storage = FlutterSecureStorage();
//   void getallOrderTicket() async {
//     if (widget.isRouterGoAndBack) {
//       //!! round_rip

//       String? flightInfoGo = await storage.read(key: "fightGo");
//       String? flightInfoCallBack = await storage.read(key: "fightCallback");

//       // Chuyển đổi thông tin chuyến bay từ chuỗi thành đối tượng FlightInfoStore
//       FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo!);
//       FlightInfoStore flightCallback =
//           FlightInfoStore.fromString(flightInfoCallBack!);
//       String? orderNoGo = await storage.read(key: "orderTiketGo");
//       String? orderNoCallback = await storage.read(key: "orderTiketCallback");
//       if (orderNoGo != null && orderNoCallback != null) {
//         List<OrderTicket> orderTicketGo = List<OrderTicket>.from(
//             jsonDecode(orderNoGo).map((item) => OrderTicket.fromJson(item)));
//         List<OrderTicket> orderTicketCallback = List<OrderTicket>.from(
//             jsonDecode(orderNoCallback)
//                 .map((item) => OrderTicket.fromJson(item)));
//         orderTicketGo.forEach((element) {
//           element.promotionId = promotionId;
//         });
//         orderTicketCallback.forEach((element) {
//           element.promotionId = promotionId;
//         });

//         String? totalMoney = await storage.read(key: "totalMoney");
//         if (totalMoney != null) {
//           await storage.write(key: "discount", value: value.toString());
//           await storage.write(key: "totalMoney", value: totalMoney.toString());
//         }

//         // String orderTicketGoJson = jsonEncode(orderTicketGo);
//         // storage.write(key: "orderTiketGo", value: orderTicketGoJson);
//         // String orderTicketCallbackJson = jsonEncode(orderTicketCallback);
//         // storage.write(
//         //     key: "orderTiketCallback", value: orderTicketCallbackJson);

//         print(orderTicketGo);
//         FlightTicket? flightTicket1 = await FindByTicket1().createTicket(
//           int.parse(flightGo.flightId),
//           int.parse(flightCallback.flightId),
//           widget.children,
//           widget.customer,
//           orderTicketGo,
//           orderTicketCallback,
//         );
//         String orderNo = jsonEncode(flightTicket1);
//         storage.write(key: "orderNo", value: orderNo);
//         widget.onStepCompleted?.call();
//       }
//     }

//     //!! one way
//     else {
//       String? flightInfoGo = await storage.read(key: "fightGo");

//       // Chuyển đổi thông tin chuyến bay từ chuỗi thành đối tượng FlightInfoStore
//       FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo!);
//       String? totalMoney = await storage.read(key: "totalMoney");
//       if (totalMoney != null) {
//         await storage.write(key: "discount", value: value.toString());
//         await storage.write(key: "totalMoney", value: totalMoney.toString());
//       }
//       String? OrderNoGo = await storage.read(key: "orderTiketGo");
//       if ((OrderNoGo != null)) {
//         List<OrderTicket> orderTicketGo = List<OrderTicket>.from(
//             jsonDecode(OrderNoGo).map((item) => OrderTicket.fromJson(item)));
//         orderTicketGo.forEach((element) {
//           element.promotionId = promotionId;
//         });

//         FlightTicket? flightTicket1 = await FindByTicket1().createTicket(
//           int.parse(flightGo.flightId),
//           0,
//           widget.children,
//           widget.customer,
//           orderTicketGo,
//           null,
//         );
//         String orderNo = jsonEncode(flightTicket1);
//         storage.write(key: "orderNo", value: orderNo);
//         widget.onStepCompleted?.call();
//       }
//     }
//   }

//   bool isBox = false;
//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Container(
//       height: 720,
//       width: 430,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.promotio.length,
//               itemBuilder: (context, index) {
//                 final item = widget.promotio[index];
//                 return Container(
//                   padding: EdgeInsets.all(10),
//                   child: NewBooxCOntainer(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               for (int i = 0; i < isSelectedGo.length; i++) {
//                                 isSelectedGo[i] = false;
//                               }
//                               if (!isSelectedGo[index]) {
//                                 isSelectedGo[index] = true;
//                                 bool newIsRank = !widget.isRankUser;
//                                 widget.onIsRouterCallbackChanged(newIsRank);
//                                 promotionId = widget.promotio[index].id;
//                                 value = widget.promotio[index].value;
//                                 print('Selected promotion ID: $promotionId');
//                               }
//                             });
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(top: 35, right: 2),
//                             height: 30,
//                             width: 30,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(width: 2, color: Colors.black),
//                               color: isSelectedGo[index]
//                                   ? const Color.fromARGB(255, 64, 136, 196)
//                                   : Colors.transparent,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: Image.asset(
//                             "assets/card.jpeg",
//                             fit: BoxFit.fill,
//                             width: 120,
//                             height: 100,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 8,
//                           width: 10,
//                         ),
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 6),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Promotion: ${item.promotionNam}",
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 SizedBox(height: 4),
//                                 GestureDetector(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return Container(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 20),
//                                             height: media.height * 0.2,
//                                             width: media.width * 1,
//                                             child: Text(
//                                               "Describe :${item.describe}",
//                                               style: textStyle,
//                                             ),
//                                           );
//                                         });
//                                   },
//                                   child: Text(
//                                     "Describe: ${item.describe}",
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   "Value: ${item.value * 100}%",
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//               height: 10), // Add some space between the ListView and the button
//           GestureDetector(
//             onTap: () {
//               getallOrderTicket();
//             },
//             child: Container(
//               height: 50, // Adjust the height as needed
//               width: 400,
//               child: NewBox(
//                 child: Text(
//                   "Continue",
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
