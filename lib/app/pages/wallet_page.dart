import 'package:cryptocurrency/app/repositories/account_repository.dart';
import 'package:cryptocurrency/app/widgets/wallet_graphic.dart';
import 'package:cryptocurrency/configs/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double totalWallet = 0;
  double balance = 0;
  late NumberFormat numberFormat;
  late AccountRepository accountRepository;

  void setTotalWallet() {
    final walletList = accountRepository.wallet;
    totalWallet = walletList.fold(
        balance,
        (total, position) =>
            total + (position.quantity * position.currency.price));
  }

  @override
  Widget build(BuildContext context) {
    numberFormat = context.watch<AppSettings>().numberFormat;
    accountRepository = context.watch<AccountRepository>();
    balance = accountRepository.balance;
    setTotalWallet();
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 88, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Valor da carteira",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              numberFormat.format(totalWallet),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            loadGraphic()
          ],
        ),
      ),
    ));
  }

  loadGraphic() {
    return WalletGraphic(
      wallet: accountRepository.wallet,
      balance: balance,
    );
  }
}
