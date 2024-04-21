import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:cryptocurrency/app/repositories/currency_repository.dart';
import 'package:cryptocurrency/app/repositories/favorites_repository.dart';
import 'package:cryptocurrency/app/widgets/currency_card.dart';
import 'package:cryptocurrency/configs/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  late FavoritesRepository favoritesRepository;
  final table = CurrencyRepository.table;
  final List<CurrencyModel> selected = [];
  late AppSettings settings;
  late NumberFormat numberFormat;

  void clearSelected() {
    setState(() {
      selected.clear();
    });
  }

  Widget changeLocaleButton() {
    final locale = settings.locale == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = settings.nameLocale == 'R\$' ? '\$' : 'R\$';
    return PopupMenuButton(
        icon: const Icon(Icons.language),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                    title: Text("Usar em $name"),
                    onTap: () {
                      settings.setLocale(locale: locale, name: name);
                      Navigator.pop(context);
                    }),
              ),
            ]);
  }

  @override
  Widget build(BuildContext context) {
    settings = Provider.of<AppSettings>(context);
    favoritesRepository = context.watch<FavoritesRepository>();
    numberFormat = settings.numberFormat;
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
                numberFormat: numberFormat,
                currency: currency,
                isFavorite: favoritesRepository.isCurrencyFavorite(currency),
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

  AppBar appBarDynamic() {
    if (selected.isEmpty) {
      return AppBar(
        title: const Text("Criptomoedas"),
        centerTitle: true,
        actions: [changeLocaleButton()],
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
}
