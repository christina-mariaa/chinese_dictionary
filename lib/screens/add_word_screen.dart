import 'dart:core';
import 'package:chinese_dict/custom_widgets/common_fields_block.dart';
import 'package:chinese_dict/custom_widgets/header_text.dart';
import 'package:chinese_dict/services/word_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({super.key,});

  @override
  State<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController mainTextController = TextEditingController();
  final TextEditingController pinyinController = TextEditingController();
  final TextEditingController meaningController = TextEditingController();
  final WordService _wordService = WordService();

  void _handleSubmit() async {
    final String mainText = mainTextController.text.trim();
    final String pinyin = pinyinController.text.trim();
    final String meaning = meaningController.text.trim();
    late final bool success;
    if (mainText.isEmpty || pinyin.isEmpty || meaning.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не все поля заполнены'))
      );
      return;
    }
    success = await _wordService.addWord(word: mainText, pinyin: pinyin, meaning: meaning);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Слово $mainText добавлено'))
      );
      mainTextController.clear();
      pinyinController.clear();
      meaningController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Слово $mainText уже есть в базе'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const HeaderText(text: 'Добавление слова'),
        backgroundColor: Colors.indigoAccent[100],
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(15.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CommonFieldsBlock(mainTextController: mainTextController, pinyinController: pinyinController, meaningController: meaningController, label: "Слово"),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent[100],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h)
                  ),
                  onPressed: _handleSubmit,
                  child: Text('Добавить', style: TextStyle(fontSize: 15.sp),))
            ],
          ),
        ),
      ),
    );
  }
}
