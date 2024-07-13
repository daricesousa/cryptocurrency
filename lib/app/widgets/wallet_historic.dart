// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cryptocurrency/app/models/historic_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletHistoric extends StatefulWidget {
  final List<HistoricModel> historic;
  final NumberFormat numberFormat;
  const WalletHistoric({
    Key? key,
    required this.historic,
    required this.numberFormat,
  }) : super(key: key);

  @override
  State<WalletHistoric> createState() => _WalletHistoricState();
}

class _WalletHistoricState extends State<WalletHistoric> {
  @override
  Widget build(BuildContext context) {
    final historic = widget.historic;
    historic.sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
        shrinkWrap: true,
        itemCount: historic.length,
        itemBuilder: (context, index) {
          final transaction = historic[index];
          return ListTile(
            title: Text(transaction.currency.name),
            subtitle: Text(transaction.date.toString()),
            trailing: Text(widget.numberFormat.format(transaction.value)),
          );
        });
  }
}
