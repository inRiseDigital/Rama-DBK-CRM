import 'package:flutter/material.dart';

class FactFiguresComponent extends StatefulWidget {
  const FactFiguresComponent({Key? key}) : super(key: key);

  @override
  _FactFiguresComponentState createState() => _FactFiguresComponentState();
}

class _FactFiguresComponentState extends State<FactFiguresComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitleSection(),
                const SizedBox(height: 30),
                _buildMainLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Title Section
  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          "Facts & Figures",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(width: 50, height: 3, color: Colors.red),
        const SizedBox(height: 12),
        Text(
          "Key Information About RamaDBK Ltd.",
          style: TextStyle(fontSize: 16, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Main Layout - Fixes Overflow Issue
  Widget _buildMainLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isMobile) ...[
              _buildCompanyDetailsCard(),
              const SizedBox(height: 20),
              _buildAutoHeightInfoCard("Main Banks", [
                "Resona Bank, Ltd",
                "Sumitomo Mitsui Banking Corporation",
                "Bank of Tokyo-Mitsubishi UFJ Ltd.",
                "Mizuho Bank Ltd.",
                "Yokohama Shinkin Bank",
              ]),
              const SizedBox(height: 20),
              _buildAutoHeightInfoCard("Subsidiaries", [
                "Rama Group, Japan",
                "Auto Mac, Sri Lanka",
                "Ramanayake Automobiles, Sri Lanka",
              ]),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildCompanyDetailsCard()),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildAutoHeightInfoCard("Main Banks", [
                          "Resona Bank, Ltd",
                          "Sumitomo Mitsui Banking Corporation",
                          "Bank of Tokyo-Mitsubishi UFJ Ltd.",
                          "Mizuho Bank Ltd.",
                          "Yokohama Shinkin Bank",
                        ]),
                        const SizedBox(height: 20),
                        _buildAutoHeightInfoCard("Subsidiaries", [
                          "Rama Group, Japan",
                          "Auto Mac, Sri Lanka",
                          "Ramanayake Automobiles, Sri Lanka",
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  /// Company Details Card
  Widget _buildCompanyDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Company Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          _buildCompanyDetailsTable(),
        ],
      ),
    );
  }

  /// Table Layout for Company Details
  Widget _buildCompanyDetailsTable() {
    return Table(
      columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
      children: [
        _buildTableRow("Corporate Name", "RamaDBK Ltd."),
        _buildTableRow("Address", "201 Rama HQ, Yokohama, Japan"),
        _buildTableRow("Telephone", "+81-45-402-6117"),
        _buildTableRow("Fax", "+81(45)-402-0689"),
        _buildTableRow("Website", "www.ramadbk.com"),
        _buildTableRow("Established", "1988"),
        _buildTableRow("Capital", "¥ 10,000,000"),
        _buildTableRow("President", "Jagath C. Ramanayake"),
        _buildTableRow("Annual Turnover", "10,643M JPY (2023-24)"),
      ],
    );
  }

  /// Helper function for table rows
  TableRow _buildTableRow(String key, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            key,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  /// Auto-Height Info Cards (Fixes Overflow)
  Widget _buildAutoHeightInfoCard(String title, List<String> values) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 180,
      ), // Ensures enough space for both cards
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                values
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "• $item",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
