import 'dart:core';
import 'package:chinese_dict/models/word.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class WordService{
  final Isar isar = GetIt.I<Isar>();

  Future<bool> addWord({required String word, required String pinyin, required String meaning}) async {
    final exist = await isar.words.filter().textEqualTo(word).findFirst();
    if (exist != null) return false;

    final newWord = Word()
      ..text = word
      ..pinyin = pinyin
      ..meaning = meaning;

    await isar.writeTxn(() async {
      await isar.words.put(newWord);
    });

    return true;
  }

  Future<List<Word>> getWords() async {
    List<Word> words = await isar.words.where().findAll();
    return words;
  }

  Future<List<Word>> getWordsContainingCharacter(String character) async {
    List<Word> words = await isar.words.filter().textContains(character).findAll();
    return words;
  }

}