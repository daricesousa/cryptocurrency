import 'package:cryptocurrency/app/repositories/account_repository.dart';
import 'package:cryptocurrency/app/widgets/deposit_dialog.dart';
import 'package:cryptocurrency/configs/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountPage extends StatefulWidget {
  const CountPage({super.key});

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  @override
  Widget build(BuildContext context) {
    final numberFormat = context.watch<AppSettings>().numberFormat;
    final count = context.watch<AccountRepository>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Conta'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: const Text("Saldo", style: TextStyle(fontSize: 15)),
            subtitle: Text(numberFormat.format(count.balance),
                style: const TextStyle(fontSize: 30)),
            trailing: InkWell(
              onTap: () async {
                final res = await showDialog(
                    context: context,
                    builder: (context) => const DepositDialog());
                if (res != null) {
                  count.setBalance(res + count.balance);
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_upward, size: 40)),
            ),
          ),
        ));
  }
}
