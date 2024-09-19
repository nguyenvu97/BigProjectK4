// import 'dart:convert';

// import 'package:airlinesk3/Box/New_Book_container.dart';
// import 'package:airlinesk3/LogicService/Find_By_TicketOfDate_Service/Find_by_Ticket_of_date.dart';
// import 'package:airlinesk3/LogicService/Model/Fightinfo.dart';
// import 'package:airlinesk3/LogicService/Model/FlightTicket.dart';
// import 'package:airlinesk3/LogicService/Model/Order_ticket.dart';
// import 'package:airlinesk3/LogicService/Model/Promotion.dart';
// import 'package:airlinesk3/Views/Appbar/ButtonNavigator.dart';
// import 'package:airlinesk3/Views/Appbar/MyAppbar.dart';
// import 'package:airlinesk3/Views/Home/Home_pape.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:gap/gap.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';

// class PaymentTicket extends StatefulWidget {
//   bool isRouterGoAndBack;
//   String to;
//   String go;
//   int childer;
//   int customer;
//   List<Promotion> promotion;
//   PaymentTicket(
//       {super.key,
//       required this.isRouterGoAndBack,
//       required this.go,
//       required this.promotion,
//       required this.childer,
//       required this.customer,
//       required this.to});

//   @override
//   State<PaymentTicket> createState() => _PaymentTicketState();
// }

// bool isVnPaySelected = false;
// bool isZaloPaySelected = false;
// bool isPostpaidCardSelected = false;
// bool isMoMoWalletSelected = false;

// class _PaymentTicketState extends State<PaymentTicket> {
//   FlightTicket? flightTicket;

//   @override
//   void initState() {
//     discountvalue();
//     dataUser();
//     super.initState();
//   }

//   //! text style
//   TextStyle textStyle =
//       TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);

//   FlightInfoStore? flightGo1;
//   FlightInfoStore? flightCallback1; //! isRouterGoAndBack == true
//   double totalMoney1 = 0.0;
//   String seatClassTypeGO = "";
//   String seatClassTypeCallBack = "";
//   List<String> setClassGo = [];
//   List<String> setClassCallback = [];
//   List<OrderTicket>? orderTicketGo;
//   List<OrderTicket>? orderTicketCallback;

//   int promotionId = 0;
//   final storage = FlutterSecureStorage();
//   // ! infomation data one way and round rip  line 34 lien 35

//   void dataUser() async {
//     //! Round_rip ???????????????
//     if (widget.isRouterGoAndBack) {
//       String? _isSelectTiket = await storage.read(key: "_isSelectTiket");
//       String? _isSelectTiketCallback =
//           await storage.read(key: "__isSelectbusiness");
//       String? flightInfoGo = await storage.read(key: "fightGo");
//       String? flightInfoCallBack = await storage.read(key: "fightCallback");
//       FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo!);
//       FlightInfoStore flightCallback =
//           FlightInfoStore.fromString(flightInfoCallBack!);
//       String? totalMoney = await storage.read(key: "totalMoney");
//       String? orderNoGo = await storage.read(key: "orderTiketGo");
//       String? orderNoCallback = await storage.read(key: "orderTiketCallback");
//       if (orderNoGo != null && orderNoCallback != null) {
//         List<OrderTicket> orderTicketGo1 = List<OrderTicket>.from(
//             jsonDecode(orderNoGo).map((item) => OrderTicket.fromJson(item)));
//         List<OrderTicket> orderTicketCallback1 = List<OrderTicket>.from(
//             jsonDecode(orderNoCallback)
//                 .map((item) => OrderTicket.fromJson(item)));
//         orderTicketGo1.forEach((element) {
//           setState(() {
//             seatClassTypeGO = element.typeSeats;
//             promotionId = element.promotionId ?? 0;
//           });
//         });
//         orderTicketCallback1.forEach((element) {
//           setState(() {
//             seatClassTypeCallBack = element.typeSeats;
//             promotionId = element.promotionId ?? 0;
//           });
//         });
//         setState(() {
//           flightGo1 = flightGo;
//           flightCallback1 = flightCallback;
//           orderTicketGo = orderTicketGo1;
//           orderTicketCallback = orderTicketCallback1;
//           totalMoney1 = double.parse(totalMoney!);
//         });
//       }
//     }
//     //! one_way ???????????????
//     else {
//       String? _isSelectTiket = await storage.read(key: "_isSelectTiket");
//       String? flightInfoGo = await storage.read(key: "fightGo");
//       FlightInfoStore flightGo = FlightInfoStore.fromString(flightInfoGo!);
//       String? totalMoney = await storage.read(key: "totalMoney");
//       String? orderNoGo = await storage.read(key: "orderTiketGo");

//       if (orderNoGo != null) {
//         List<OrderTicket> orderTicketGo1 = List<OrderTicket>.from(
//             jsonDecode(orderNoGo).map((item) => OrderTicket.fromJson(item)));
//         orderTicketGo1.forEach((element) {
//           setState(() {
//             seatClassTypeGO = element.typeSeats;
//             promotionId = element.promotionId ?? 0;
//           });
//         });
//         setState(() {
//           flightGo1 = flightGo;
//           orderTicketGo = orderTicketGo1;

//           totalMoney1 = double.parse(totalMoney!);
//           print(orderTicketGo);
//         });
//       }
//     }
//   }
//   //!! patment vnpay

//   void OrderNoPaymant() async {
//     print(isVnPaySelected);
//     if (isVnPaySelected == true) {
//       String? orderNo = await storage.read(key: "orderNo");
//       FlightTicket? flightTicket1 = FlightTicket.fromString(orderNo!);
//       print(flightTicket1.ticketNo);
//       if (flightTicket1 != null) {
//         setState(() {
//           flightTicket = flightTicket1;
//         });
//         FindByTicket1().PaymentVnpay(flightTicket1.ticketNo).then((_) {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => HomePage()));
//           storage.delete(key: "__isSelectbusiness");
//           storage.delete(key: "orderTiketCallback ");
//           storage.delete(key: "orderTiketGo ");
//           storage.delete(key: "fightGo");
//           storage.delete(key: "fightCallback");
//           storage.delete(key: "orderNo");
//           storage.delete(key: "totalMoney");
//           storage.delete(key: "fightGo");
//           storage.delete(key: "discount");
//         });
//       }
//     } else {
//       return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Choose payment", style: textStyle),
//             content: Text(
//               "You need to choose payment",
//               style: textStyle,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () async {
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   double discountMoney = 0;

//   void discountvalue() async {
//     String? totalMoney = await storage.read(key: "totalMoney");
//     if (widget.promotion.isEmpty) {
//       setState(() {
//         discountMoney = 0;
//       });
//     } else {
//       String? discountValue = await storage.read(key: "discount");
//       if (discountValue != null && totalMoney != null) {
//         setState(() {
//           discountMoney =
//               double.parse(totalMoney) * double.parse(discountValue);
//           print(discountValue);
//           print(discountMoney);
//         });
//       } else {
//         print("loi disocunt");
//       }
//     }
//   }

//   NumberFormat currencyFormatter =
//       NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

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
//               height: media.height * 0.7,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     height: media.height * 0.1,
//                     width: media.width * 1,
//                     child: NewBooxCOntainer(
//                         child: Column(
//                       children: [
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: 20,
//                           width: media.width * 1,
//                           child: Text(
//                             "Total Money",
//                             maxLines: 1,
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                         Container(
//                           height: 30,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 flex: 3,
//                                 child: Container(
//                                   padding: EdgeInsets.only(left: 10),
//                                   child: Text(
//                                     currencyFormatter
//                                         .format(totalMoney1 - discountMoney),
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: TicketInfomationDetails(context, media),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     )),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     height: media.height * 0.6,
//                     child: NewBooxCOntainer(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: media.height * 0.06,
//                             padding: EdgeInsets.symmetric(horizontal: 10),
//                             width: media.width,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Payment Ticket",
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 Text("Please choose the payment method below.",
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500))
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 15),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isVnPaySelected = true;
//                                         isZaloPaySelected = false;
//                                         isPostpaidCardSelected = false;
//                                         isMoMoWalletSelected = false;
//                                       });
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: isVnPaySelected
//                                               ? Colors.blue
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                       child: PaymentMethor(
//                                         media,
//                                         "VnPay",
//                                         "https://play-lh.googleusercontent.com/2WHgcuwhtbmfrDEF-D-lYQ4sAk0TlI-aFtqx7lJXK5KV7f8smnofaedP_Opcd3edR2c",
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isVnPaySelected = false;
//                                         isZaloPaySelected = true;
//                                         isPostpaidCardSelected = false;
//                                         isMoMoWalletSelected = false;
//                                       });
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: isZaloPaySelected
//                                               ? Colors.blue
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                       child: PaymentMethor(
//                                         media,
//                                         "ZaloPay",
//                                         "https://play-lh.googleusercontent.com/MXoXRQvKYcPzk0AITb6nVJUxZMaWYESXar_HwK8KXbGMboZPQjcwVBcVtXlpOkfD7PM",
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isVnPaySelected = false;
//                                         isZaloPaySelected = false;
//                                         isPostpaidCardSelected = true;
//                                         isMoMoWalletSelected = false;
//                                       });
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: isPostpaidCardSelected
//                                               ? Colors.blue
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                       child: PaymentMethor(
//                                         media,
//                                         "Postpaid Card",
//                                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4TlKRYAzJxi4o1Kr7dgnQ111tOQfCwvHwKl8L977oQyqZ_TtnVO36ZUlDPya6jjNYfy0&usqp=CAU",
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isVnPaySelected = false;
//                                         isZaloPaySelected = false;
//                                         isPostpaidCardSelected = false;
//                                         isMoMoWalletSelected = true;
//                                       });
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: isMoMoWalletSelected
//                                               ? Colors.blue
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                       child: PaymentMethor(
//                                         media,
//                                         "MoMo Wallet",
//                                         "https://play-lh.googleusercontent.com/dQbjuW6Jrwzavx7UCwvGzA_sleZe3-Km1KISpMLGVf1Be5N6hN6-tdKxE5RDQvOiGRg",
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // /
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Container(
//                             height: 300,
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.vertical,
//                               child: Column(
//                                 children: [
//                                   Container(
//                                       width: media.width,
//                                       child: Container(
//                                         child: const Column(
//                                           children: [
//                                             Text(
//                                               'Conditions for changing tickets:',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 18),
//                                             ),
//                                             SizedBox(height: 10),
//                                             Text(
//                                               '1. Super economical Economy fare:',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             Text(
//                                               '- Vietnam domestic journey: not allowed',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             Text(
//                                               '- Other itineraries: not allowed or allowed with a fee/free of charge depending on the conditions of each fare type',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             // Add ticket change conditions here if needed
//                                             SizedBox(height: 20),
//                                             Text(
//                                               'Ticket refund conditions:',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 18),
//                                             ),
//                                             SizedBox(height: 10),
//                                             Text(
//                                               '1. Super economical Economy fare:',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             Text(
//                                               '- Vietnam domestic journey: not allowed',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             Text(
//                                               '- Other itineraries: not allowed or allowed with a fee/free of charge depending on the conditions of each fare type',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             Text(
//                                               '2. Other types of fares:',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             Text(
//                                               '- Allowed, charged or free depending on the conditions of each fare type',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             SizedBox(height: 20),
//                                             Text(
//                                               '3. If you choose different fare types, the strictest fare conditions will apply to the entire journey.',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             SizedBox(height: 20),
//                                             Text(
//                                               '4. Prepaid baggage fees and preferred seat selection are non-refundable.',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             Text(
//                                               '5. Good reservation and upgrade fees are non-changeable and non-refundable.',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             SizedBox(height: 20),
//                                           ],
//                                         ),
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             BottomNavigator(
//               child: GestureDetector(
//                 onTap: () {
//                   OrderNoPaymant();
//                 },
//                 child: Container(
//                   height: 50,
//                   child: Center(
//                       child: Text(
//                     "Payment",
//                     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                   )),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Container PaymentMethor(Size media, String name, String url) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Container(
//             height: 50,
//             width: 50,
//             decoration:
//                 BoxDecoration(image: DecorationImage(image: NetworkImage(url))),
//           ),
//           Container(
//             child: Text(
//               name,
//               maxLines: 1,
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget TicketInfomationDetails(BuildContext context, Size media) {
//     if (widget.isRouterGoAndBack) {
//       return GestureDetector(
//         onTap: () {
//           showModalBottomSheet(
//             isScrollControlled: true,
//             context: context,
//             builder: (BuildContext context) {
//               return Container(
//                 height: media.height * 0.7,
//                 child: Scaffold(
//                   appBar: CustomAppBar(
//                     name: "Information Details",
//                   ),
//                   body: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           height: media.height * 0.7,
//                           width: media.width * 1,
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 flex: 2,
//                                 child: NewBooxCOntainer(
//                                     child: Container(
//                                         width: media.width * 1,
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                               child: Text(
//                                                 "Round_trip",
//                                                 style: textStyle,
//                                               ),
//                                             ),
//                                             Container(
//                                               height: 70,
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Container(
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                                     top: 10),
//                                                             child: Text(
//                                                                 "${widget.go}",
//                                                                 style:
//                                                                     textStyle)),
//                                                       ),
//                                                       Expanded(
//                                                         child: Container(
//                                                             child: Text(
//                                                           "${flightGo1!.departureTime.hour.toInt()}H ${flightGo1!.departureTime.minute.toString()}M",
//                                                           maxLines: 1,
//                                                           style: textStyle,
//                                                         )),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         // Container(
//                                                         //   child: Text("${sum_Time_Go}H"),
//                                                         // ),
//                                                         Container(
//                                                           child: Row(
//                                                             children: [
//                                                               Text(
//                                                                   "---------------"),
//                                                               Icon(Icons
//                                                                   .airplanemode_on)
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           child: Text(flightGo1!
//                                                               .flightNumber),
//                                                         ),
//                                                       ]),
//                                                   Column(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Container(
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                                     top: 10),
//                                                             child: Text(
//                                                               "${widget.to}",
//                                                               style: textStyle,
//                                                             )),
//                                                       ),
//                                                       Expanded(
//                                                         child: Container(
//                                                             child: Text(
//                                                           "${flightGo1!.arrivalTime.hour.toInt()}H ${flightGo1!.arrivalTime.minute.toString()}M",
//                                                           maxLines: 1,
//                                                           style: textStyle,
//                                                         )),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),

//                                             //!! callabck
//                                             Container(
//                                               height: 70,
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Container(
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                                     top: 10),
//                                                             child: Text(
//                                                                 "${widget.to}",
//                                                                 style:
//                                                                     textStyle)),
//                                                       ),
//                                                       Expanded(
//                                                         child: Container(
//                                                             child: Text(
//                                                           "${flightCallback1!.departureTime.hour.toInt()}H ${flightCallback1!.departureTime.minute.toString()}M",
//                                                           maxLines: 1,
//                                                           style: textStyle,
//                                                         )),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         // Container(
//                                                         //   child: Text("${sum_Time_Go}H"),
//                                                         // ),
//                                                         Container(
//                                                           child: Row(
//                                                             children: [
//                                                               Text(
//                                                                   "---------------"),
//                                                               Icon(Icons
//                                                                   .airplanemode_on)
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           child: Text(
//                                                               flightCallback1!
//                                                                   .flightNumber),
//                                                         ),
//                                                       ]),
//                                                   Column(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Container(
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                                     top: 10),
//                                                             child: Text(
//                                                               "${widget.go}",
//                                                               style: textStyle,
//                                                             )),
//                                                       ),
//                                                       Expanded(
//                                                         child: Container(
//                                                             child: Text(
//                                                           "${flightCallback1!.arrivalTime.hour.toInt()}H ${flightCallback1!.arrivalTime.minute.toString()}M",
//                                                           maxLines: 1,
//                                                           style: textStyle,
//                                                         )),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),

//                                             Container(
//                                               child: Column(children: [
//                                                 //! toltal Money
//                                                 Container(
//                                                   child: Row(
//                                                     children: [
//                                                       Icon(Icons.attach_money),
//                                                       Text(
//                                                         "Review Trip cost",
//                                                         style: TextStyle(
//                                                             fontSize: 20,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 20),
//                                                   child: Row(
//                                                     children: [
//                                                       Expanded(
//                                                           child: Text(
//                                                         "Fare",
//                                                         style: textStyle,
//                                                       )),
//                                                       Expanded(
//                                                         child: Text(
//                                                           currencyFormatter
//                                                               .format(
//                                                                   totalMoney1),
//                                                           style: textStyle,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 20),
//                                                   child: Row(
//                                                     children: [
//                                                       Expanded(
//                                                           child: Text(
//                                                         "Discounts",
//                                                         style: textStyle,
//                                                       )),
//                                                       Expanded(
//                                                         child: Text(
//                                                           discountMoney
//                                                               .toString(),
//                                                           style: textStyle,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 20),
//                                                   child: Row(
//                                                     children: [
//                                                       Expanded(
//                                                           child: Text(
//                                                         "Total Money",
//                                                         style: textStyle,
//                                                       )),
//                                                       Expanded(
//                                                         child: Text(
//                                                           currencyFormatter.format(
//                                                               totalMoney1 -
//                                                                   discountMoney),
//                                                           style: textStyle,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ]),
//                                             ),
//                                             Container(
//                                               child: Column(children: [
//                                                 Container(
//                                                   child: Row(
//                                                     children: [
//                                                       Icon(Icons.person),
//                                                       Text(
//                                                         "Passenger infomation",
//                                                         style: TextStyle(
//                                                             fontSize: 20,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Container(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal: 20),
//                                                         height:
//                                                             200, // Đặt chiều cao ở đây tùy ý
//                                                         child: ListView.builder(
//                                                           itemCount:
//                                                               orderTicketGo!
//                                                                   .length,
//                                                           itemBuilder:
//                                                               (context, index) {
//                                                             final orderTicket =
//                                                                 orderTicketGo![
//                                                                     index];
//                                                             return Column(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .start,
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Text(
//                                                                     "${widget.go} ---> ${widget.to}",
//                                                                     style:
//                                                                         textStyle,
//                                                                   ),
//                                                                   Gap(10),
//                                                                   Text(
//                                                                     "Customer ${index}",
//                                                                     style:
//                                                                         textStyle,
//                                                                   ),
//                                                                   Text(
//                                                                       "Full Name: ${orderTicket.fullName}"),
//                                                                   Text(
//                                                                       "Email: ${orderTicket.email}"),
//                                                                   Text(
//                                                                       "Seat Number: ${orderTicket.numberSeats}"),
//                                                                   Text(
//                                                                       "Full Name: ${orderTicket.numberSeats}"),
//                                                                   Text(
//                                                                       "SeatClass: ${orderTicket.typeSeats}"),
//                                                                   Text(
//                                                                       "Customer: ${orderTicket.customType}"),
//                                                                 ]);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       child: Container(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal: 20),
//                                                         height:
//                                                             200, // Đặt chiều cao ở đây tùy ý
//                                                         child: ListView.builder(
//                                                           itemCount:
//                                                               orderTicketCallback!
//                                                                   .length,
//                                                           itemBuilder:
//                                                               (context, index) {
//                                                             final orderTicket =
//                                                                 orderTicketCallback![
//                                                                     index];
//                                                             return Column(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .start,
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Text(
//                                                                       "${widget.to} ---> ${widget.go}",
//                                                                       style:
//                                                                           textStyle),
//                                                                   Gap(10),
//                                                                   Text(
//                                                                     "Customer ${index}",
//                                                                     style:
//                                                                         textStyle,
//                                                                   ),
//                                                                   Text(
//                                                                       "Full Name: ${orderTicket.fullName}"),
//                                                                   Text(
//                                                                       "Email: ${orderTicket.email}"),
//                                                                   Text(
//                                                                       "Seat Number: ${orderTicket.numberSeats}"),
//                                                                   Text(
//                                                                       "Full Name: ${orderTicket.numberSeats}"),
//                                                                   Text(
//                                                                       "SeatClass: ${orderTicket.typeSeats}"),
//                                                                   Text(
//                                                                       "Customer: ${orderTicket.customType}"),
//                                                                 ]);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )
//                                               ]),
//                                             )
//                                           ],
//                                         ))),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   bottomNavigationBar: Container(
//                     height: 70,
//                     child: BottomNavigator(
//                         child: Text(
//                       "Continue",
//                       maxLines: 1,
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     )),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         child: Container(child: Icon(Icons.arrow_drop_down)),
//       );
//     } else {
//       return GestureDetector(
//         onTap: () {
//           showModalBottomSheet(
//             isScrollControlled: true,
//             context: context,
//             builder: (BuildContext context) {
//               return Container(
//                 height: media.height * 0.8,
//                 child: Scaffold(
//                   appBar: CustomAppBar(
//                     name: "Information Details",
//                   ),
//                   body: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           height: media.height * 0.7,
//                           width: media.width * 1,
//                           child: Column(
//                             children: [
//                               NewBooxCOntainer(
//                                   child: Container(
//                                       width: media.width * 1,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             child: Text(
//                                               "One_way",
//                                               style: textStyle,
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 70,
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 10),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Column(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Container(
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                   top: 10),
//                                                           child: Text(
//                                                               "${widget.go}",
//                                                               style:
//                                                                   textStyle)),
//                                                     ),
//                                                     Expanded(
//                                                       child: Container(
//                                                           child: Text(
//                                                         "${flightGo1!.departureTime.hour.toInt()}H ${flightGo1!.departureTime.minute.toString()}M",
//                                                         maxLines: 1,
//                                                         style: textStyle,
//                                                       )),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       // Container(
//                                                       //   child: Text("${sum_Time_Go}H"),
//                                                       // ),
//                                                       Container(
//                                                         child: Row(
//                                                           children: [
//                                                             Text(
//                                                                 "---------------"),
//                                                             Icon(Icons
//                                                                 .airplanemode_on)
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         child: Text(flightGo1!
//                                                             .flightNumber),
//                                                       ),
//                                                     ]),
//                                                 Column(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Container(
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                   top: 10),
//                                                           child: Text(
//                                                             "${widget.to}",
//                                                             style: textStyle,
//                                                           )),
//                                                     ),
//                                                     Expanded(
//                                                       child: Container(
//                                                           child: Text(
//                                                         "${flightGo1!.arrivalTime.hour.toInt()}H ${flightGo1!.arrivalTime.minute.toString()}M",
//                                                         maxLines: 1,
//                                                         style: textStyle,
//                                                       )),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),

//                                           //! infomation user by ticket
//                                           Container(
//                                             child: Column(children: [
//                                               //! toltal Money
//                                               Container(
//                                                 child: Row(
//                                                   children: [
//                                                     Icon(Icons.attach_money),
//                                                     Text(
//                                                       "Review Trip cost",
//                                                       style: TextStyle(
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 20),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                         child: Text(
//                                                       "Fare",
//                                                       style: textStyle,
//                                                     )),
//                                                     Expanded(
//                                                       child: Text(
//                                                         currencyFormatter
//                                                             .format(
//                                                                 totalMoney1),
//                                                         style: textStyle,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 20),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                         child: Text(
//                                                       "Discounts",
//                                                       style: textStyle,
//                                                     )),
//                                                     Expanded(
//                                                       child: Text(
//                                                         discountMoney
//                                                             .toString(),
//                                                         style: textStyle,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 20),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                         child: Text(
//                                                       "Total Money",
//                                                       style: textStyle,
//                                                     )),
//                                                     Expanded(
//                                                       child: Text(
//                                                         currencyFormatter.format(
//                                                             totalMoney1 -
//                                                                 discountMoney),
//                                                         style: textStyle,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ]),
//                                           ),
//                                           //! passenger infomation
//                                           Container(
//                                             child: Column(children: [
//                                               Container(
//                                                 child: Row(
//                                                   children: [
//                                                     Icon(Icons.person),
//                                                     Text(
//                                                       "Passenger infomation",
//                                                       style: TextStyle(
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 20),
//                                                 height:
//                                                     200, // Đặt chiều cao ở đây tùy ý
//                                                 child: ListView.builder(
//                                                   itemCount:
//                                                       orderTicketGo!.length,
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     final orderTicket =
//                                                         orderTicketGo![index];
//                                                     return Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Gap(10),
//                                                           Text(
//                                                             "Customer ${index}",
//                                                             style: textStyle,
//                                                           ),
//                                                           Text(
//                                                               "Full Name: ${orderTicket.fullName}"),
//                                                           Text(
//                                                               "Email: ${orderTicket.email}"),
//                                                           Text(
//                                                               "Seat Number: ${orderTicket.numberSeats}"),
//                                                           Text(
//                                                               "Full Name: ${orderTicket.numberSeats}"),
//                                                           Text(
//                                                               "SeatClass: ${orderTicket.typeSeats}"),
//                                                           Text(
//                                                               "Customer: ${orderTicket.customType}"),
//                                                         ]);
//                                                   },
//                                                 ),
//                                               )
//                                             ]),
//                                           )
//                                         ],
//                                       ))),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   bottomNavigationBar: Container(
//                     height: 70,
//                     child: BottomNavigator(
//                         child: Text(
//                       "Continue",
//                       maxLines: 1,
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     )),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         child: Container(child: Icon(Icons.arrow_drop_down)),
//       );
//     }
//   }
// }
