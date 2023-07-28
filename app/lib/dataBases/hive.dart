import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ListData {
  @HiveField(0)
  List<int> integers;

  ListData(this.integers);
}

class ListDataAdapter extends TypeAdapter<ListData> {
  @override
  final int typeId = 0;

  @override
  ListData read(BinaryReader reader) {
    final numIntegers = reader.readByte();
    List<int> integers = [];
    for (int i = 0; i < numIntegers; i++) {
      integers.add(reader.readInt());
    }
    return ListData(integers);
  }

  @override
  void write(BinaryWriter writer, ListData obj) {
    writer.writeByte(obj.integers.length);
    for (var integer in obj.integers) {
      writer.writeInt(integer);
    }
  }
}