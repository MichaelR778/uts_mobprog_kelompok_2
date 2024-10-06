import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/models/transaction.dart';
import 'package:uts_mobprog_kelompok_2/pages/histrory_detail_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/root.dart';

class HistoryTransactionScreen extends StatefulWidget {
  const HistoryTransactionScreen({super.key});

  @override
  State<HistoryTransactionScreen> createState() =>
      _HistoryTransactionScreenState();
}

class _HistoryTransactionScreenState extends State<HistoryTransactionScreen> {
  final List<Transaction> transactions = getDummyTransactions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text('Riwayat', style: TextStyle(color: color9, fontSize: 24)),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: color9,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: colorBlack.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HistroryDetailScreen(transaction: transaction),
                        ),
                      );
                    },
                    leading: Image.asset(
                      transaction.vehicleImage,
                      width: 60,
                      height: 60,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        transaction.destination,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: transaction.status == 'Perjalanan Selesai'
                              ? color1
                              : colorGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            '${transaction.transactionTime}',
                            style: TextStyle(
                              color: transaction.status == 'Perjalanan Selesai'
                                  ? colorBlack
                                  : colorGrey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            'Rp${NumberFormat('#,##0', 'id_ID').format(transaction.amount)}',
                            style: TextStyle(
                              color: transaction.status == 'Perjalanan Selesai'
                                  ? colorBlack
                                  : colorGrey,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              transaction.status == 'Perjalanan Selesai'
                                  ? Icons.check_circle_rounded
                                  : Icons.cancel,
                              color: transaction.status == 'Perjalanan Selesai'
                                  ? color2
                                  : colorGrey,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              transaction.status,
                              style: TextStyle(
                                color:
                                    transaction.status == 'Perjalanan Selesai'
                                        ? color2
                                        : colorGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const Root(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            transaction.status == 'Perjalanan Selesai'
                                ? color2
                                : colorGrey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        minimumSize: const Size(80, 30),
                      ),
                      child: const Text('Pesan Lagi',
                          style: TextStyle(color: color9)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
