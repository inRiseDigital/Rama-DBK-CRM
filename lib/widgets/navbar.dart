import 'package:flutter/material.dart';

/// A responsive navigation bar that adapts between desktop and mobile layouts.
/// Handles navigation state and user interactions for the main app navigation.
class NavBar extends StatefulWidget {
  /// The index of the currently selected navigation item
  final int selectedIndex;

  /// Callback function when a navigation item is selected
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
  /// Tracks which navigation item is currently being hovered
  int? hoveredIndex;

  // Constants for responsive breakpoints
  static const double _mobileBreakpoint = 768;
  static const double _navbarHeight = 70;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < _mobileBreakpoint;

    return Container(
      height: isMobile ? null : _navbarHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.95),
            Colors.black.withOpacity(0.85),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: const [
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

  /// Builds the desktop version of the navigation bar
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
              _buildNavItem(0, 'Home', false),
              const SizedBox(width: 20),
              _buildNavItem(1, 'Stock List', false),
              const SizedBox(width: 20),
              _buildNavItem(2, 'Spare Parts', true),
              const SizedBox(width: 20),
              _buildNavItem(3, 'Our Services', true),
              const SizedBox(width: 20),
              _buildNavItem(4, 'About Us', true),
              const SizedBox(width: 20),
              _buildContactButton(5),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the mobile version of the navigation bar with hamburger menu
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

  /// Builds the company logo with fallback to letter 'R' if image fails to load
  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
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
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }

  /// Builds a navigation item for the desktop view
  Widget _buildNavItem(int index, String title, bool hasDropdown) {
    final bool isSelected = widget.selectedIndex == index;
    final bool isHovered = hoveredIndex == index;

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
                  padding: const EdgeInsets.only(left: 4.0),
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

  /// Builds the contact button for the desktop view
  Widget _buildContactButton(int index) {
    final bool isHovered = hoveredIndex == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: InkWell(
        onTap: () => widget.onItemSelected(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isHovered ? Colors.red.shade700 : Colors.red.shade600,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
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

  /// Shows the mobile menu as a bottom sheet
  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (BuildContext bottomSheetContext) =>
              _buildMobileMenuContent(bottomSheetContext),
    );
  }

  /// Builds the content of the mobile menu
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

  /// Builds the header of the mobile menu
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

  /// Builds the list of menu items for the mobile view
  Widget _buildMobileMenuItems(BuildContext bottomSheetContext) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        _buildMobileMenuItem(bottomSheetContext, 0, 'Home', false),
        _buildMobileMenuItem(bottomSheetContext, 1, 'Stock List', false),
        _buildMobileMenuItem(bottomSheetContext, 2, 'Spare Parts', true),
        _buildMobileMenuItem(bottomSheetContext, 3, 'Our Services', true),
        _buildMobileMenuItem(bottomSheetContext, 4, 'About Us', true),
        _buildMobileContactItem(bottomSheetContext, 5),
        const Divider(thickness: 1),
      ],
    );
  }

  /// Builds a mobile menu item
  Widget _buildMobileMenuItem(
    BuildContext bottomSheetContext,
    int index,
    String title,
    bool hasDropdown,
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
            if (hasDropdown)
              Container(
                padding: const EdgeInsets.all(4),
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

  /// Builds the contact button for the mobile menu
  Widget _buildMobileContactItem(BuildContext bottomSheetContext, int index) {
    return InkWell(
      onTap: () {
        widget.onItemSelected(index);
        Navigator.pop(bottomSheetContext);
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
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
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
}
