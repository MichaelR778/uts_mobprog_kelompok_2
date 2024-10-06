import 'package:flutter/material.dart';
import 'package:uts_mobprog_kelompok_2/models/locations.dart';
import 'package:uts_mobprog_kelompok_2/models/vehicle_option.dart';

class OrderProvider extends ChangeNotifier {
  final List<VehicleOption> _vechicleOptions = [
    VehicleOption(
      name: 'Motor listrik',
      pricePerKm: 6000,
      iconPath: 'images/vehicle/motor_listrik.png',
    ),
    VehicleOption(
      name: 'Motor',
      pricePerKm: 7000,
      iconPath: 'images/vehicle/motor.png',
    ),
    VehicleOption(
      name: 'Mobil listrik',
      pricePerKm: 13000,
      iconPath: 'images/vehicle/mobil_listrik.png',
    ),
    VehicleOption(
      name: 'Mobil',
      pricePerKm: 15000,
      iconPath: 'images/vehicle/mobil.png',
    ),
  ];

  bool _orderOngoing = false;
  Locations? _locations;
  VehicleOption _selectedOption = VehicleOption(
    name: 'Motor listrik',
    pricePerKm: 6000,
    iconPath: 'images/vehicle/motor_listrik.png',
  );

  // getter
  List<VehicleOption> get vehicleOptions => _vechicleOptions;
  bool get orderOngoing => _orderOngoing;
  Locations? get locations => _locations;
  VehicleOption get selectedOption => _selectedOption;

  // setter
  set orderOngoing(bool isOngoing) {
    _orderOngoing = isOngoing;
    notifyListeners();
  }

  set locations(Locations? newLocations) {
    _locations = newLocations;
    notifyListeners();
  }

  set selectedOption(VehicleOption newSelected) {
    _selectedOption = newSelected;
    notifyListeners();
  }
}
