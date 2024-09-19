import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_4/Sevice_Api/Gex_Controller/Hotel_Getx_Controller.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final Hotel_Controller hotelController = Get.put(Hotel_Controller());

  final Map<String, List<String>> countriesAndCities = {
    'Vietnam': ['Hanoi', 'Ho Chi Minh City', 'Da Nang'],
    'Thailand': ['Bangkok', 'Chiang Mai', 'Phuket'],
  };

  String? selectedCountry;
  List<String> cities = [];
  String? selectedCity;

  void _onCountryTap(String country) {
    setState(() {
      selectedCountry = country;
      cities = countriesAndCities[country]!;
      selectedCity = null; // Reset city selection
    });
  }

  void _onCityChanged(String? newCity) {
    setState(() {
      selectedCity = newCity;
    });
  }

  @override
  Widget build(BuildContext context) {
    var countries = countriesAndCities.keys.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Country and City Selector')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: countries.map((String country) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(country),
                        if (selectedCountry ==
                            country) // Show dropdown only for selected country
                          Container(
                            width: 140,
                            child: DropdownButton<String>(
                              dropdownColor: Colors.amber,
                              isExpanded: true,
                              iconEnabledColor:
                                  const Color.fromARGB(255, 0, 135, 246),
                              borderRadius: BorderRadius.circular(20),
                              value: selectedCity,
                              onChanged: _onCityChanged,
                              items: cities.map((String city) {
                                return DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(city),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                    onTap: () => _onCountryTap(country),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
