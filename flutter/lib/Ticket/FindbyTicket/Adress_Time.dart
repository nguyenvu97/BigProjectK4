import 'package:flutter/material.dart';
import 'package:flutter_application_4/Common/Box_Container/New_Box.dart';
import 'package:flutter_application_4/Common/ShowSuccessController.dart';
import 'package:flutter_application_4/Common/Text_Data.dart';
import 'package:flutter_application_4/Sevice_Api/Gex_Controller/Ariport_Getx_Controller.dart';
import 'package:flutter_application_4/Sevice_Api/Gex_Controller/Ticket_Getx.Controller.dart';
import 'package:flutter_application_4/Ticket/FindbyTicket/Show_Menu.dart';
import 'package:flutter_application_4/model/Ariport.dart';
import 'package:get/get.dart';

class AdressAndTime extends StatefulWidget {
  AdressAndTime({super.key});

  @override
  State<AdressAndTime> createState() => _AdressAndTimeState();
}

class _AdressAndTimeState extends State<AdressAndTime> {
  Ariport_Controller ariport_controller = Get.put(Ariport_Controller());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AdressContainer(
              media,
              context,
              "Điểm Đi",
              true,
              ariport_controller.startCountry.value,
              ariport_controller.startCity.value),
          SizedBox(
            height: media.height * 0.07,
          ),
          AdressContainer(
              media,
              context,
              "Điểm Về",
              false,
              ariport_controller.endCountry.value,
              ariport_controller.endCity.value),
        ],
      ),
    );
  }

  void check_start_end() {
    if (ariport_controller.startCountry.value ==
        ariport_controller.endCountry.value) {
      showDialog1.confirm_Dialog(
          context, "Bạn hãy xác nhận lại điểm đến vs điểm đi", widget);
      ariport_controller.endCountry.value = '';
      ariport_controller.endCity.value = '';
    }
  }

  Container AdressContainer(Size media, BuildContext context, String text,
      bool isSelect, String country, String city) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white12, borderRadius: BorderRadius.circular(30)),
        height: media.height * 0.15,
        width: media.width * 0.3,
        child: Column(
          children: [
            SizedBox(
                height: 50,
                child: Text_Data(
                    name: text, color: Colors.black, size: 20, maxLine: 1)),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Show_Menu(
                      isSelect: isSelect,
                    );
                  },
                );
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text_Data(
                        name: country.isNotEmpty ? country : "+",
                        color: Colors.black,
                        size: 20,
                        maxLine: 1),
                    SizedBox(
                      height: 10,
                    ),
                    Text_Data(
                        name: country.isNotEmpty ? city : '',
                        color: Colors.black,
                        size: 20,
                        maxLine: 1)
                  ]),
            )
          ],
        ));
  }
}
