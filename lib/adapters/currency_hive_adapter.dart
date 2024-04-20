import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CurrencyHiveAdapter extends TypeAdapter<CurrencyModel> {
  @override
  final int typeId = 0;

  @override
  CurrencyModel read(BinaryReader reader) {
    return CurrencyModel(
      id: reader.readString(),
      name: reader.readString(),
      price: reader.readDouble(),
      icon: reader.readString(),
      abbreviation: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeDouble(obj.price);
    writer.writeString(obj.icon);
    writer.writeString(obj.abbreviation);
  }
}
