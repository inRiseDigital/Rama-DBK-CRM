import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    // Check if we're in mobile view
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: isMobile ? null : 70, // Keeping original height
      decoration: BoxDecoration(
        // Keeping original gradient
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.95),
            Colors.black.withOpacity(0.85),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SafeArea(
        child:
            isMobile
                ? _buildMobileNavBar(context)
                : _buildDesktopNavBar(context),
      ),
    );
  }

  Widget _buildDesktopNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: [
          _buildLogo(),
          const Spacer(), // Pushes main menu to center and search to right
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem(0, 'Home', false),
              SizedBox(width: 20), // Added spacing between items
              _buildNavItem(1, 'Stock List', false),
              SizedBox(width: 20), // Added spacing between items
              _buildNavItem(2, 'Spare Parts', true),
              SizedBox(width: 20), // Added spacing between items
              _buildNavItem(3, 'Our Services ', true),
              SizedBox(width: 20), // Added spacing between items
              _buildNavItem(4, 'About Us', true),
              SizedBox(width: 20), // Added spacing between items
              _buildContactButton(5), // Replace with special contact button
            ],
          ),
        ],
      ),
    );
  }

  // New method for contact button
  Widget _buildContactButton(int index) {
    final bool isSelected = widget.selectedIndex == index;
    final bool isHovered = hoveredIndex == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: InkWell(
        onTap: () => widget.onItemSelected(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isHovered ? Colors.red.shade700 : Colors.red.shade600,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Contacts',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _showMobileMenu(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    // Keeping original logo implementation
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/Rama_logo.png',
          errorBuilder:
              (context, error, stackTrace) => Container(
                width: 50,
                height: 50,
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
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'R',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String title, bool hasDropdown) {
    final bool isSelected = widget.selectedIndex == index;
    final bool isHovered = hoveredIndex == index;

    // Updated with a cleaner style while keeping original colors
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: InkWell(
        onTap: () => widget.onItemSelected(index),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    isSelected
                        ? Colors.white
                        : (isHovered ? Colors.white70 : Colors.transparent),
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color:
                      isSelected || isHovered
                          ? Colors.white
                          : Colors.white.withOpacity(0.8),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  letterSpacing: 0.5,
                  fontSize: 15,
                ),
              ),
              if (hasDropdown)
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color:
                        isSelected || isHovered ? Colors.white : Colors.white70,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
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
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.black87, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 8),
                    _buildMobileMenuItem(0, 'Home', false),
                    _buildMobileMenuItem(1, 'Stock List', false),
                    _buildMobileMenuItem(2, 'Spare Parts', true),
                    _buildMobileMenuItem(3, 'Our Services', true),
                    _buildMobileMenuItem(4, 'About Us', true),
                    _buildMobileContactItem(
                      5,
                    ), // Special contact item for mobile
                    Divider(thickness: 1, color: Colors.grey.withOpacity(0.2)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            28,
                          ), // More rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Add this method for the mobile contact button
  Widget _buildMobileContactItem(int index) {
    final bool isSelected = widget.selectedIndex == index;

    return InkWell(
      onTap: () {
        widget.onItemSelected(index);
        Navigator.pop(navigatorKey.currentContext!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.red.shade600,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Contacts',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(int index, String title, bool hasDropdown) {
    final bool isSelected = widget.selectedIndex == index;

    return InkWell(
      onTap: () {
        widget.onItemSelected(index);
        Navigator.pop(navigatorKey.currentContext!);
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
            if (hasDropdown)
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Colors.red.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: isSelected ? Colors.red.shade700 : Colors.black54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// For accessing navigator context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
