import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/models/transaction.dart';

class HistroryDetailScreen extends StatefulWidget {
  final Transaction transaction;

  const HistroryDetailScreen({super.key, required this.transaction});

  @override
  State<HistroryDetailScreen> createState() => _HistroryDetailScreenState();
}

class _HistroryDetailScreenState extends State<HistroryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Pesanan', style: TextStyle(color: color9)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: color9),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: color1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      backgroundColor: color9,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  widget.transaction.vehicleImage,
                  width: 60,
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.transaction.status}',
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.transaction.status == 'Perjalanan Selesai' ? color2 : colorGrey,
                      ),
                    ),
                    Text(
                      '${widget.transaction.transactionTime}',
                      style: const TextStyle(fontSize: 16, color: colorBlack),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 5),
            const Text(
              'Detail Perjalanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
            ),
            const SizedBox(height: 5),
            const Text(
              'Lokasi Jemput',
              style: TextStyle(fontSize: 14, color: colorGrey),
            ),
            Row(
              children: [
                const Icon(Icons.location_on, color: color2, size: 24),
                const SizedBox(width: 10),
                Text(
                  '${widget.transaction.pickupLocation}',
                  style: const TextStyle(fontSize: 20, color: colorBlack),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Lokasi Tujuan',
              style: TextStyle(fontSize: 14, color: colorGrey),
            ),
            Row(
              children: [
                const Icon(Icons.flag, color: color1, size: 24),
                const SizedBox(width: 10),
                Text(
                  '${widget.transaction.destination}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: color1,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 5),
            const Text(
              'Detail Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Biaya',
                  style: TextStyle(fontSize: 16, color: colorBlack),
                ),
                Text(
                  'Rp${NumberFormat('#,##0', 'id_ID').format(widget.transaction.amount)}',
                  style: const TextStyle(fontSize: 16, color: colorBlack),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
