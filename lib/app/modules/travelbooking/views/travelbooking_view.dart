import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/travelbooking_controller.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:dropdown_search/dropdown_search.dart';

class TravelbookingView extends GetView<TravelbookingController> {
  const TravelbookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flight Booking")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Origin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            LocationSelector(
              label: "Origin",
              onLocationSelected: (country, city) {
                print("Origin Selected: $city, $country");
              },
            ),
            SizedBox(height: 30),
            Text("Destination", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            LocationSelector(
              label: "Destination",
              onLocationSelected: (country, city) {
                print("Destination Selected: $city, $country");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LocationSelector extends StatefulWidget {
  final String label;
  final Function(String country, String city) onLocationSelected;

  const LocationSelector({required this.label, required this.onLocationSelected});

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String? selectedCountryIso;
  String? selectedCountryName;
  bool isLoadingCities = false;
  List<csc.City> availableCities = [];

  // 1. Fetch all Countries
  Future<List<csc.Country>> getCountries(String filter) async {
    return await csc.getAllCountries();
  }

  // 2. Fetch all Cities
  Future<void> loadCities(String countryIso) async {
    setState(() {
      isLoadingCities = true;
      availableCities = [];
    });

    try {
      List<csc.State> states = await csc.getStatesOfCountry(countryIso);
      List<csc.City> allCities = [];
      for (var state in states) {
        var cities = await csc.getStateCities(countryIso, state.isoCode);
        allCities.addAll(cities);
      }

      setState(() {
        availableCities = allCities;
        isLoadingCities = false;
      });
    } catch (e) {
      setState(() {
        isLoadingCities = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ------------------------
        // COUNTRY DROPDOWN
        // ------------------------
        DropdownSearch<csc.Country>(
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(hintText: "Search Country..."),
            ),
          ),
          itemAsString: (csc.Country c) => c.name,

          // FIX 1: Add compareFn (Required for Object types)
          compareFn: (item1, item2) => item1.isoCode == item2.isoCode,

          items: (String filter, LoadProps? loadProps) => getCountries(filter),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: "${widget.label} Country",
              border: OutlineInputBorder(),
            ),
          ),
          onChanged: (csc.Country? country) {
            if (country != null) {
              setState(() {
                selectedCountryIso = country.isoCode;
                selectedCountryName = country.name;
              });
              loadCities(country.isoCode);
            }
          },
        ),

        SizedBox(height: 15),

        // ------------------------
        // CITY DROPDOWN
        // ------------------------
        DropdownSearch<csc.City>(
          enabled: selectedCountryIso != null,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(hintText: "Search City..."),
            ),
          ),
          itemAsString: (csc.City c) => c.name,

          // FIX 2: Add compareFn (Required for Object types)
          compareFn: (item1, item2) => item1.name == item2.name,

          items: (String filter, LoadProps? loadProps) => availableCities,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: isLoadingCities
                  ? "Loading Cities..."
                  : "${widget.label} City",
              border: OutlineInputBorder(),
              suffixIcon: isLoadingCities
                  ? Transform.scale(scale: 0.5, child: CircularProgressIndicator())
                  : null,
            ),
          ),
          onChanged: (csc.City? city) {
            if (city != null && selectedCountryName != null) {
              widget.onLocationSelected(selectedCountryName!, city.name);
            }
          },
        ),
      ],
    );
  }
}