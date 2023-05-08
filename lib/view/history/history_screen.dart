import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/data_caku.dart';
import '../../view_model/caku_manager.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _selectedOption = '';
  bool _showAll = true;
  final formatter =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_alt),
            onSelected: (String value) {
              setState(() {
                _selectedOption = value;
                _showAll = _selectedOption == 'All';
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'All',
                child: Text('Semua'),
              ),
              const PopupMenuItem(
                value: 'Income',
                child: Text('Pemasukan'),
              ),
              const PopupMenuItem(
                value: 'Expense',
                child: Text('Pengeluaran'),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xffE5E7E9),
      body: listHistory(),
    );
  }

  Widget listHistory() {
    return Consumer<CakuManager>(
      builder: (context, manager, child) {
        List<Caku> cakuItems;
        if (_showAll) {
          cakuItems = manager.cakuListModels;
        } else {
          cakuItems = manager.cakuListModels
              .where((item) => item.type == _selectedOption)
              .toList();
        }
        if (cakuItems.isEmpty) {
          return Center(
            child: Text('No items found'),
          );
        }
        return AnimationLimiter(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cakuItems.length,
            itemBuilder: (context, index) {
              final item = cakuItems[index];
              bool isExpense = item.type == 'Expense';
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    horizontalOffset: 50,
                    child: FadeInAnimation(
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              isExpense
                                  ? Icons.arrow_circle_up
                                  : Icons.arrow_circle_down,
                              color: isExpense
                                  ? Colors.red[400]
                                  : Colors.greenAccent[400],
                              size: 30,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cakuItems[index].date,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                cakuItems[index].description.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                formatter.format(cakuItems[index].amount),
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
