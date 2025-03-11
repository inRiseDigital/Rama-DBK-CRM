import 'package:flutter/material.dart';

/// Simple data model for a vehicle
class VehicleData {
  final String title;
  final String price;
  final String imagePath;
  final String? discount;

  const VehicleData({
    required this.title,
    required this.price,
    required this.imagePath,
    this.discount,
  });
}

class VehicleStock extends StatefulWidget {
  final Map<String, String?>? filters;

  const VehicleStock({Key? key, this.filters}) : super(key: key);

  @override
  State<VehicleStock> createState() => _VehicleStockState();
}

class _VehicleStockState extends State<VehicleStock> {
  // Static sample categories data
  static const List<Map<String, dynamic>> _allCategories = [
    {
      'vehicles': [
        VehicleData(
          title: 'Mercedes-Benz A200 2020',
          price: '32,900 USD',
          imagePath: 'assets/images/car_01.png',
          discount: '5',
        ),
        VehicleData(
          title: 'Toyota Alphard 3.5L 2022',
          price: '65,800 USD',
          imagePath: 'assets/images/car_02.jpg',
        ),
        VehicleData(
          title: 'Mercedes-Benz Actros 2020',
          price: '98,500 USD',
          imagePath: 'assets/images/car_03.png',
          discount: '8',
        ),
        VehicleData(
          title: 'BMW X5 xDrive40i 2023',
          price: '75,900 USD',
          imagePath: 'assets/images/car_04.jpg',
        ),
      ],
    },
    {
      'vehicles': [
        VehicleData(
          title: 'Mitsubishi Canter 4.9D 2020',
          price: '28,500 USD',
          imagePath: 'assets/images/car_05.jpg',
          discount: '10',
        ),
        VehicleData(
          title: 'Nissan Elgrand 3.5L 2021',
          price: '42,900 USD',
          imagePath: 'assets/images/car_06.png',
          discount: '7',
        ),
        VehicleData(
          title: 'BMW M4 Competition 2024',
          price: '89,900 USD',
          imagePath: 'assets/images/car_07.jpg',
        ),
        VehicleData(
          title: 'Toyota Hilux 2.8D 2022',
          price: '45,800 USD',
          imagePath: 'assets/images/car_08.png',
          discount: '5',
        ),
      ],
    },
    {
      'vehicles': [
        VehicleData(
          title: 'Acura MDX Type S 2023',
          price: '58,400 USD',
          imagePath: 'assets/images/car_09.jpg',
          discount: '6',
        ),
        VehicleData(
          title: 'Honda Vezel e:HEV 2024',
          price: '38,900 USD',
          imagePath: 'assets/images/car_10.png',
        ),
        VehicleData(
          title: 'BMW 330i M Sport 2023',
          price: '52,900 USD',
          imagePath: 'assets/images/car_11.jpg',
          discount: '9',
        ),
        VehicleData(
          title: 'Isuzu ELF 5.2D 2022',
          price: '35,800 USD',
          imagePath: 'assets/images/car_12.png',
          discount: '12',
        ),
      ],
    },
    {
      'vehicles': [
        VehicleData(
          title: 'Hino Ranger FG 2023',
          price: '78,500 USD',
          imagePath: 'assets/images/car_13.jpg',
        ),
        VehicleData(
          title: 'Isuzu Giga 6x4 2022',
          price: '92,800 USD',
          imagePath: 'assets/images/car_14.png',
          discount: '8',
        ),
        VehicleData(
          title: 'Toyota Land Cruiser ZX 2024',
          price: '96,500 USD',
          imagePath: 'assets/images/car_15.png',
        ),
        VehicleData(
          title: 'Lexus LX600 F Sport 2023',
          price: '105,900 USD',
          imagePath: 'assets/images/car_16.jpg',
          discount: '5',
        ),
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredCategories {
    if (widget.filters == null || widget.filters!.isEmpty) {
      return _allCategories;
    }

    return _allCategories
        .map((category) {
          final vehicles =
              (category['vehicles'] as List<VehicleData>).where((vehicle) {
                final title = vehicle.title.toLowerCase();
                final filters = widget.filters!;

                // Apply brand filter
                if (filters['brand'] != null &&
                    !title.contains(filters['brand']!.toLowerCase())) {
                  return false;
                }

                // Apply model filter
                if (filters['model'] != null &&
                    !title.contains(filters['model']!.toLowerCase())) {
                  return false;
                }

                // Apply year filter
                if (filters['yearFrom'] != null || filters['yearTo'] != null) {
                  final yearMatch = RegExp(r'\d{4}').firstMatch(title);
                  if (yearMatch != null) {
                    final year = int.parse(yearMatch.group(0)!);
                    if (filters['yearFrom'] != null &&
                        year < int.parse(filters['yearFrom']!)) {
                      return false;
                    }
                    if (filters['yearTo'] != null &&
                        year > int.parse(filters['yearTo']!)) {
                      return false;
                    }
                  }
                }

                // Apply price filter
                if (filters['priceFrom'] != null ||
                    filters['priceTo'] != null) {
                  final priceStr = vehicle.price.replaceAll(
                    RegExp(r'[^\d.]'),
                    '',
                  );
                  final price = double.parse(priceStr);

                  if (filters['priceFrom'] != null) {
                    final minPrice = double.parse(
                      filters['priceFrom']!.replaceAll(RegExp(r'[^\d.]'), ''),
                    );
                    if (price < minPrice) return false;
                  }

                  if (filters['priceTo'] != null) {
                    final maxPrice = double.parse(
                      filters['priceTo']!.replaceAll(RegExp(r'[^\d.]'), ''),
                    );
                    if (price > maxPrice) return false;
                  }
                }

                // Add more filter conditions as needed...

                return true;
              }).toList();

          return {'vehicles': vehicles};
        })
        .where((category) => (category['vehicles'] as List).isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final bool isSmallScreen = screenSize.width < 360;

    // Determine grid columns based on screen size
    int gridColumns;
    if (screenSize.width > 1200) {
      gridColumns = 4;
    } else if (screenSize.width > 900) {
      gridColumns = 3;
    } else if (screenSize.width > 600) {
      gridColumns = 2;
    } else {
      gridColumns = 1;
    }

    // Adjust child aspect ratio based on screen size
    double childAspectRatio;
    if (isMobile) {
      childAspectRatio = isSmallScreen ? 0.85 : 0.95;
    } else {
      childAspectRatio = screenSize.width > 1200 ? 0.85 : 0.9;
    }

    // Red, white, and black color scheme
    final Color primaryColor = Colors.red.shade800;
    final Color secondaryColor = Colors.black;
    final Color backgroundColor = Colors.white;

    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 16.0 : 32.0,
                horizontal: isMobile ? 8.0 : 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          height: 3,
                          width: 60,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 40),

                  if (_filteredCategories.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 20.0 : 32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: isMobile ? 48 : 64,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            Text(
                              'No vehicles found matching your criteria',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: isMobile ? 16 : 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    for (final category in _filteredCategories) ...[
                      _buildCategorySection(
                        context,
                        '',
                        category['vehicles'] as List<VehicleData>,
                        isMobile,
                        primaryColor,
                        secondaryColor,
                        gridColumns,
                        childAspectRatio,
                      ),
                      SizedBox(height: isMobile ? 24 : 48),
                    ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String title,
    List<VehicleData> vehicles,
    bool isMobile,
    Color primaryColor,
    Color secondaryColor,
    int gridColumns,
    double childAspectRatio,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: isMobile ? 16 : 20,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 20),
        ],

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridColumns,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: isMobile ? 12 : 24,
            mainAxisSpacing: isMobile ? 12 : 24,
          ),
          itemCount: vehicles.length,
          itemBuilder:
              (context, index) => VehicleCard(
                data: vehicles[index],
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                isMobile: isMobile,
              ),
        ),
      ],
    );
  }
}

class VehicleCard extends StatefulWidget {
  final VehicleData data;
  final Color primaryColor;
  final Color secondaryColor;
  final bool isMobile;

  const VehicleCard({
    Key? key,
    required this.data,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isMobile,
  }) : super(key: key);

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  bool isHovered = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Helper function to get vehicle specs
  Map<String, String> getVehicleSpecs(String title) {
    // Create a more generic spec generator for unknown vehicles
    String generateGenericSpecs(String title) {
      final vehicleType = title.toLowerCase();
      String specs = '''
• Model: $title
• Year: ${RegExp(r'\d{4}').firstMatch(title)?.group(0) ?? 'Available upon request'}
''';

      if (vehicleType.contains('mercedes') ||
          vehicleType.contains('bmw') ||
          vehicleType.contains('lexus')) {
        specs += '''
• Category: Luxury Vehicle
• Premium Features: Available
• Advanced Safety Systems: Included
''';
      } else if (vehicleType.contains('toyota') ||
          vehicleType.contains('honda') ||
          vehicleType.contains('nissan')) {
        specs += '''
• Category: Passenger Vehicle
• Reliability: High
• Fuel Efficiency: Optimized
''';
      } else if (vehicleType.contains('truck') ||
          vehicleType.contains('canter') ||
          vehicleType.contains('actros')) {
        specs += '''
• Category: Commercial Vehicle
• Load Capacity: Available upon request
• Commercial Features: Included
''';
      }

      specs += '''
• Engine: Details available upon request
• Transmission: Details available upon request
• Safety Features: Standard safety features included
• Warranty: Standard manufacturer warranty applies

Please contact our sales team for complete vehicle specifications.''';

      return specs;
    }

    final specs = {
      'Mercedes-Benz A200 2020': '''
• Engine: 1.3L Turbocharged 4-cylinder
• Power: 163 hp @ 5,500 rpm
• Transmission: 7G-DCT Automatic
• Acceleration (0-100 km/h): 8.2 seconds
• Fuel Economy: 5.4L/100km combined
• Features: MBUX infotainment, LED headlights, Dynamic Select
• Safety: Active Brake Assist, Attention Assist, Active Lane Keeping
• Warranty: 4 years/50,000 km''',

      'Toyota Alphard 3.5L 2022': '''
• Engine: 3.5L V6 Direct-injection
• Power: 296 hp @ 6,600 rpm
• Transmission: 8-speed Automatic
• Seating: 7 Captain Seats with Ottoman
• Features: Twin Moonroof, Power Sliding Doors
• Entertainment: 10.1" Display, JBL 17-speaker system
• Safety: Toyota Safety Sense, Panoramic View Monitor
• Warranty: 3 years/100,000 km''',

      'Mercedes-Benz Actros 2020': '''
• Engine: OM 471 12.8L Inline-6 Diesel
• Power: 476 hp @ 1,600 rpm
• Torque: 2,300 Nm
• Transmission: PowerShift 3 12-speed
• Cab: GigaSpace, 2.5m width
• Features: MirrorCam, Multimedia Cockpit
• Safety: Active Brake Assist 5, Sideguard Assist
• Service Interval: 100,000 km''',

      'BMW X5 xDrive40i 2023': '''
• Engine: 3.0L TwinPower Turbo inline-6
• Power: 375 hp @ 5,200-6,250 rpm
• Transmission: 8-speed Sport Automatic
• 0-60 mph: 5.3 seconds
• Features: Live Cockpit Pro, Panoramic Roof
• Interior: Vernasca Leather, 12.3" displays
• Safety: Driving Assistant Professional
• Warranty: 4 years/50,000 miles''',

      'Mitsubishi Canter 4.9D 2020': '''
• Engine: 4.9L 4-cylinder Diesel
• Power: 175 hp @ 2,700 rpm
• Transmission: 6-speed Manual
• Payload Capacity: 4,990 kg
• Body Length: 20 feet
• Features: Air Conditioning, Power Windows
• Safety: ABS, Lane Departure Warning
• Warranty: 3 years/100,000 km''',

      'Nissan Elgrand 3.5L 2021': '''
• Engine: 3.5L V6 VQ35DE
• Power: 280 hp @ 6,400 rpm
• Transmission: XTRONIC CVT
• Seating: 8 leather seats
• Features: Dual Sunroof, Power Tailgate
• Entertainment: 11" Rear Monitor
• Safety: Intelligent Around View Monitor
• Warranty: 3 years/100,000 km''',

      'BMW M4 Competition 2024': '''
• Engine: 3.0L Twin-Turbo inline-6
• Power: 503 hp @ 6,250 rpm
• Transmission: 8-speed M Steptronic
• 0-60 mph: 3.4 seconds
• Features: M Drive Professional, Carbon Fiber Roof
• Interior: M Sport Seats, M-specific displays
• Safety: M Drive Professional with M Drift Analyzer
• Warranty: 4 years/50,000 miles''',

      // Add more vehicle specifications as needed...
    };

    return {'specs': specs[title] ?? generateGenericSpecs(title)};
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform:
            Matrix4.identity()
              ..scale(isHovered ? 1.03 : 1.0)
              ..translate(0.0, isHovered ? -5.0 : 0.0),
        child: Card(
          elevation: isHovered ? 16 : 4,
          shadowColor: widget.primaryColor.withOpacity(0.4),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isHovered ? widget.primaryColor : Colors.white,
              width: 2,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section with improved gradient
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Vehicle image with shimmer loading effect
                    Hero(
                      tag: widget.data.imagePath,
                      child: Image.asset(
                        widget.data.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              color: Colors.grey[100],
                              child: Icon(
                                Icons.directions_car,
                                size: 40,
                                color: widget.primaryColor.withOpacity(0.3),
                              ),
                            ),
                      ),
                    ),

                    // Enhanced gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.8),
                            ],
                            stops: const [0.4, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Modernized discount badge
                    if (widget.data.discount != null)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: widget.primaryColor,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.local_offer,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.data.discount}% OFF',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Enhanced title overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.data.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Enhanced price and actions section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade100, width: 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price with icon
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: widget.primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.data.price,
                          style: TextStyle(
                            color: widget.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Modernized action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _showDetailsDialog(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: widget.primaryColor,
                              side: BorderSide(
                                color:
                                    isHovered
                                        ? widget.primaryColor
                                        : Colors.grey.shade300,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.info_outline, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  'Details',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showInquiryDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: isHovered ? 4 : 1,
                              shadowColor: widget.primaryColor.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.send, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  'Inquire',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final vehicleSpecs = getVehicleSpecs(widget.data.title);

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: widget.primaryColor, width: 1.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Close button at top right
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close, color: widget.primaryColor),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),

                    // Rest of the content
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.data.imagePath,
                        height: 200, // Reduced height
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              height: 200,
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.directions_car,
                                size: 50,
                                color: widget.primaryColor.withOpacity(0.3),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title with red underline
                    Column(
                      children: [
                        Text(
                          widget.data.title,
                          style: TextStyle(
                            color: widget.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 2,
                          width: 60,
                          color: widget.primaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Price and discount if available
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Price: ${widget.data.price}',
                          style: TextStyle(
                            color: widget.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        if (widget.data.discount != null) ...[
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: widget.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${widget.data.discount}% OFF',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Vehicle specifications in a scrollable container if needed
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: widget.primaryColor.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vehicle Specifications',
                                style: TextStyle(
                                  color: widget.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                vehicleSpecs['specs']!,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  height: 1.6,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: widget.primaryColor,
                            side: BorderSide(color: widget.primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Close'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showInquiryDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Inquire Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showInquiryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width:
                MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.width * 0.9
                    : 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.primaryColor.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Quick Inquiry',
                            style: TextStyle(
                              color: widget.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: widget.primaryColor),
                          onPressed: () => Navigator.of(context).pop(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const Divider(height: 20),

                    // Vehicle title
                    Text(
                      widget.data.title,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),

                    // Form fields with validation
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: _getInputDecoration('Your Name'),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: _getInputDecoration('Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _messageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                      maxLines: 2,
                      decoration: _getInputDecoration('Your Message'),
                    ),
                    const SizedBox(height: 20),

                    // Send button with loading state
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _isLoading
                                ? null
                                : () => _handleInquirySubmit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:
                            _isLoading
                                ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : const Text(
                                  'Send Inquiry',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _getInputDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      hintStyle: TextStyle(
        color: widget.primaryColor.withOpacity(0.5),
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: widget.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: widget.primaryColor.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: widget.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade800),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade800),
      ),
    );
  }

  Future<void> _handleInquirySubmit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // Clear form
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        // Close dialog
        Navigator.of(context).pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Inquiry sent successfully!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: widget.primaryColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Failed to send inquiry. Please try again.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red.shade800,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}
