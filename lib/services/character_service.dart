import 'dart:core';
import 'package:chinese_dict/models/character.dart';
import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';

class CharacterService{
  final Isar isar = GetIt.I<Isar>();

  Future<bool> addCharacter({required String symbol, required String pinyin, required String meaning, required bool isRadical}) async {
    final exists = await isar.characters.filter().textEqualTo(symbol).findFirst();
    if (exists != null) return false;

    final character = Character()
      ..text = symbol
      ..pinyin = pinyin
      ..meaning = meaning
      ..isRadical = isRadical;

    await isar.writeTxn(() async {
      await isar.characters.put(character);
    });
    return true;
  }

  Future<List<Character>> getCharacters() async {
    List<Character> characters = await isar.characters.where().findAll();
    return characters;
  }

  Future<List<Character>> getCharactersInWord({required String word}) async {
    final chars = word.split('');
    List<Character> characters = await isar.characters.filter().anyOf(chars, (q, symbol) => q.textEqualTo(symbol)).findAll();
    return characters;
  }
}