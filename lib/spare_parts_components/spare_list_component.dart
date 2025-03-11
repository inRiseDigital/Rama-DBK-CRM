import 'package:flutter/material.dart';

class SpareListComponent extends StatefulWidget {
  const SpareListComponent({Key? key}) : super(key: key);

  @override
  _SpareListComponentState createState() => _SpareListComponentState();
}

class _SpareListComponentState extends State<SpareListComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  /// Sample spare parts data
  final List<Map<String, dynamic>> _spareItems = [
    {
      "title": "NEW SPARK PLUG(19100P)",
      "code": "NSP18177",
      "price": 150,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "TEST1",
      "code": "NSP5103",
      "price": 5000,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "Steering Rack",
      "code": "D1093",
      "price": 500,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "MUD FLAP FOR 1 CAR",
      "code": "NSP16784",
      "price": 150,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "FRONT DOOR OUTER UNDER...",
      "code": "NSP19618",
      "price": 85,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "Tailgate spoiler CR-V",
      "code": "D1054",
      "price": 466,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "PLATE / #21 - FRR32LB-3015...",
      "code": "NSP18739",
      "price": 75,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "REAR SPRING PIN NIPPLE / FI...",
      "code": "NSP11692",
      "price": 2,
      "status": "Now On Sale",
      "imageUrl": "",
    },
  ];

  // Full list of parts (could be fetched from an API in a real app)
  List<Map<String, dynamic>> _displayedItems = [];

  // Additional parts to add when "View More" is clicked
  final List<Map<String, dynamic>> _additionalItems = [
    {
      "title": "Oil Filter",
      "code": "NSP22456",
      "price": 30,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "Air Filter",
      "code": "NSP78901",
      "price": 45,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "Brake Pads (Front)",
      "code": "NSP34567",
      "price": 120,
      "status": "Now On Sale",
      "imageUrl": "",
    },
    {
      "title": "Wiper Blades Set",
      "code": "NSP45678",
      "price": 35,
      "status": "Now On Sale",
      "imageUrl": "",
    },
  ];

  // Flag to track if we're showing expanded view
  bool _expandedView = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();

    // Initialize the displayed items with the initial set
    _displayedItems = List.from(_spareItems);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to handle view more button press
  void _handleViewMore() {
    setState(() {
      // Add additional items to the displayed list
      _displayedItems.addAll(_additionalItems);
      _expandedView = true;
    });
  }

  // Function to handle view less button press
  void _handleViewLess() {
    setState(() {
      // Reset to just the initial items
      _displayedItems = List.from(_spareItems);
      _expandedView = false;
    });
  }

  /// Main build
  @override
  Widget build(BuildContext context) {
    // A background container to add a subtle color or gradient
    return Container(
      // Example: soft gradient background (optional)
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFDFDFD), Color(0xFFF8F8F8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              _buildSearchSection(),
              const SizedBox(height: 20),
              _buildSpareGrid(),
              const SizedBox(height: 20),
              _buildToggleViewButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Search Bar + Buttons Section
  Widget _buildSearchSection() {
    return Center(
      // Center the search bar
      child: Container(
        width: 600, // Decreased width
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Search icon on the left
            const Padding(
              padding: EdgeInsets.only(left: 8, right: 4),
              child: Icon(Icons.search, color: Colors.black54),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by Keywords, Stock No., Part No.",
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.black54),
                ),
                style: const TextStyle(
                  color: Colors.black,
                ), // Set text color to black
              ),
            ),
            // "Search" button
            ElevatedButton.icon(
              icon: const Icon(Icons.search, size: 18),
              label: const Text("Search"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: Implement search logic
              },
            ),
            const SizedBox(width: 8),
            // "Reset" button
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text("Reset"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              onPressed: () {
                // TODO: Implement reset logic
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Grid Section for Spare Parts
  Widget _buildSpareGrid() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center, // Center the grid items
      children: _displayedItems.map((item) => _buildSpareItem(item)).toList(),
    );
  }

  /// Single Spare Item Card with Hover & Material styling
  Widget _buildSpareItem(Map<String, dynamic> item) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 200,
        height: 320, // Fixed height for all cards
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // TODO: Navigate to details or show a popup
            },
            child: Column(
              children: [
                // Image Section with fixed height
                SizedBox(
                  height: 160, // Fixed height for image section
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      color: Colors.red.withOpacity(0.05),
                    ),
                    child:
                        (item["imageUrl"] ?? "").isNotEmpty
                            ? ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                item["imageUrl"],
                                fit: BoxFit.cover,
                              ),
                            )
                            : const Center(
                              child: Text(
                                "Image Coming Soon",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 12),

                // Content section with fixed padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 40, // Fixed height for title
                        child: Text(
                          item["title"] ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Code : ${item["code"] ?? ""}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (item["status"] != null && item["status"].isNotEmpty)
                        Text(
                          item["status"],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        "${item["price"]} JPY",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Toggle View Button (View More/View Less)
  Widget _buildToggleViewButton() {
    return Center(
      // Center the button
      child:
          _expandedView
              ? ElevatedButton.icon(
                icon: const Icon(Icons.remove_circle_outline, size: 18),
                label: const Text("View Less", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _handleViewLess,
              )
              : ElevatedButton.icon(
                icon: const Icon(Icons.add_circle_outline, size: 18),
                label: const Text("View More", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _handleViewMore,
              ),
    );
  }
}
