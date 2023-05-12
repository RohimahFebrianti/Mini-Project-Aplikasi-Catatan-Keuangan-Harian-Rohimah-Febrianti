import 'package:apk_catatan_keuangan_harian/components/profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view_model/caku_manager.dart';
import '../../components/card_caku.dart';
import '../catatan/caku_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences logindata;
  String username = '';
  DateTime _selectedDate = DateTime.now();
  final formatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void _previousMonth() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cakuManager = Provider.of<CakuManager>(context);
    int totalPemasukan = cakuManager.getTotalPemasukan();
    int totalPengeluaran = cakuManager.getTotalPengeluaran();
    int saldo = totalPemasukan - totalPengeluaran;
    return SafeArea(
      child: Column(
        children: [
          Column(
            children: [
              widgetProfil(context),
              widgetSaldo(saldo),
              widgetExpenseIncome(totalPemasukan, totalPengeluaran),
              dailyReport(context),
            ],
          ),
          listDailyReport(),
        ],
      ),
    );
  }

  Widget widgetProfil(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: const Color(0xffd59caf),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const Profile(),
              );
            },
            icon: const Icon(Icons.account_circle),
          ),
          Text(
            'Hi, $username',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetSaldo(int saldo) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xffd59caf),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Financial Monitoring',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
                Text(
                  formatter.format(saldo),
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            'assets/piggybank.png',
            fit: BoxFit.cover,
          ),
          //
        ],
      ),
    );
  }

  Widget widgetExpenseIncome(int totalPemasukan, int totalPengeluaran) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xffC3516B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 200,
            width: 170,
            decoration: BoxDecoration(
              color: const Color(0xffd59caf),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Icon(
                      Icons.arrow_circle_down,
                      color: Colors.greenAccent[400],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'Pemasukan',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      formatter.format(totalPemasukan),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            width: 170,
            decoration: BoxDecoration(
              color: const Color(0xffd59caf),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Icon(
                    Icons.arrow_circle_up,
                    color: Colors.redAccent[400],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Pengeluaran',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    formatter.format(totalPengeluaran),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //
        ],
      ),
    );
  }

  Widget dailyReport(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Daily Report',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: _previousMonth,
            icon: const Icon(Icons.arrow_left),
          ),
          Expanded(
            child: Center(
              child: TextButton(
                onPressed: () async {
                  final selectData = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(1990),
                    lastDate: DateTime(_selectedDate.year + 5),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: const Color(
                              0xffd59caf), // Mengubah warna skema warna
                          buttonTheme: const ButtonThemeData(
                            textTheme: ButtonTextTheme
                                .primary, // Mengubah warna teks tombol
                            buttonColor:
                                Color(0xffd59caf), // Mengubah warna tombol
                          ),
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xffc3516b),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  setState(() {
                    if (selectData != null) {
                      _selectedDate = selectData;
                    }
                  });
                },
                child: Text(
                  DateFormat('dd MMMM yyyy').format(_selectedDate),
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _nextMonth,
            icon: const Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }

  Widget listDailyReport() {
    return Expanded(
      child: SingleChildScrollView(
        child: Consumer<CakuManager>(
          builder: (context, manager, child) {
            final cakuItems = manager.cakuListModels
                .where((item) =>
                    item.date ==
                    DateFormat('dd MMMM yyyy').format(_selectedDate))
                .toList();
            if (cakuItems.isEmpty) {
              return const Center(
                child: Text('No items found'),
              );
            }
            return AnimationLimiter(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cakuItems.length,
                itemBuilder: (context, index) {
                  final item = cakuItems[index];
                  bool isExpense = item.type == 'Expense';
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50,
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: () async {
                            final selecCatatan =
                                await manager.getCakuById(item.id!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormCaku(
                                  isExpense: isExpense,
                                  cakuModel: selecCatatan,
                                ),
                              ),
                            );
                          },
                          child: CardCaku(
                            catatan: item,
                            onPressed: () {
                              manager.deleteCaku(item.id!);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${item.description} Deleted'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
