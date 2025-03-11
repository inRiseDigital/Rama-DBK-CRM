import 'package:flutter/material.dart';

class FilterComponent extends StatefulWidget {
  final Function(
    String? brand,
    String? model,
    String? steering,
    String? yearFrom,
    String? yearTo,
    String? priceFrom,
    String? priceTo,
    String? type,
    String? bodyType,
    String? engine,
    String? transmission,
    String? drive,
    String? fuel,
    String? country,
    String? stockNumber,
    String? search,
    Map<String, bool>? tags,
  )
  onFilterChanged;

  const FilterComponent({Key? key, required this.onFilterChanged})
    : super(key: key);

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

    // Trigger filter with reset values
    widget.onFilterChanged(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      '',
      '',
      checkboxValues,
    );
  }

  void _searchResults() {
    // Call the filter callback with current values
    widget.onFilterChanged(
      dropdownValues['Brands'],
      dropdownValues['All Models'],
      dropdownValues['Steering'],
      dropdownValues['Year From'],
      dropdownValues['Year To'],
      dropdownValues['Price From'],
      dropdownValues['Price To'],
      dropdownValues['All Type'],
      dropdownValues['All Body Type'],
      dropdownValues['Select Engine CC'],
      dropdownValues['Transmission'],
      dropdownValues['2WD/4WD'],
      dropdownValues['All Fuel'],
      dropdownValues['Select Country'],
      stockNumberController.text,
      searchTextController.text,
      checkboxValues,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final bool isSmallScreen = screenSize.width < 360;
    final double containerPadding = isMobile ? 16.0 : 24.0;
    final double inputWidth =
        isMobile
            ? (isSmallScreen ? screenSize.width * 0.9 : screenSize.width * 0.95)
            : 200.0;

    if (!isMobile) {
      return _buildFullFilterView(
        context,
        containerPadding,
        inputWidth,
        isMobile,
        isSmallScreen,
      );
    }

    return Column(
      children: [
        // Filter Button for Mobile
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () => _showFilterBottomSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF2D3142),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              elevation: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: Colors.red.shade800,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Filter Vehicles',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${dropdownValues.values.where((v) => v != null).length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 360;
    final double inputWidth =
        isSmallScreen ? screenSize.width * 0.9 : screenSize.width * 0.95;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: screenSize.height * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Filter content
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildFullFilterView(
                      context,
                      16.0,
                      inputWidth,
                      true,
                      isSmallScreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildFullFilterView(
    BuildContext context,
    double containerPadding,
    double inputWidth,
    bool isMobile,
    bool isSmallScreen,
  ) {
    return SafeArea(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(containerPadding),
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 8.0 : 24.0,
            vertical: isMobile ? 16.0 : 24.0,
          ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 16.0 : 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Advanced Search',
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        color: const Color(0xFF2D3142),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        _resetFilters();
                        if (isMobile) Navigator.pop(context);
                      },
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
                spacing: isMobile ? 8.0 : 16.0,
                runSpacing: isMobile ? 8.0 : 16.0,
                alignment: WrapAlignment.center,
                children: [
                  _buildDropdown("Brands", [
                    "Toyota",
                    "Nissan",
                    "Honda",
                  ], width: inputWidth),
                  _buildDropdown("All Models", [
                    "Model A",
                    "Model B",
                    "Model C",
                  ], width: inputWidth),
                  _buildDropdown("Steering", [
                    "Left",
                    "Right",
                  ], width: inputWidth),
                  _buildDropdown("Year From", [
                    "2010",
                    "2015",
                    "2020",
                  ], width: inputWidth),
                  _buildDropdown("Year To", [
                    "2022",
                    "2023",
                    "2024",
                  ], width: inputWidth),
                  _buildDropdown("Price From", [
                    "10,000 USD",
                    "20,000 USD",
                    "30,000 USD",
                  ], width: inputWidth),
                  _buildDropdown("Price To", [
                    "40,000 USD",
                    "50,000 USD",
                    "60,000 USD",
                  ], width: inputWidth),
                  _buildDropdown("All Type", [
                    "SUV",
                    "Sedan",
                    "Truck",
                  ], width: inputWidth),
                  _buildDropdown("All Body Type", [
                    "Coupe",
                    "Hatchback",
                    "Convertible",
                  ], width: inputWidth),
                  _buildDropdown("Select Engine CC", [
                    "1500cc",
                    "2000cc",
                    "2500cc",
                  ], width: inputWidth),
                  _buildDropdown("Transmission", [
                    "Manual",
                    "Automatic",
                  ], width: inputWidth),
                  _buildDropdown("2WD/4WD", ["2WD", "4WD"], width: inputWidth),
                  _buildDropdown("All Fuel", [
                    "Petrol",
                    "Diesel",
                    "Hybrid",
                  ], width: inputWidth),
                  _buildDropdown("Select Country", [
                    "Japan",
                    "USA",
                    "UK",
                  ], width: inputWidth),
                  _buildTextField(
                    "Multiple Stock Number by Comma (,)",
                    controller: stockNumberController,
                    width: inputWidth,
                    icon: Icons.format_list_numbered,
                  ),
                  _buildTextField(
                    "Search for Make, Model, Chassis, Stock Number etc",
                    controller: searchTextController,
                    width: inputWidth,
                    icon: Icons.search,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: isMobile ? 16.0 : 20.0),
                child: Wrap(
                  spacing: isMobile ? 8.0 : 18.0,
                  runSpacing: isMobile ? 8.0 : 10.0,
                  alignment: WrapAlignment.center,
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
                padding: EdgeInsets.only(top: isMobile ? 8.0 : 10.0),
                child: Center(
                  child: _buildButton(
                    "Apply Filters",
                    Colors.red,
                    Colors.white,
                    icon: Icons.search,
                    onPressed: () {
                      _searchResults();
                      if (isMobile) Navigator.pop(context);
                    },
                    isMobile: isMobile,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items, {
    required double width,
  }) {
    return SizedBox(
      width: width,
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
    bool isMobile = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 32,
          vertical: isMobile ? 12 : 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: isMobile ? 18 : 20),
            SizedBox(width: isMobile ? 6 : 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 14 : 15,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
