import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/spare_parts_components/spare_list_component.dart';
import 'package:rama_dbk_crm/spare_parts_components/spare_parts_description.dart';
import 'package:rama_dbk_crm/spare_parts_components/spare_parts_hero_component.dart';

class SparePartsScreen extends StatelessWidget {
  const SparePartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SparePartsHeroComponent(),
                SizedBox(height: 64),
                Text(
                  'Spare Parts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Browse our extensive collection of genuine spare parts for all vehicle makes and models. We ensure quality and compatibility for your vehicle.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF718096),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 48),
                SpareListComponent(),
                SizedBox(height: 48),
                SparePartsDescription(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
