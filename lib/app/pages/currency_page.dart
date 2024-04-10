import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:cryptocurrency/app/pages/currency_detail_page.dart';
import 'package:cryptocurrency/app/repositories/currency_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final table = CurrencyRepository.table;
  final real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final List<CurrencyModel> selected = [];

  void showCurrencyDetail(CurrencyModel currency) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CurrencyDetailPage(currency: currency);
    }));
  }

  AppBar appBarDynamic() {
    if (selected.isEmpty) {
      return AppBar(
        title: const Text("Criptomoedas"),
        centerTitle: true,
      );
    } else {
      return AppBar(
          title: Text(
            "${selected.length} selecionadas",
          ),
          backgroundColor: Colors.blueGrey[50],
          elevation: 1,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  selected.clear();
                });
              },
            )
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDynamic(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: selected.isEmpty
        //     ? FloatingActionButton.extended(
        //         onPressed: () {},
        //         label: const Text("Favoritar"),
        //         icon: const Icon(Icons.star),
        //       )
        //     : null,
        body: ListView.separated(
            itemBuilder: (context, current) {
              final currency = table[current];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                selected: selected.contains(currency),
                selectedTileColor: Colors.indigo[50],
                leading: selected.contains(currency)
                    ? const CircleAvatar(child: Icon(Icons.check))
                    : SizedBox(width: 40, child: Image.asset(currency.icon)),
                title: Text(currency.name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                trailing: Text(real.format(currency.price)),
                onLongPress: () {
                  setState(() {
                    if (selected.contains(currency)) {
                      selected.remove(currency);
                    } else {
                      selected.add(currency);
                    }
                  });
                },
                onTap: () => showCurrencyDetail(currency),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: table.length));
  }
}
