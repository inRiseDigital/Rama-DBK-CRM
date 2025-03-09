import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/stock_component/filter_component.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          // 🔍 Filter Section
          FilterComponent(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
