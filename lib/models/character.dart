import 'package:isar/isar.dart';

part 'character.g.dart';

@collection
class Character {
  Id id = Isar.autoIncrement;
  late String text;
  String? pinyin;
  String? meaning;

  bool isRadical = false;
}
