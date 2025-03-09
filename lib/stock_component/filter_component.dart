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
    return Center(
      // Added Center widget here
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Added this
          crossAxisAlignment: CrossAxisAlignment.center, // Changed to center
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Added this
                children: [
                  const Text(
                    'Advanced Search',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _resetFilters,
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Color(0xFF4F5D75),
                    ),
                    tooltip: 'Reset Filters',
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              alignment: WrapAlignment.center, // Changed to center
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
                  icon: Icons.format_list_numbered,
                ),
                _buildTextField(
                  "Search for Make, Model, Chassis, Stock Number etc",
                  controller: searchTextController,
                  width: 280,
                  icon: Icons.search,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Wrap(
                spacing: 18.0,
                runSpacing: 10.0,
                alignment: WrapAlignment.center, // Changed to center
                children: [
                  _buildChip("Used"),
                  _buildChip("Brand New"),
                  _buildChip("Hot Offers"),
                  _buildChip("Recommended"),
                  _buildChip("Clearance Sale"),
                  _buildChip("New Arrival"),
                  _buildChip("Permitted"),
                  _buildChip("Dealer Stock"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: _buildButton(
                  "Search",
                  const Color(0xFF3E54AC),
                  Colors.white,
                  icon: Icons.search,
                  onPressed: _searchResults,
                ),
              ),
            ),
          ],
        ),
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
            color: Color(0xFF4F5D75),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3E54AC), width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        hint: Text(
          hint,
          style: const TextStyle(color: Color(0xFF4F5D75), fontSize: 14),
        ),
        style: const TextStyle(
          color: Color(0xFF2D3142),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF4F5D75),
        ),
        items:
            items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(color: Color(0xFF2D3142)),
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

  Widget _buildChip(String label) {
    return FilterChip(
      selected: checkboxValues[label] ?? false,
      label: Text(
        label,
        style: TextStyle(
          color:
              (checkboxValues[label] ?? false)
                  ? Colors.white
                  : const Color(0xFF4F5D75),
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      selectedColor: const Color(0xFF3E54AC),
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color:
              (checkboxValues[label] ?? false)
                  ? const Color(0xFF3E54AC)
                  : Colors.grey.shade300,
          width: 1,
        ),
      ),
      onSelected: (bool selected) {
        setState(() {
          checkboxValues[label] = selected;
        });
      },
    );
  }

  Widget _buildTextField(
    String hint, {
    TextEditingController? controller,
    double width = 200,
    IconData? icon,
  }) {
    return SizedBox(
      width: width,
      height: 48,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Color(0xFF2D3142),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF4F5D75),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          prefixIcon:
              icon != null
                  ? Icon(icon, color: const Color(0xFF4F5D75), size: 20)
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3E54AC), width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color backgroundColor,
    Color textColor, {
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
