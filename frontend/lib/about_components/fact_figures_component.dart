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

  // Modern color scheme
  final Color primaryRed = const Color(0xFFE53E3E);
  final Color lightRed = const Color(0xFFFED7D7);
  final Color darkText = const Color(0xFF1A202C);
  final Color greyText = const Color(0xFF4A5568);
  final Color dividerColor = const Color(0xFFE2E8F0);

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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width < 600 ? 16 : 24,
                    vertical: MediaQuery.of(context).size.width < 600 ? 40 : 60,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTitleSection(),
                      const SizedBox(height: 50),
                      _buildMainLayout(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Facts & Figures",
          style: TextStyle(
            fontSize: screenWidth < 600 ? 32 : 42,
            fontWeight: FontWeight.bold,
            color: darkText,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 4,
          color: primaryRed,
        ),
        const SizedBox(height: 20),
        Text(
          "Key Information About RamaDBK Ltd.",
          style: TextStyle(
            fontSize: screenWidth < 600 ? 18 : 20,
            color: greyText,
            letterSpacing: 0.5,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMainLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 800;
        final isTablet = screenWidth >= 800 && screenWidth < 1200;

        if (isMobile) {
          return _buildMobileLayout();
        } else if (isTablet) {
          return _buildTabletLayout();
        } else {
          return _buildDesktopLayout();
        }
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCompanyDetailsSection(),
        const SizedBox(height: 48),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: _buildInfoSection("Main Banks", [
            "Resona Bank, Ltd",
            "Sumitomo Mitsui Banking Corporation",
            "Bank of Tokyo-Mitsubishi UFJ Ltd.",
            "Mizuho Bank Ltd.",
            "Yokohama Shinkin Bank",
          ]),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: _buildInfoSection("Global Network", [
            "RamaDBK Ltd. - Headquarters (Japan)",
            "Rama Group - Global Operations",
            "Auto Mac - Sri Lanka Operations",
            "Ramanayake Automobiles - Sri Lanka",
            "Partner Network in 50+ Countries",
          ]),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: _buildInfoSection("Certifications & Memberships", [
            "JUMVEA (Japan Used Motor Vehicle Exporters Association)",
            "SLBCJ (Sri Lanka Business Council Japan)",
            "SLAAJ (Sri Lanka Automobile Association in Japan)",
            "ISO 9001:2015 Certified",
            "Authorized Economic Operator (AEO) Status",
          ]),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        _buildCompanyDetailsSection(),
        const SizedBox(height: 48),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: _buildInfoSection("Main Banks", [
                  "Resona Bank, Ltd",
                  "Sumitomo Mitsui Banking Corporation",
                  "Bank of Tokyo-Mitsubishi UFJ Ltd.",
                  "Mizuho Bank Ltd.",
                  "Yokohama Shinkin Bank",
                ]),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: _buildInfoSection("Global Network", [
                  "RamaDBK Ltd. - Headquarters (Japan)",
                  "Rama Group - Global Operations",
                  "Auto Mac - Sri Lanka Operations",
                  "Ramanayake Automobiles - Sri Lanka",
                  "Partner Network in 50+ Countries",
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: _buildInfoSection("Certifications & Memberships", [
            "JUMVEA (Japan Used Motor Vehicle Exporters Association)",
            "SLBCJ (Sri Lanka Business Council Japan)",
            "SLAAJ (Sri Lanka Automobile Association in Japan)",
            "ISO 9001:2015 Certified",
            "Authorized Economic Operator (AEO) Status",
          ]),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: _buildCompanyDetailsSection(),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: _buildInfoSection("Main Banks", [
                  "Resona Bank, Ltd",
                  "Sumitomo Mitsui Banking Corporation",
                  "Bank of Tokyo-Mitsubishi UFJ Ltd.",
                  "Mizuho Bank Ltd.",
                  "Yokohama Shinkin Bank",
                ]),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: _buildInfoSection("Global Network", [
                  "RamaDBK Ltd. - Headquarters (Japan)",
                  "Rama Group - Global Operations",
                  "Auto Mac - Sri Lanka Operations",
                  "Ramanayake Automobiles - Sri Lanka",
                  "Partner Network in 50+ Countries",
                ]),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: _buildInfoSection("Certifications & Memberships", [
                  "JUMVEA (Japan Used Motor Vehicle Exporters Association)",
                  "SLBCJ (Sri Lanka Business Council Japan)",
                  "SLAAJ (Sri Lanka Automobile Association in Japan)",
                  "ISO 9001:2015 Certified",
                  "Authorized Economic Operator (AEO) Status",
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyDetailsSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.business, color: primaryRed, size: isMobile ? 24 : 28),
            SizedBox(width: isMobile ? 12 : 16),
            Text(
              "Company Details",
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: darkText,
                height: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 24 : 30),
        _buildCompanyDetailsTable(),
      ],
    );
  }

  Widget _buildCompanyDetailsTable() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Table(
      columnWidths: {
        0: FlexColumnWidth(isMobile ? 0.8 : 1),
        1: FlexColumnWidth(isMobile ? 1.2 : 2)
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: [
        _buildTableRow("Corporate Name", "RamaDBK Ltd."),
        _buildTableRow(
          "Address",
          "2-14-8 Tsuruyacho, Kanagawa-ku, Yokohama-shi, Kanagawa 221-0835, Japan",
        ),
        _buildTableRow("Telephone", "+81-45-402-6117"),
        _buildTableRow("Fax", "+81-45-402-0689"),
        _buildTableRow("Email", "info@ramadbk.com"),
        _buildTableRow("Website", "www.ramadbk.com"),
        _buildTableRow("Established", "1988"),
        _buildTableRow("Capital", "¥ 10,000,000"),
        _buildTableRow("President", "Jagath C. Ramanayake"),
        _buildTableRow("Annual Turnover", "10,643M JPY (2023-24)"),
        _buildTableRow("Number of Employees", "50+"),
        _buildTableRow(
          "Business Activities",
          "Export of Japanese Used Vehicles, New Vehicles, and Spare Parts",
        ),
      ],
    );
  }

  TableRow _buildTableRow(String key, String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 12 : 16,
          ),
          child: Text(
            key,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 12 : 16,
            horizontal: isMobile ? 12 : 20,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: greyText,
              height: 1.5,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<String> values) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              _getIconForTitle(title),
              color: primaryRed,
              size: isMobile ? 20 : 24,
            ),
            SizedBox(width: isMobile ? 12 : 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 16 : 20),
        ...values.map((item) => _buildListItem(item)).toList(),
      ],
    );
  }

  Widget _buildListItem(String item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 6 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: isMobile ? 7 : 9),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: greyText,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case "Main Banks":
        return Icons.account_balance;
      case "Global Network":
        return Icons.public;
      case "Certifications & Memberships":
        return Icons.verified;
      default:
        return Icons.info;
    }
  }
}
