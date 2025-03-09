import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/stock_component/filter_component.dart';
import 'package:rama_dbk_crm/stock_component/stock_hero_component.dart';
import 'package:rama_dbk_crm/stock_component/vehicle_stock_component.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          StockHeroComponent(),
          // 🔍 Filter Section
          FilterComponent(),
          SizedBox(height: 20),

          VehicleStock(),
        ],
      ),
    );
  }
}
