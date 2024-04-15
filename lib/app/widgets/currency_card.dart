import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:cryptocurrency/app/pages/currency_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyCard extends StatefulWidget {
  final bool isSelected;
  final CurrencyModel currency;
  final NumberFormat numberFormat;
  final void Function()? onLongPress;

  final bool isFavorite;
  const CurrencyCard({
    super.key,
    this.isSelected = false,
    required this.currency,
    this.isFavorite = false,
    this.onLongPress,
    required this.numberFormat,
  });

  @override
  State<CurrencyCard> createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  void showCurrencyDetail(CurrencyModel currency) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CurrencyDetailPage(currency: currency);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      selected: widget.isSelected,
      selectedTileColor: Colors.indigo[50],
      leading: widget.isSelected
          ? const CircleAvatar(child: Icon(Icons.check))
          : SizedBox(width: 40, child: Image.asset(widget.currency.icon)),
      title: Row(
        children: [
          Text(widget.currency.name,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          if (widget.isFavorite)
            const Icon(Icons.star, color: Colors.amber, size: 16),
        ],
      ),
      trailing: Text(widget.numberFormat.format(widget.currency.price)),
      onLongPress: () => widget.onLongPress?.call(),
      onTap: () => showCurrencyDetail(widget.currency),
    );
  }
}
