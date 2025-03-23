import 'dart:core';
import 'package:chinese_dict/custom_widgets/common_fields_block.dart';
import 'package:chinese_dict/custom_widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chinese_dict/services/character_service.dart';

class AddCharacterScreen extends StatefulWidget {

  const AddCharacterScreen({super.key,});

  @override
  State<AddCharacterScreen> createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends State<AddCharacterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController mainTextController = TextEditingController();
  final TextEditingController pinyinController = TextEditingController();
  final TextEditingController meaningController = TextEditingController();
  final CharacterService _characterService = CharacterService();

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
    success = await _characterService.addCharacter(symbol: mainText, pinyin: pinyin, meaning: meaning);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Иероглиф $mainText добавлен'))
      );
      mainTextController.clear();
      pinyinController.clear();
      meaningController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Иероглиф $mainText уже есть в базе'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const HeaderText(text: 'Добавление иероглифа'),
        backgroundColor: Colors.indigoAccent[100],
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(15.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CommonFieldsBlock(mainTextController: mainTextController, pinyinController: pinyinController, meaningController: meaningController, label: "Иероглиф"),
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
