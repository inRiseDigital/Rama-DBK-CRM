import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/spare_parts_components/spare_list_component.dart';
import 'package:rama_dbk_crm/spare_parts_components/spare_parts_description.dart';
import 'package:rama_dbk_crm/spare_parts_components/spare_parts_hero_component.dart';

class SparePartsScreen extends StatelessWidget {
  const SparePartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // Spare Parts Hero Section
          SparePartsHeroComponent(),

          // Spare Parts List Section
          SpareListComponent(),

          // Description Section
          SparePartsDescription(),
        ],
      ),
    );
  }
}
