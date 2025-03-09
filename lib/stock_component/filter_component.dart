import 'package:flutter/material.dart';

class FilterComponent extends StatefulWidget {
  const FilterComponent({super.key});

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  // Store selected values
  Map<String, String?> dropdownValues = {};
  Map<String, bool> checkboxValues = {};
  final TextEditingController stockNumberController = TextEditingController();
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize checkbox values
    for (var label in [
      "Used",
      "Brand New",
      "Hot Offers",
      "Recommended",
      "Clearance Sale",
      "New Arrival",
      "Permitted",
      "Dealer Stock",
    ]) {
      checkboxValues[label] = false;
    }
  }

  @override
  void dispose() {
    stockNumberController.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      dropdownValues.clear();
      for (var key in checkboxValues.keys) {
        checkboxValues[key] = false;
      }
      stockNumberController.clear();
      searchTextController.clear();
    });
  }

  void _searchResults() {
    // Implement search functionality here
    print('Search triggered with filters:');
    print('Dropdown values: $dropdownValues');
    print('Checkbox values: $checkboxValues');
    print('Stock numbers: ${stockNumberController.text}');
    print('Search text: ${searchTextController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Advanced Search',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Colors.black,
              ),
            ),
          ),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            alignment: WrapAlignment.start,
            children: [
              _buildDropdown("Brands", ["Toyota", "Nissan", "Honda"]),
              _buildDropdown("All Models", ["Model A", "Model B", "Model C"]),
              _buildDropdown("Steering", ["Left", "Right"]),
              _buildDropdown("Year From", ["2010", "2015", "2020"]),
              _buildDropdown("Year To", ["2022", "2023", "2024"]),
              _buildDropdown("Price From", [
                "10,000 USD",
                "20,000 USD",
                "30,000 USD",
              ]),
              _buildDropdown("Price To", [
                "40,000 USD",
                "50,000 USD",
                "60,000 USD",
              ]),
              _buildDropdown("All Type", ["SUV", "Sedan", "Truck"]),
              _buildDropdown("All Body Type", [
                "Coupe",
                "Hatchback",
                "Convertible",
              ]),
              _buildDropdown("Select Engine CC", [
                "1500cc",
                "2000cc",
                "2500cc",
              ]),
              _buildDropdown("Transmission", ["Manual", "Automatic"]),
              _buildDropdown("2WD/4WD", ["2WD", "4WD"]),
              _buildDropdown("All Fuel", ["Petrol", "Diesel", "Hybrid"]),
              _buildDropdown("Select Country", ["Japan", "USA", "UK"]),
              _buildTextField(
                "Multiple Stock Number by Comma (,)",
                controller: stockNumberController,
                width: 280,
              ),
              _buildTextField(
                "Search for Make, Model, Chassis, Stock Number etc",
                controller: searchTextController,
                width: 280,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Wrap(
              spacing: 18.0,
              runSpacing: 10.0,
              alignment: WrapAlignment.start,
              children: [
                _buildCheckbox("Used"),
                _buildCheckbox("Brand New"),
                _buildCheckbox("Hot Offers"),
                _buildCheckbox("Recommended"),
                _buildCheckbox("Clearance Sale"),
                _buildCheckbox("New Arrival"),
                _buildCheckbox("Permitted"),
                _buildCheckbox("Dealer Stock"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                "Search",
                Colors.black,
                Colors.white,
                onPressed: _searchResults,
              ),
              const SizedBox(width: 14),
              _buildButton(
                "Reset",
                Colors.black,
                Colors.white,
                onPressed: _resetFilters,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items) {
    return SizedBox(
      width: 200,
      child: DropdownButtonFormField<String>(
        value: dropdownValues[hint],
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
        ),
        hint: Text(hint, style: const TextStyle(color: Colors.black)),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: Colors.white,
        items:
            items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            dropdownValues[hint] = value;
          });
        },
      ),
    );
  }

  Widget _buildCheckbox(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: checkboxValues[label] ?? false,
          onChanged: (bool? value) {
            setState(() {
              checkboxValues[label] = value ?? false;
            });
          },
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String hint, {
    TextEditingController? controller,
    double width = 200,
  }) {
    return SizedBox(
      width: width,
      height: 45,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color backgroundColor,
    Color textColor, {
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
