import 'package:cryptocurrency/app/repositories/favorites_repository.dart';
import 'package:cryptocurrency/app/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteCurrencyPage extends StatelessWidget {
  const FavoriteCurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorito'),
      ),
      body: Container(child: Consumer<FavoritesRepository>(
          builder: (context, favoritesRepository, child) {
        if (favoritesRepository.list.isEmpty) {
          return const ListTile(
            leading: Icon(Icons.star),
            title: Text("Não há moedas favoritas"),
          );
        }
        return ListView.builder(
          itemCount: favoritesRepository.list.length,
          itemBuilder: (_, index) {
            final currency = favoritesRepository.list[index];
            return CurrencyCard(
              currency: currency,
              isFavorite: true,
              onLongPress: () => favoritesRepository.remove(currency),
            );
          },
        );
      })),
    );
  }
}
