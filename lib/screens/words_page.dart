import 'dart:core';
import 'package:chinese_dict/models/word.dart';
import 'package:chinese_dict/services/word_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chinese_dict/services/character_service.dart';
import 'package:flutter/material.dart';
import 'package:chinese_dict/custom_widgets/word_card.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  final CharacterService _characterService = CharacterService();
  final WordService _wordService = WordService();

  void _showLinkedModal(BuildContext context, String symbol) async {
    final chars = await _characterService.getCharactersInWord(word: symbol);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400.h,
            color: Colors.white,
            child: ListView.builder(
              itemCount: chars.length,
              itemBuilder: (context, index) {
                var char = chars[index];
                return WordCard(
                  mainText: char.text,
                  pinyin: char.pinyin!,
                  meaning: char.meaning!,
                  isChar: true,
                  isRadical: char.isRadical,
                  onWordTap: null,
                  onLongWordTap: _showBigModal);
              }),
          );
        });
  }

  void _showBigModal(BuildContext context, String symbol) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SimpleDialog(
              titlePadding: const EdgeInsets.all(0),
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
        child: FutureBuilder<List<Word>>(
          future: _wordService.getWords(),
          builder: (context, snapshot) {
            final words = snapshot.data ?? [];
            return ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                final word = words[index];
                return WordCard(
                    mainText: word.text,
                    pinyin: word.pinyin!,
                    meaning: word.meaning!,
                    isChar: false,
                    onWordTap: _showLinkedModal);
              });
          },
        ),
      ),
    );
  }
}
