import 'package:flutter/material.dart';

class VehicleOption {
  String name;
  int pricePerKm;
  IconData icon;

  VehicleOption({
    required this.name,
    required this.pricePerKm,
    required this.icon,
  });

  static List<VehicleOption> getOptions() {
    return [
      VehicleOption(
        name: 'Motor listrik',
        pricePerKm: 6000,
        icon: Icons.electric_moped,
      ),
      VehicleOption(
        name: 'Motor',
        pricePerKm: 7000,
        icon: Icons.two_wheeler,
      ),
      VehicleOption(
        name: 'Mobil listrik',
        pricePerKm: 13000,
        icon: Icons.electric_car,
      ),
      VehicleOption(
        name: 'Mobil',
        pricePerKm: 15000,
        icon: Icons.directions_car,
      ),
    ];
  }
}
