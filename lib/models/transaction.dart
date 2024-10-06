class Transaction {
  final String vehicleImage;
  final String pickupLocation;
  final String transactionTime;
  final int amount;
  final String status;
  final String destination;

  Transaction({
    required this.vehicleImage,
    required this.pickupLocation, 
    required this.transactionTime,
    required this.amount,
    required this.status,
    required this.destination,
  });
}

List<Transaction> getDummyTransactions() {
  return [
    Transaction(
      vehicleImage: 'images/vehicle/motor.png',
      pickupLocation: 'Jl. Kebon Jeruk 21',
      transactionTime: '2024-10-01 10:00',
      amount: 12000,
      status: 'Perjalanan Selesai',
      destination: 'Jl. Letjen S.Parman No. 1',
    ),
    Transaction(
      vehicleImage: 'images/vehicle/mobil_cancel.png',
      pickupLocation: 'Jl. Fatmawati No. 45',
      transactionTime: '2024-10-02 14:30',
      amount: 20000,
      status: 'Pesanan Dibatalkan',
      destination: 'Jl. Bahagia 1',
    ),
    Transaction(
      vehicleImage: 'images/vehicle/mobil_listrik_cancel.png',
      pickupLocation: 'Jl. Gajah Mada No. 12',
      transactionTime: '2024-10-03 11:15',
      amount: 24500,
      status: 'Perjalanan Dibatalkan',
      destination: 'Universitas Indonesia',
    ),
    Transaction(
      vehicleImage: 'images/vehicle/mobil_listrik.png',
      pickupLocation: 'Jl. Sudirman No. 45',
      transactionTime: '2024-10-03 11:15',
      amount: 18000,
      status: 'Perjalanan Selesai',
      destination: 'Universitas Tarumanagara',
    ),
    Transaction(
      vehicleImage: 'images/vehicle/motor_listrik.png',
      pickupLocation: 'Jl. Kebayoran Baru',
      transactionTime: '2024-10-04 15:00',
      amount: 16000,
      status: 'Perjalanan Selesai',
      destination: 'Mall Ciputra, Jakarta Barat',
    ),
    Transaction(
      vehicleImage: 'images/vehicle/mobil.png',
      pickupLocation: 'Jl. Tanjung Barat Lama',
      transactionTime: '2024-10-05 09:45',
      amount: 20000,
      status: 'Perjalanan Selesai',
      destination: 'Jl. Tanjung Barat 2',
    ),
    Transaction(
      vehicleImage: 'images/vehicle/motor_cancel.png',
      pickupLocation: 'Jl. Kalibaru Barat',
      transactionTime: '2024-10-06 12:30',
      amount: 12500,
      status: 'Pesanan Dibatalkan',
      destination: 'Jl. Kalibaru 2',
    ),
    Transaction(
      vehicleImage: 'images/vehicle/motor.png',
      pickupLocation: 'Jl. Pangeran Jayakarta',
      transactionTime: '2024-10-07 13:00',
      amount: 18000,
      status: 'Perjalanan Selesai',
      destination: 'Jl. Bukit Tinggi 2',
    ),
    Transaction(
      vehicleImage: 'images/vehicle/motor_listrik.png',
      pickupLocation: 'Jl. Mangga Besar 4',
      transactionTime: '2024-10-06 14:00',
      amount: 12000,
      status: 'Perjalanan Selesai',
      destination: 'Universitas Tarumanagara',
    ),
  ];
}
