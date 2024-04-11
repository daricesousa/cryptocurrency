import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:cryptocurrency/app/repositories/currency_repository.dart';
import 'package:cryptocurrency/app/repositories/favorites_repository.dart';
import 'package:cryptocurrency/app/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final table = CurrencyRepository.table;

  final List<CurrencyModel> selected = [];
  late FavoritesRepository favoritesRepository;

  void clearSelected() {
    setState(() {
      selected.clear();
    });
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
    // favoritesRepository = Provider.of<FavoritesRepository>(context);
    favoritesRepository = context.watch<FavoritesRepository>();
    return Scaffold(
        appBar: appBarDynamic(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selected.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () {
                  favoritesRepository.saveAll(selected);
                  clearSelected();
                },
                label: const Text("Favoritar"),
                icon: const Icon(Icons.star),
              )
            : null,
        body: ListView.separated(
            itemBuilder: (context, current) {
              final currency = table[current];
              return CurrencyCard(
                currency: currency,
                isFavorite: favoritesRepository.list.contains(currency),
                isSelected: selected.contains(currency),
                onLongPress: () {
                  setState(() {
                    if (selected.contains(currency)) {
                      selected.remove(currency);
                    } else {
                      selected.add(currency);
                    }
                  });
                },
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: table.length));
  }
}
