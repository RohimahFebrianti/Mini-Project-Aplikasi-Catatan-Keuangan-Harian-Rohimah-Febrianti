import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/data_category.dart';

class CardPage extends StatefulWidget {
  final Categoryes categorys;
  final Function() onPressed;

  const CardPage({
    Key? key,
    required this.categorys,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.categorys.type == 'Expense'
                    ? Icons.arrow_circle_up
                    : Icons.arrow_circle_down,
                color: widget.categorys.type == 'Expense'
                    ? Colors.redAccent[400]
                    : Colors.greenAccent[400],
                size: 30,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(widget.categorys.name,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                        'Yakin mau hapus kategori ini ?',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'NO',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onPressed,
                          child: Text(
                            'YES',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffC3516B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete_forever_sharp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
