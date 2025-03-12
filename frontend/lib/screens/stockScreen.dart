import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/stock_component/filter_component.dart';
import 'package:rama_dbk_crm/stock_component/stock_hero_component.dart';
import 'package:rama_dbk_crm/stock_component/vehicle_stock_component.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  // Filter state
  Map<String, String?> _currentFilters = {};

  // Handle filter changes
  void _handleFilterChange(
    String? brand,
    String? model,
    String? steering,
    String? yearFrom,
    String? yearTo,
    String? priceFrom,
    String? priceTo,
    String? type,
    String? bodyType,
    String? engine,
    String? transmission,
    String? drive,
    String? fuel,
    String? country,
    String? stockNumber,
    String? search,
    Map<String, bool>? tags,
  ) {
    setState(() {
      _currentFilters = {
        'brand': brand,
        'model': model,
        'steering': steering,
        'yearFrom': yearFrom,
        'yearTo': yearTo,
        'priceFrom': priceFrom,
        'priceTo': priceTo,
        'type': type,
        'bodyType': bodyType,
        'engine': engine,
        'transmission': transmission,
        'drive': drive,
        'fuel': fuel,
        'country': country,
        'stockNumber': stockNumber,
        'search': search,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const StockHeroComponent(),
                const SizedBox(height: 64),
                const Center(
                  child: Text(
                    'Vehicle Stock',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Browse our extensive collection of quality vehicles. Use our advanced filters to find the perfect match for your needs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF718096),
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                FilterComponent(onFilterChanged: _handleFilterChange),
                const SizedBox(height: 32),
                VehicleStock(filters: _currentFilters),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
