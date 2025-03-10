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

class VehicleStock extends StatelessWidget {
  const VehicleStock({Key? key}) : super(key: key);

  // Static sample categories data
  static const List<Map<String, dynamic>> _categories = [
    {
      'vehicles': [
        VehicleData(
          title: 'A CLASS 2020',
          price: '29,462 USD',
          imagePath: 'assets/images/car_01.png',
        ),
        VehicleData(
          title: 'TOYOTA ALPHARD 2020',
          price: '29,462 USD',
          imagePath: 'assets/images/car_02.jpg',
        ),
        VehicleData(
          title: 'SUPER GREAT 2010',
          price: '29,462 USD',
          imagePath: 'assets/images/car_03.png',
        ),
        VehicleData(
          title: 'BMW X5 2023',
          price: '29,462 USD',
          imagePath: 'assets/images/car_04.jpg',
        ),
      ],
    },
    {
      'vehicles': [
        VehicleData(
          title: 'CANTER 2008',
          price: '29,462 USD',
          imagePath: 'assets/images/car_05.jpg',
          discount: '3',
        ),
        VehicleData(
          title: 'NISSAN ELGRAND 2014',
          price: '29,462 USD',
          imagePath: 'assets/images/car_06.png',
          discount: '11',
        ),
        VehicleData(
          title: 'BMW M4 2024',
          price: '29,462 USD',
          imagePath: 'assets/images/car_07.jpg',
          discount: '15',
        ),
        VehicleData(
          title: 'SUMITOMO OTHERS 1996',
          price: '29,462 USD',
          imagePath: 'assets/images/car_08.png',
        ),
      ],
    },
    {
      'vehicles': [
        VehicleData(
          title: 'ACURA 2022',
          price: '29,462 USD',
          imagePath: 'assets/images/car_09.jpg',
        ),
        VehicleData(
          title: 'HONDA VEZEL 2024',
          price: '29,462 USD',
          imagePath: 'assets/images/car_10.png',
        ),
        VehicleData(
          title: 'BMW 3 SERIES 2022',
          price: '29,462 USD',
          imagePath: 'assets/images/car_11.jpg',
          discount: '9',
        ),
        VehicleData(
          title: 'ISUZU ELF 2003',
          price: '29,462 USD',
          imagePath: 'assets/images/car_12.png',
        ),
      ],
    },
    {
      'vehicles': [
        VehicleData(
          title: 'HINO RANGER 2014',
          price: '29,462 USD',
          imagePath: 'assets/images/car_13.jpg',
        ),
        VehicleData(
          title: 'ISUZU GIGA 2015',
          price: '29,462 USD',
          imagePath: 'assets/images/car_14.png',
        ),
        VehicleData(
          title: 'ISUZU ELF 2003',
          price: '29,462 USD',
          imagePath: 'assets/images/car_15.png',
          discount: '7',
        ),
        VehicleData(
          title: 'HINO RANGER 2016',
          price: '29,462 USD',
          imagePath: 'assets/images/car_16.jpg',
        ),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;

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
                vertical: 32.0,
                horizontal: isMobile ? 16.0 : 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main header
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
                  const SizedBox(height: 40),

                  // Categories
                  for (final category in _categories) ...[
                    _buildCategorySection(
                      context,
                      category['title'] as String? ?? 'FEATURED',
                      category['vehicles'] as List<VehicleData>,
                      isMobile,
                      primaryColor,
                      secondaryColor,
                    ),
                    const SizedBox(height: 48),
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
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header
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
            TextButton(
              onPressed: () {
                // Handle "View All" action
              },
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              child: Row(
                children: [
                  const Text('View All'),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 16, color: primaryColor),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Vehicle grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : 4,
            childAspectRatio: isMobile ? 0.75 : 0.85,
            crossAxisSpacing: 16,
            mainAxisSpacing: 24,
          ),
          itemCount: vehicles.length,
          itemBuilder:
              (context, index) => VehicleCard(
                data: vehicles[index],
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
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

  const VehicleCard({
    Key? key,
    required this.data,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        transform: Matrix4.identity()..scale(isHovered ? 1.03 : 1.0),
        child: Card(
          elevation: isHovered ? 8 : 2,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color:
                  isHovered
                      ? widget.primaryColor.withOpacity(0.3)
                      : Colors.transparent,
              width: 1.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Vehicle image
                    Image.asset(
                      widget.data.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Icon(
                                Icons.directions_car,
                                size: 40,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                    ),

                    // Gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                            stops: const [0.6, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Discount badge
                    if (widget.data.discount != null)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: widget.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '-${widget.data.discount}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                    // Title overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          widget.data.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Price and actions
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price
                    Text(
                      widget.data.price,
                      style: TextStyle(
                        color: widget.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Action buttons
                    Row(
                      children: [
                        // Details button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _showDetailsDialog(context);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: widget.secondaryColor,
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Inquire button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Inquire action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: const Text('Inquire'),
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.primaryColor.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Vehicle image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.data.imagePath,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 200,
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.directions_car,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title with red underline
                Column(
                  children: [
                    Text(
                      widget.data.title,
                      style: TextStyle(
                        color: widget.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 2,
                      width: 40,
                      decoration: BoxDecoration(
                        color: widget.primaryColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Price
                Text(
                  'Price: ${widget.data.price}',
                  style: TextStyle(
                    color: widget.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),

                // Vehicle details
                const Text(
                  'Additional specifications and features would be displayed here with detailed information about engine, transmission, mileage, and other relevant details about this vehicle.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, height: 1.5),
                ),
                const SizedBox(height: 20),

                // Dialog buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: widget.secondaryColor,
                        side: BorderSide(color: Colors.grey.shade300),
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
                        // Inquire action
                        Navigator.of(context).pop();
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
        );
      },
    );
  }
}
