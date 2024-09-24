import 'package:flutter_application_4/Common/ShowSuccessController.dart';
import 'package:flutter_application_4/Sevice_Api/Airport_Service.dart';
import 'package:flutter_application_4/model/Ariport.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class Ariport_Controller extends GetxController {
  final ariport_service = AriportService();

  var startCountry = ''.obs;
  var startCity = ''.obs;
  var endCountry = ''.obs;
  var endCity = ''.obs;

  RxMap<String, List<Ariport>> menu = <String, List<Ariport>>{}.obs;
  var listdata = <Map<String, List<Ariport>>>[].obs;
  Future<void> getMenu() async {
    try {
      final data = await ariport_service.getMenu();
      if (data != null) {
        menu.value = data;
        listdata.add(menu.value);
      } else {
        print("loi ko lay dc data");
      }
    } catch (e) {
      print(e);
    }
  }

  void swapItems() {
    String swap = startCountry.value;
    String city = startCity.value;
    startCountry.value = endCountry.value;
    endCountry.value = swap;
    startCity.value = endCity.value;
    endCity.value = city;
  }
}
