import 'package:apk_catatan_keuangan_harian/view_model/db_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../model/data_category.dart';
import '../../components/card_category.dart';

class CategoryPage extends StatefulWidget {
  final bool isExpense;
  final Categoryes? categoryModel;
  const CategoryPage({
    Key? key,
    this.categoryModel,
    required this.isExpense,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isExpense = false;
  int type = 1;
  final categoryNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _isExpense = widget.isExpense;
      type = (_isExpense) ? 2 : 1;
    });
    super.initState();
  }

  void openDialog(Categoryes? category) {
    categoryNameController.clear();
    if (category != null) {
      categoryNameController.text = category.name;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    (category != null) ? 'Edit Kategori' : 'Add Kategori',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: const Color(0xffc3516b),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: categoryNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 20),
                        backgroundColor: const Color(0xffc3516b)),
                    onPressed: () async {
                      if (category == null) {
                        final cate = Categoryes(
                            name: categoryNameController.text,
                            type: _isExpense ? 'Expense' : 'Income');
                        await Provider.of<CategoryManager>(context, listen: false)
                            .addCategory(cate);
                      } else {
                        final cate = Categoryes(
                            id: category.id,
                            name: categoryNameController.text,
                            type: category.type);
                        Provider.of<CategoryManager>(context, listen: false)
                            .updateCategory(cate);
                      }
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text(
                      category != null ? 'Update' : 'Save',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isExpense ? 'List Pengeluaran' : 'List Pemasukan',
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              openDialog(null);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: const Color(0xffE5E7E9),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<CategoryManager>(
              builder: (context, manager, child) {
                final categoriItems = manager.categoryModels
                    .where((category) =>
                        category.type == (_isExpense ? 'Expense' : 'Income'))
                    .toList();
                if (categoriItems.isEmpty) {
                  return const Center(
                    child: Text('No items found'),
                  );
                }
                return AnimationLimiter(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoriItems.length,
                    itemBuilder: (context, index) {
                      final item = categoriItems[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 30,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () async {
                                openDialog(categoriItems[index]);
                              },
                              child: CardPage(
                                categorys: item,
                                onPressed: () {
                                  manager.deleteCategory(item.id!);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('${item.name} Deleted')),
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
        ),
      ),
    );
  }
}
