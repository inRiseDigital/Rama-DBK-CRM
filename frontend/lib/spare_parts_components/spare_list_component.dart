import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpareListComponent extends StatefulWidget {
  const SpareListComponent({Key? key}) : super(key: key);

  @override
  _SpareListComponentState createState() => _SpareListComponentState();
}

class _SpareListComponentState extends State<SpareListComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredSpareItems = [];

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
    _filteredSpareItems = List.from(_spareItems);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    // Initialize the displayed items with the initial set
    _displayedItems = List.from(_spareItems);
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSpareItems = List.from(_spareItems);
      } else {
        final searchLower = query.toLowerCase();
        _filteredSpareItems = _spareItems.where((item) {
          final title = (item['title'] ?? '').toString().toLowerCase();
          final code = (item['code'] ?? '').toString().toLowerCase();
          final price = (item['price'] ?? '').toString().toLowerCase();
          return title.contains(searchLower) ||
              code.contains(searchLower) ||
              price.contains(searchLower);
        }).toList();
      }
    });
  }

  void _handleReset() {
    setState(() {
      _searchController.clear();
      _filteredSpareItems = List.from(_spareItems);
    });
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

  void _showSparePartDetails(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item['title'] ?? 'Spare Part Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item['imageUrl'] != null && item['imageUrl'].isNotEmpty)
                  Image.network(
                    item['imageUrl'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 16),
                Text('Part Code: ${item['code']}'),
                const SizedBox(height: 8),
                Text('Price: \$${item['price']}'),
                const SizedBox(height: 8),
                Text('Status: ${item['status']}'),
                const SizedBox(height: 16),
                const Text(
                  'Would you like to inquire about this part?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.push('/inquiry', extra: {
                  'partCode': item['code'],
                  'partName': item['title'],
                  'price': item['price'],
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Make Inquiry'),
            ),
          ],
        );
      },
    );
  }

  /// Main build
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 600;
          return SingleChildScrollView(
            child: Container(
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
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 24 : 16,
                    vertical: isDesktop ? 32 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSearchSection(isDesktop),
                      SizedBox(height: isDesktop ? 32 : 20),
                      _buildSpareGrid(isDesktop),
                      SizedBox(height: isDesktop ? 32 : 20),
                      _buildToggleViewButton(isDesktop),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Search Bar + Buttons Section
  Widget _buildSearchSection(bool isDesktop) {
    return Center(
      child: Container(
        width: isDesktop ? 800 : double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 16 : 8,
          vertical: isDesktop ? 12 : 8,
        ),
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
            Padding(
              padding: EdgeInsets.only(
                left: isDesktop ? 16 : 8,
                right: isDesktop ? 8 : 4,
              ),
              child: const Icon(Icons.search, color: Colors.black54),
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search by Keywords, Stock No., Part No.",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: isDesktop ? 16 : 14,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isDesktop ? 16 : 14,
                ),
                onChanged: _handleSearch,
              ),
            ),
            if (isDesktop) ...[
              ElevatedButton.icon(
                icon: const Icon(Icons.search, size: 20),
                label: const Text("Search", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // TODO: Implement search logic
                },
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.refresh, size: 20),
                label: const Text("Reset", style: TextStyle(fontSize: 16)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _handleReset,
              ),
            ] else ...[
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.red,
                onPressed: () {
                  // TODO: Implement search logic
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                color: Colors.red,
                onPressed: _handleReset,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Grid Section for Spare Parts
  Widget _buildSpareGrid(bool isDesktop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = isDesktop
            ? (constraints.maxWidth / 250).floor()
            : (constraints.maxWidth / 200).floor();
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount.clamp(1, 4),
            childAspectRatio: isDesktop ? 0.8 : 0.7,
            crossAxisSpacing: isDesktop ? 24 : 16,
            mainAxisSpacing: isDesktop ? 24 : 16,
          ),
          itemCount: _filteredSpareItems.length,
          itemBuilder: (context, index) =>
              _buildSpareItem(_filteredSpareItems[index], isDesktop),
        );
      },
    );
  }

  /// Single Spare Item Card with Hover & Material styling
  Widget _buildSpareItem(Map<String, dynamic> item, bool isDesktop) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
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
          child: InkWell(
            onTap: () => _showSparePartDetails(context, item),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 20 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: isDesktop ? 180 : 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      image: item['imageUrl'] != null &&
                              item['imageUrl'].isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(item['imageUrl']),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: item['imageUrl'] == null || item['imageUrl'].isEmpty
                        ? Icon(Icons.image,
                            size: isDesktop ? 60 : 50, color: Colors.grey)
                        : null,
                  ),
                  SizedBox(height: isDesktop ? 20 : 16),
                  Text(
                    item['title'] ?? '',
                    style: TextStyle(
                      fontSize: isDesktop ? 18 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isDesktop ? 12 : 8),
                  Text(
                    'Code: ${item['code']}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: isDesktop ? 16 : 14,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 12 : 8),
                  Text(
                    '\$${item['price']}',
                    style: TextStyle(
                      fontSize: isDesktop ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 12 : 8,
                      vertical: isDesktop ? 6 : 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item['status'] ?? '',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: isDesktop ? 14 : 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Toggle View Button (View More/View Less)
  Widget _buildToggleViewButton(bool isDesktop) {
    return Center(
      child: _expandedView
          ? ElevatedButton.icon(
              icon:
                  Icon(Icons.remove_circle_outline, size: isDesktop ? 24 : 18),
              label: Text(
                "View Less",
                style: TextStyle(fontSize: isDesktop ? 18 : 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 40 : 30,
                  vertical: isDesktop ? 16 : 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _handleViewLess,
            )
          : ElevatedButton.icon(
              icon: Icon(Icons.add_circle_outline, size: isDesktop ? 24 : 18),
              label: Text(
                "View More",
                style: TextStyle(fontSize: isDesktop ? 18 : 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 40 : 30,
                  vertical: isDesktop ? 16 : 14,
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
