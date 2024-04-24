import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:cryptocurrency/app/repositories/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrencyDetailPage extends StatefulWidget {
  final CurrencyModel currency;
  const CurrencyDetailPage({super.key, required this.currency});

  @override
  State<CurrencyDetailPage> createState() => _CurrencyDetailPageState();
}

class _CurrencyDetailPageState extends State<CurrencyDetailPage> {
  final real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final form = GlobalKey<FormState>();
  final value = TextEditingController();
  late AccountRepository accountRepository;
  double? quantity;

  void buy() {
    if (form.currentState!.validate()) {
      accountRepository
          .buyCurrency(
            currency: widget.currency,
            value: double.parse(value.text),
          )
          .then((_) => {
                Navigator.pop(context),
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Compra realizada com sucesso"),
                    backgroundColor: Colors.green,
                  ),
                ),
              });
    }
  }

  void calculateQuantity() {
    setState(() {
      if (value.text.isEmpty || double.tryParse(value.text) == null) {
        quantity = null;
      }
      quantity = double.tryParse(value.text)! / widget.currency.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    accountRepository = Provider.of<AccountRepository>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.currency.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 40, child: Image.asset(widget.currency.icon)),
                  const SizedBox(width: 20),
                  Text(
                    widget.currency.name,
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
              const SizedBox(height: 20),
              if (quantity != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Quantidade $quantity"),
                ),
              Form(
                key: form,
                child: TextFormField(
                  onChanged: (value) => calculateQuantity(),
                  controller: value,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "Valor",
                    prefix: Text("R\$ "),
                    border: OutlineInputBorder(),
                    suffix: Icon(Icons.monetization_on_outlined),
                  ),
                  style: const TextStyle(fontSize: 22),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe um valor";
                    }
                    if (double.parse(value) > accountRepository.balance) {
                      return "Saldo insuficiente";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(top: 20),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: buy,
                        child: const Text("Comprar"),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
