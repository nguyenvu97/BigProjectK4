// import 'package:airlinesk3/Views/Appbar/MyAppbar.dart';
// import 'package:flutter/material.dart';

// class chidInputdata extends StatefulWidget {

//   const chidInputdata({super.key,});

//   @override
//   State<chidInputdata> createState() => _chidInputdataState();
// }

// class _chidInputdataState extends State<chidInputdata> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: GestureDetector(
//         onTap: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (BuildContext context) {
//               return Scaffold(
//                 appBar: CustomAppBar(
//                   name: "Enter Information",
//                 ),
//                 body: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     children: [
//                       for (int i = 0; i < widget.customer; i++)
//                         Column(
//                           children: [
//                             NewBox(
//                               child: Text(
//                                 "Adult${i + 1}",
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),

//                             //!!   Adult
//                             Container(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.all(5),
//                                       width: 70,
//                                       height: 60,
//                                       child: NewBox(
//                                         child: DropdownButton<String>(
//                                           value: aliases.isNotEmpty
//                                               ? aliases
//                                               : null,
//                                           items: Aliases1.map((String value) {
//                                             return DropdownMenuItem<String>(
//                                               value: value,
//                                               child: Text(value),
//                                             );
//                                           }).toList(),
//                                           onChanged: (String? newValue) {
//                                             setState(() {
//                                               aliases = newValue!;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 4,
//                                     child: Container(
//                                       width: media.width * 0.8,
//                                       child: TextFailInput(
//                                         obscureText: false,
//                                         controller: adultNameControllers[i],
//                                         textName: "FullName",
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             TextFailInput(
//                               obscureText: false,
//                               textName: "Phone",
//                               controller: adultPhoneController[i],
//                             ),
//                             TextFailInput(
//                               obscureText: false,
//                               textName: "email",
//                               controller: adultEmailController[i],
//                             ),
//                           ],
//                         ),
//                       // Hiển thị thông tin cho trẻ em
//                       Column(
//                         children: [
//                           for (int i = 0; i < widget.children; i++)
//                             Column(
//                               children: [
//                                 NewBox(
//                                   child: Text(
//                                     "Child${i + 1}",
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           padding: EdgeInsets.all(5),
//                                           width: 70,
//                                           height: 60,
//                                           child: NewBox(
//                                             child: DropdownButton<String>(
//                                               value: aliases.isNotEmpty
//                                                   ? aliases
//                                                   : null,
//                                               items:
//                                                   Aliases1.map((String value) {
//                                                 return DropdownMenuItem<String>(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (String? newValue) {
//                                                 setState(() {
//                                                   aliases = newValue!;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 4,
//                                         child: Container(
//                                           width: media.width * 0.8,
//                                           child: TextFailInput(
//                                             obscureText: false,
//                                             controller: childNameControllers[i],
//                                             textName: "FullName",
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 TextFailInput(
//                                   obscureText: false,
//                                   textName: "Phone",
//                                   controller: childPhoneControllers[i],
//                                 ),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // bottomNavigationBar: GestureDetector(
//                 //   onTap: () {
//                 //     Navigator.pop(context);
//                 //   },
//                 //   child: Container(
//                 //     height: 70,
//                 //     child: BottomNavigator(child: Text("Complete")),
//                 //   ),
//                 // ),
//               );
//             },
//           );
//         },
//         child: Container(
//           padding: EdgeInsets.all(20),
//           width: 400,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: NewBooxCOntainer(
//                 child: Column(
//               children: [
//                 Container(
//                   height: 30,
//                   child: Row(
//                     children: [
//                       Icon(Icons.person_add_alt_1),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "Customer information",
//                         maxLines: 1,
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w800),
//                       )
//                     ],
//                   ),
//                 ),

//                 //
//                 Container(
//                   height: 400,
//                   child: ListView.builder(
//                     itemCount: checkNumber(),
//                     itemBuilder: (context, index) {
//                       if (index == 0 || widget.children == 0) {
//                         return Container(
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 child: Text(
//                                   "Passengers - Adults",
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.add_box,
//                                       color: Color.fromARGB(255, 173, 157, 8),
//                                     ),
//                                     SizedBox(width: 2),
//                                     Container(
//                                       margin: EdgeInsets.only(
//                                           right: media.width * 0.1),
//                                       child: Text(
//                                         "Enter Information for Adult",
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color:
//                                               Color.fromARGB(255, 173, 157, 8),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else if (index == 1) {
//                         // Container cho trẻ em
//                         return Container(
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 child: Text(
//                                   "Passengers - Children",
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.add_box,
//                                       color: Color.fromARGB(255, 173, 157, 8),
//                                     ),
//                                     SizedBox(width: 2),
//                                     Container(
//                                       margin: EdgeInsets.only(
//                                           right: media.width * 0.1),
//                                       child: Text(
//                                         "Enter Information for Child",
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color:
//                                               Color.fromARGB(255, 173, 157, 8),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         // Trường hợp không xác định, không hiển thị gì cả
//                         return SizedBox.shrink();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             )),
//           ),
//         ),
//       ),
//     );
//   }
// }
