import 'package:isar/isar.dart';

part 'word.g.dart';

@collection
class Word {
  Id id = Isar.autoIncrement;
  late String text;
  String? pinyin;
  String? meaning;
}