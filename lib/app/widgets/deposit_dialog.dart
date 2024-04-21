import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepositDialog extends StatefulWidget {
  const DepositDialog({super.key});

  @override
  State<DepositDialog> createState() => _DepositDialogState();
}

class _DepositDialogState extends State<DepositDialog> {
  final depositController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text('Depósito'),
        content: TextFormField(
          controller: depositController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,2}'),
            )
          ],
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty || double.parse(value) == 0) {
              return 'Informe o valor do depósito';
            }
            return null;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, double.parse(depositController.text));
              }
            },
            child: const Text('Depositar'),
          ),
        ],
      ),
    );
  }
}
