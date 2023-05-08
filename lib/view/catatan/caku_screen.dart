import 'package:apk_catatan_keuangan_harian/view/kategori/category_screen.dart';
import 'package:apk_catatan_keuangan_harian/view/dashboard/dashboard_screen.dart';
import 'package:apk_catatan_keuangan_harian/view_model/db_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../model/data_caku.dart';
import '../../model/data_category.dart';
import '../../style/decoration.dart';
import '../../view_model/caku_manager.dart';

class FormCaku extends StatefulWidget {
  final bool isExpense;
  final Caku? cakuModel;
  const FormCaku({
    Key? key,
    this.cakuModel,
    required this.isExpense,
  }) : super(key: key);

  @override
  State<FormCaku> createState() => _FormCakuState();
}

class _FormCakuState extends State<FormCaku> {
  late bool _isExpense;
  bool _isUpdate = false;
  final DateTime _selectedDate = DateTime.now();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  Categoryes? _selectedCategory;

  @override
  void initState() {
    setState(() {
      _isExpense = widget.isExpense;
    });
    if (widget.cakuModel != null) {
      amountController.text = widget.cakuModel!.amount.toString();
      descriptionController.text = widget.cakuModel!.description;
      dateController.text = widget.cakuModel!.date;
      // _selectedCategory = widget.cakuModel!.categoryId;
      _isUpdate = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _navigateToForm(bool isExpense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage(isExpense: isExpense),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isExpense ? 'Form Pengeluaran' : 'Form Pemasukan',
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              fromField(context),
              buildButton(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _navigateToForm(_isExpense);
                    },
                    child: Text(
                      _isExpense
                          ? 'Tambah Kategori Pengeluaran'
                          : 'Tambah Kategori Pemasukan',
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fromField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecorationStyle.inputDecorationStyle(
              labelText: 'Jumlah Uang',
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<CategoryManager>(
            builder: (context, manager, child) {
              final categoryItems = manager.categoryModels
                  .where((category) =>
                      category.type == (_isExpense ? 'Expense' : 'Income'))
                  .toList();
              return Column(
                children: [
                  Visibility(
                    visible: !_isUpdate,
                    child: DropdownButtonFormField<Categoryes>(
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Category',
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                      items: categoryItems
                          .map((category) => DropdownMenuItem(
                              value: category, child: Text(category.name)))
                          .toList(),
                      //  value: _selectedCategory, // tambahkan initialValue
                      validator: (value) {
                        if (value == null) {
                          return 'Category is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
        Visibility(
          visible: !_isUpdate,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: dateController,
              decoration: InputDecorationStyle.inputDecorationStyle(
                  labelText: 'Tanggal',
                  suffixIcon: const Icon(Icons.calendar_month)),
              readOnly: true,
              onTap: () async {
                DateTime? selectDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
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
                if (selectDate != null) {
                  //print(selectDate);
                  final formatDate =
                      DateFormat('dd MMMM yyyy').format(_selectedDate);
                  //print(formatDate);
                  setState(() {
                    dateController.text = formatDate;
                  });
                } else {
                  print('Date is not selected');
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date is required';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: descriptionController,
            decoration: InputDecorationStyle.inputDecorationStyle(
              labelText: 'Deskripsi',
            ),
          ),
        ),
      ],
    );
  }

  Container buildButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(800, 35),
            backgroundColor: const Color(0xffc3516b)),
        onPressed: () async {
          final typeValue = _isExpense ? 'Expense' : 'Income';

          if (!_isUpdate) {
            final newCaku = Caku(
                amount: int.parse(amountController.text),
                categoryId: _selectedCategory!.id!,
                description: descriptionController.text,
                date: dateController.text,
                type: typeValue);
            await Provider.of<CakuManager>(context, listen: false)
                .addCaku(newCaku);
            int amount = int.parse(amountController.text);
            CakuManager cakuManager =
                Provider.of<CakuManager>(context, listen: false);
            if (widget.isExpense) {
              cakuManager.tambahPengeluaran(amount);
            } else {
              cakuManager.tambahPemasukan(amount);
            }
          } else {
            final updateCaku = Caku(
                id: widget.cakuModel!.id,
                amount: int.parse(amountController.text),
                categoryId: _selectedCategory?.id ?? 0,
                description: descriptionController.text,
                date: dateController.text,
                type: typeValue);
            Provider.of<CakuManager>(context, listen: false)
                .updateCaku(updateCaku);
            // int amount = int.parse(amountController.text);
            // CakuManager cakuManager =
            //     Provider.of<CakuManager>(context, listen: false);
            // if (widget.isExpense) {
            //   cakuManager.updatePengeluaran(widget.cakuModel!.id!, amount);
            // } else {
            //   cakuManager.updatePemasukan(widget.cakuModel!.id!, amount);
            // }
          }
          Navigator.pop(context);
        },
        child: Text(
          _isUpdate ? 'Update' : 'Save',
          style: GoogleFonts.montserrat(fontSize: 16),
        ),
      ),
    );
  }
}
