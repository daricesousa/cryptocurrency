import 'package:cryptocurrency/app/models/position_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WalletGraphic extends StatefulWidget {
  final List<PositionModel> wallet;
  final double balance;
  const WalletGraphic({
    Key? key,
    required this.wallet,
    required this.balance,
  }) : super(key: key);

  @override
  State<WalletGraphic> createState() => _WalletGraphicState();
}

class _WalletGraphicState extends State<WalletGraphic> {
  int? index;
  late final int indexBalance;
  String graphicLabel = '';
  double? graphicValue;

  @override
  initState() {
    super.initState();
    indexBalance = widget.wallet.length;
  }

  List<PieChartSectionData> loadWallet() {
    final List<PieChartSectionData> slices =
        List.generate(widget.wallet.length, (index) {
      final isSelected = index == this.index;
      final position = widget.wallet[index];
      return PieChartSectionData(
        color: isSelected ? Colors.blue : Colors.blue[200],
        value: position.quantity * position.currency.price,
        title: position.currency.name,
        radius: isSelected ? 100 : 80,
        titleStyle: const TextStyle(color: Colors.white),
      );
    });

    slices.add(PieChartSectionData(
      color: index == indexBalance ? Colors.blue : Colors.blue[200],
      value: widget.balance,
      title: "Saldo",
      radius: index == indexBalance ? 100 : 80,
      titleStyle: const TextStyle(color: Colors.white),
    ));
    return slices;
  }

  showSliceData(int? index) {
    if (index == null || index < 0) {
      graphicLabel = '';
      graphicValue = null;
    } else if (index == indexBalance) {
      graphicLabel = 'Saldo';
      graphicValue = widget.balance;
    } else {
      graphicLabel = widget.wallet[index].currency.name;
      graphicValue =
          widget.wallet[index].quantity * widget.wallet[index].currency.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                sectionsSpace: 5,
                centerSpaceRadius: 100,
                sections: loadWallet(),
                pieTouchData: PieTouchData(touchCallback: (_, touch) {
                  setState(() {
                    index = touch?.touchedSection?.touchedSectionIndex;
                    showSliceData(index);
                  });
                }),
              ),
            )),
        Column(
          children: [
            Text(graphicLabel),
            Text(graphicValue?.toStringAsFixed(0) ?? ''),
          ],
        )
      ],
    );
  }
}
