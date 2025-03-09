import 'package:flutter/material.dart';

class VehicleBrandsComponent extends StatelessWidget {
  final List<String> brands = ["Toyota", "BMW", "Mercedes", "Honda", "Ford"];

  VehicleBrandsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children:
          brands
              .map(
                (brand) => Chip(
                  label: Text(brand),
                  backgroundColor: Colors.red.shade100,
                ),
              )
              .toList(),
    );
  }
}
