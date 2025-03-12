import 'package:flutter/material.dart';

/// Simple data model for a vehicle
class VehicleData {
  final String title;
  final String price;
  final String imagePath;
  final String? discount; // e.g. "10"

  const VehicleData({
    required this.title,
    required this.price,
    required this.imagePath,
    this.discount,
  });
}

class FeaturedVehicles extends StatelessWidget {
  const FeaturedVehicles({Key? key}) : super(key: key);

  // Static sample categories data to avoid recreating it on every build.
  static const List<Map<String, dynamic>> _categories = [
    {
      'title': 'LATEST STOCK',
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
      'title': 'LATEST HOT OFFERS',
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
      'title': 'RECOMMENDED STOCK',
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
      'title': 'DEALER STOCK',
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

    return Container(
      // Subtle gradient background for the entire widget
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade100],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            // Keeps the content centered and prevents it from stretching too wide.
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: isMobile ? 16.0 : 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'FEATURED VEHICLES',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 22 : 28,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore Our Exclusive Collections',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Loop through each category
                  for (final category in _categories) ...[
                    _buildCategorySection(
                      context,
                      category['title'] as String,
                      category['vehicles'] as List<VehicleData>,
                      isMobile,
                    ),
                    const SizedBox(height: 30),
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
  ) {
    return Column(
      children: [
        // Category header with "View All" button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 16 : 18,
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle "View All" action
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red.shade700,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Generate vehicle cards using List.generate
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16.0,
          runSpacing: 16.0,
          children: List.generate(
            vehicles.length,
            (index) => VehicleCard(data: vehicles[index], isMobile: isMobile),
          ),
        ),
      ],
    );
  }
}

class VehicleCard extends StatefulWidget {
  final VehicleData data;
  final bool isMobile;

  const VehicleCard({Key? key, required this.data, required this.isMobile})
    : super(key: key);

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double cardWidth =
        widget.isMobile ? (MediaQuery.of(context).size.width - 80) / 2 : 260.0;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
        child: Container(
          width: cardWidth,
          margin: const EdgeInsets.only(bottom: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isHovered ? 0.15 : 0.07),
                blurRadius: isHovered ? 12.0 : 10.0,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with discount label if applicable
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      widget.data.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Icon(
                                Icons.directions_car,
                                size: 50.0,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                    ),
                  ),
                  if (widget.data.discount != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4.0,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_offer,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '-${widget.data.discount}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              // Vehicle info and action buttons
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Price: ${widget.data.price}',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // Open pop-up dialog for details
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(widget.data.title),
                                    content: Text(
                                      'Here are the detailed specifications and features of the vehicle.\n\n'
                                      'Price: ${widget.data.price}\n'
                                      'Additional information goes here...',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                            child: const Text('Details'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Inquire / Test Drive action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              elevation: 0,
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
}
