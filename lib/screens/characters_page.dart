import 'dart:core';
import 'package:chinese_dict/services/word_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chinese_dict/models/character.dart';
import 'package:chinese_dict/services/character_service.dart';
import 'package:flutter/material.dart';
import 'package:chinese_dict/custom_widgets/word_card.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final CharacterService _characterService = CharacterService();
  final WordService _wordService = WordService();

  void _showLinkedModal(BuildContext context, String symbol) async {
    final words = await _wordService.getWordsContainingCharacter(symbol);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400.h,
            color: Colors.white,
            child: ListView.builder(
                itemCount: words.length,
                itemBuilder: (context, index) {
                  var word = words[index];
                  return WordCard(
                    mainText: word.text,
                    pinyin: word.pinyin!,
                    meaning: word.meaning!,
                    isChar: false,
                    onWordTap: null,
                    onLongWordTap: null);
                }),
          );
        }
      );
  }

  void _showBigModal(BuildContext context, String symbol) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SimpleDialog(
              titlePadding: EdgeInsets.all(0),
              alignment: Alignment.center,
              backgroundColor: Colors.white,
              title: Center(child: Text(symbol)),
              titleTextStyle: TextStyle(fontSize: 150.sp, color: Colors.black),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<Character>>(
          future: _characterService.getCharacters(),
          builder: (context, snapshot) {
            final characters = snapshot.data ?? [];
            return ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final char = characters[index];
                  return WordCard(
                      mainText: char.text,
                      pinyin: char.pinyin!,
                      meaning: char.meaning!,
                      isChar: true,
                      isRadical: char.isRadical,
                      onWordTap: _showLinkedModal,
                      onLongWordTap: _showBigModal);
                });
          },
        ),
      ),
    );
  }
}
