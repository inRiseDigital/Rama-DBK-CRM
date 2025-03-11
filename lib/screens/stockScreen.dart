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
        children: [
          const StockHeroComponent(),
          // 🔍 Filter Section
          FilterComponent(onFilterChanged: _handleFilterChange),
          const SizedBox(height: 20),

          VehicleStock(filters: _currentFilters),
        ],
      ),
    );
  }
}
