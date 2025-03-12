import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// The root widget for the app.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NavBar Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// A sample home page that uses the custom NavBar.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void onNavItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onDropdownItemSelected(String route) {
    // For demonstration purposes, we'll show a snackbar.
    // In a real app you might use Navigator.pushNamed(context, route);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to $route')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(
            selectedIndex: selectedIndex,
            onItemSelected: onNavItemSelected,
            onDropdownItemSelected: onDropdownItemSelected,
          ),
          Expanded(
            child: Center(
              child: Text(
                'Selected index: $selectedIndex',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom navigation bar widget that supports desktop and mobile layouts,
/// including dropdown menus that remain open when hovering.
class NavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final Function(String)? onDropdownItemSelected;

  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    this.onDropdownItemSelected,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int? hoveredIndex;
  bool isSparePartsDropdownOpen = false;
  bool isAboutUsDropdownOpen = false;

  // Flags to know if the cursor is over the dropdown content.
  bool isSparePartsDropdownHovered = false;
  bool isAboutUsDropdownHovered = false;

  static const double _mobileBreakpoint = 768;
  static const double _navbarHeight = 80;
  static const double _logoHeight = 60;

  final List<Map<String, dynamic>> _sparePartsItems = [
    {
      'title': 'Auto Parts & Accessories',
      'route': '/spare-parts/auto-parts',
    },
    {
      'title': 'Order Now',
      'route': '/spare-parts/order',
    },
  ];

  final List<Map<String, dynamic>> _aboutUsItems = [
    {
      'title': 'Company Overview',
      'route': '/about/overview',
    },
    {
      'title': 'Our Team',
      'route': '/about/team',
    },
    {
      'title': 'Mission & Vision',
      'route': '/about/mission',
    },
    {
      'title': 'Our History',
      'route': '/about/history',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < _mobileBreakpoint;

    return Container(
      height: isMobile ? null : _navbarHeight,
      decoration: const BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 24.0,
            vertical: isMobile ? 8.0 : 0.0,
          ),
          child: isMobile
              ? _buildMobileNavBar(context)
              : _buildDesktopNavBar(context),
        ),
      ),
    );
  }

  // ========================
  // DESKTOP NAVBAR
  // ========================
  Widget _buildDesktopNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: [
          _buildLogo(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem(0, 'Home'),
              const SizedBox(width: 32),
              _buildNavItem(1, 'Stock List'),
              const SizedBox(width: 32),
              _buildSparePartsDropdown(2),
              const SizedBox(width: 32),
              _buildNavItem(3, 'Our Services'),
              const SizedBox(width: 32),
              _buildAboutUsDropdown(4),
              const SizedBox(width: 32),
              _buildContactButton(5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      height: _logoHeight,
      child: Image.asset(
        'assets/images/Rama_logo.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          width: _logoHeight,
          height: _logoHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade800, Colors.red.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'R',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String title) {
    final bool isSelected = widget.selectedIndex == index;
    final bool isHovered = hoveredIndex == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: InkWell(
        onTap: () => widget.onItemSelected(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 28.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? Colors.white
                    : (isHovered ? Colors.white70 : Colors.transparent),
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected || isHovered
                  ? Colors.white
                  : Colors.white.withOpacity(0.8),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              letterSpacing: 0.5,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  /// ------------------------
  /// Spare Parts Dropdown (Desktop)
  /// ------------------------
  Widget _buildSparePartsDropdown(int index) {
    final bool isSelected = widget.selectedIndex == index;
    final bool isLabelHovered = hoveredIndex == index;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The "Spare Parts" label
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(() {
              hoveredIndex = index;
              isSparePartsDropdownOpen = true;
              // Close other dropdown if open
              isAboutUsDropdownOpen = false;
            });
          },
          onExit: (_) {
            // Only close if we're not hovering the dropdown content
            if (!isSparePartsDropdownHovered) {
              setState(() {
                hoveredIndex = null;
                isSparePartsDropdownOpen = false;
              });
            }
          },
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onItemSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? Colors.white
                          : (isLabelHovered
                              ? Colors.white70
                              : Colors.transparent),
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Spare Parts',
                      style: TextStyle(
                        color: isSelected || isLabelHovered
                            ? Colors.white
                            : Colors.white.withOpacity(0.8),
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        letterSpacing: 0.5,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isSparePartsDropdownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: isSelected || isLabelHovered
                          ? Colors.white
                          : Colors.white70,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // The dropdown content
        if (isSparePartsDropdownOpen)
          Positioned(
            top: _navbarHeight - 2,
            left: 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) {
                setState(() {
                  isSparePartsDropdownHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isSparePartsDropdownHovered = false;
                  // Only close if we're not hovering the main item
                  if (hoveredIndex != index) {
                    isSparePartsDropdownOpen = false;
                  }
                });
              },
              child: Material(
                color: Colors.transparent,
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: _buildSparePartsDropdownMenu(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSparePartsDropdownMenu() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A2A2A),
            Color(0xFF1A1A1A),
            Colors.black,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.red.shade800, Colors.red.shade600],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Spare Parts Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            ..._sparePartsItems.map(_buildDropdownItem).toList(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// ------------------------
  /// About Us Dropdown (Desktop)
  /// ------------------------
  Widget _buildAboutUsDropdown(int index) {
    final bool isSelected = widget.selectedIndex == index;
    final bool isLabelHovered = hoveredIndex == index;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The "About Us" label
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(() {
              hoveredIndex = index;
              isAboutUsDropdownOpen = true;
              // Close other dropdown if open
              isSparePartsDropdownOpen = false;
            });
          },
          onExit: (_) {
            // Only close if we're not hovering the dropdown content
            if (!isAboutUsDropdownHovered) {
              setState(() {
                hoveredIndex = null;
                isAboutUsDropdownOpen = false;
              });
            }
          },
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onItemSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? Colors.white
                          : (isLabelHovered
                              ? Colors.white70
                              : Colors.transparent),
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'About Us',
                      style: TextStyle(
                        color: isSelected || isLabelHovered
                            ? Colors.white
                            : Colors.white.withOpacity(0.8),
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        letterSpacing: 0.5,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isAboutUsDropdownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: isSelected || isLabelHovered
                          ? Colors.white
                          : Colors.white70,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // The dropdown content
        if (isAboutUsDropdownOpen)
          Positioned(
            top: _navbarHeight - 2,
            left: 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) {
                setState(() {
                  isAboutUsDropdownHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isAboutUsDropdownHovered = false;
                  // Only close if we're not hovering the main item
                  if (hoveredIndex != index) {
                    isAboutUsDropdownOpen = false;
                  }
                });
              },
              child: Material(
                color: Colors.transparent,
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: _buildAboutUsDropdownMenu(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAboutUsDropdownMenu() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A2A2A),
            Color(0xFF1A1A1A),
            Colors.black,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.red.shade800, Colors.red.shade600],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.business,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'About Us Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            ..._aboutUsItems.map(_buildDropdownItem).toList(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// ------------------------
  /// DROPDOWN ITEM (for both dropdowns)
  /// ------------------------
  Widget _buildDropdownItem(Map<String, dynamic> item) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          if (widget.onDropdownItemSelected != null) {
            widget.onDropdownItemSelected!(item['route']);
          }
          setState(() {
            isSparePartsDropdownOpen = false;
            isAboutUsDropdownOpen = false;
          });
        },
        hoverColor: Colors.red.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: Colors.red.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.chevron_right,
                color: Colors.redAccent,
                size: 18,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ------------------------
  /// CONTACT BUTTON (Desktop)
  /// ------------------------
  Widget _buildContactButton(int index) {
    final bool isHovered = hoveredIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: InkWell(
        onTap: () => widget.onItemSelected(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isHovered ? Colors.red.shade700 : Colors.red.shade600,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(isHovered ? 0.4 : 0.3),
                blurRadius: isHovered ? 12 : 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.phone,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                'Contacts',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================
  // MOBILE NAVBAR
  // ========================
  Widget _buildMobileNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => _showMobileMenu(context),
          ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bottomSheetContext) =>
          _buildMobileMenuContent(bottomSheetContext),
    );
  }

  Widget _buildMobileMenuContent(BuildContext bottomSheetContext) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMobileMenuHeader(bottomSheetContext),
          Expanded(child: _buildMobileMenuItems(bottomSheetContext)),
        ],
      ),
    );
  }

  Widget _buildMobileMenuHeader(BuildContext bottomSheetContext) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black87, size: 28),
            onPressed: () => Navigator.pop(bottomSheetContext),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMenuItems(BuildContext bottomSheetContext) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        _buildMobileMenuItem(bottomSheetContext, 0, 'Home'),
        _buildMobileMenuItem(bottomSheetContext, 1, 'Stock List'),
        _buildMobileSparePartsMenu(bottomSheetContext),
        _buildMobileMenuItem(bottomSheetContext, 3, 'Our Services'),
        _buildMobileAboutUsMenu(bottomSheetContext),
        _buildMobileContactItem(bottomSheetContext, 5),
        const Divider(thickness: 1),
      ],
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext bottomSheetContext,
    int index,
    String title,
  ) {
    final bool isSelected = widget.selectedIndex == index;
    return InkWell(
      onTap: () {
        widget.onItemSelected(index);
        Navigator.pop(bottomSheetContext);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.red.shade700 : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: isSelected ? Colors.red.shade700 : Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileSparePartsMenu(BuildContext bottomSheetContext) {
    return Column(
      children: [
        _buildMobileMenuItem(bottomSheetContext, 2, 'Spare Parts'),
        ..._sparePartsItems
            .map((item) => _buildMobileSubMenuItem(bottomSheetContext, item))
            .toList(),
      ],
    );
  }

  Widget _buildMobileAboutUsMenu(BuildContext bottomSheetContext) {
    return Column(
      children: [
        _buildMobileMenuItem(bottomSheetContext, 4, 'About Us'),
        ..._aboutUsItems
            .map((item) => _buildMobileSubMenuItem(bottomSheetContext, item))
            .toList(),
      ],
    );
  }

  Widget _buildMobileSubMenuItem(
      BuildContext bottomSheetContext, Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        if (widget.onDropdownItemSelected != null) {
          widget.onDropdownItemSelected!(item['route']);
        }
        Navigator.pop(bottomSheetContext);
      },
      child: Container(
        margin: const EdgeInsets.only(
            left: 40.0, right: 16.0, top: 4.0, bottom: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF2A2A2A),
              Color(0xFF1A1A1A),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.red.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.chevron_right,
              color: Colors.redAccent,
              size: 16,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileContactItem(BuildContext bottomSheetContext, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          widget.onItemSelected(index);
          Navigator.pop(bottomSheetContext);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone, size: 20),
            SizedBox(width: 8),
            Text(
              'Contacts',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
