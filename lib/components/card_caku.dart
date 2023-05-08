import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../model/data_caku.dart';

class CardCaku extends StatefulWidget {
  final Caku catatan;
  final Function() onPressed;

  const CardCaku({
    Key? key,
    required this.catatan,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CardCaku> createState() => _CardCakuState();
}

class _CardCakuState extends State<CardCaku> {
  final formatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 10,
        child: ListTile(
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                        'Yakin mau hapus data ini ?',
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
                            'Tidak',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          // onPressed: () {
                          //   manager.deleteJoin(item.id!);
                          //   // manager.hapusPemasukan(
                          //   //     index);
                          //   // manager.hapusPengeluaran(
                          //   //     index);
                          //   Navigator.pop(context);
                          //   setState(() {
                          //     totalPemasukan =
                          //         manager.getTotalPemasukan();
                          //     totalPengeluaran =
                          //         manager.getTotalPengeluaran();
                          //     saldo = totalPemasukan - totalPengeluaran;
                          //   });
                          // },
                          onPressed: widget.onPressed,
                          child: Text(
                            'Iya',
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
              ),
            ],
          ),
          leading: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Icon(
                widget.catatan.type == 'Expense'
                    ? Icons.arrow_circle_up
                    : Icons.arrow_circle_down,
                color: widget.catatan.type == 'Expense'
                    ? Colors.red[400]
                    : Colors.greenAccent[400],
                size: 30,
              )),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.catatan.date,
                style: GoogleFonts.poppins(
                    fontSize: 10, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 5),
              Text(
                widget.catatan.description.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Text(
                formatter.format(widget.catatan.amount),
                //'Rp. ${widget.catatan.amount}',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
