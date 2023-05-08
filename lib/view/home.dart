import 'package:apk_catatan_keuangan_harian/view/catatan/caku_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dashboard/dashboard_screen.dart';
import 'history/history_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool isExpense;
  late DateTime selectDate;
  late List<Widget> _children;
  late int currentIndex;
  int selectedIndex = 0;
  bool _isFabExpanded = false;

  void _navigateToForm(bool isExpense) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: 800),
        reverseDuration: const Duration(milliseconds: 800),
        child: FormCaku(
          isExpense: isExpense,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    updateView(0);
    super.initState();
  }

  void updateView(int index) {
    setState(() {
      currentIndex = index;
      _children = [const Dashboard(), const HistoryPage()];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _children[currentIndex],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              backgroundColor: const Color(0xffd59caf),
              onPressed: () {
                setState(() {
                  _isFabExpanded = !_isFabExpanded;
                });
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
          if (_isFabExpanded)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      _navigateToForm(false);
                    },
                    icon: const Icon(
                      Icons.monetization_on,
                      color: Color(0xffC3516B),
                    ),
                    label: const Text(
                      'Pemasukan',
                      style: TextStyle(color: Color(0xffC3516B)),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _navigateToForm(true);
                    },
                    icon: const Icon(
                      Icons.shopping_basket,
                      color: Color(0xffC3516B),
                    ),
                    label: const Text(
                      'Pengeluaran',
                      style: TextStyle(color: Color(0xffC3516B)),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  updateView(
                    0,
                  );
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  updateView(
                    1,
                  );
                },
                icon: const Icon(Icons.list_alt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
