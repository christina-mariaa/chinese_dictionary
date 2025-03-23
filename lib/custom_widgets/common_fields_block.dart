import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonFieldsBlock extends StatelessWidget {
  final TextEditingController mainTextController;
  final TextEditingController pinyinController;
  final TextEditingController meaningController;
  final String label;

  const CommonFieldsBlock({
    super.key,
    required this.mainTextController,
    required this.pinyinController,
    required this.meaningController,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h,),
        _textFormField(label: label, hint: 'Введите ${label.toLowerCase()}', controller: mainTextController),
        SizedBox(height: 20.h,),
        _textFormField(label: 'Пиньинь', hint: 'Введите пиньинь', controller: pinyinController),
        SizedBox(height: 20.h,),
        _textFormField(label: 'Перевод', hint: 'Введите перевод', controller: meaningController),
        SizedBox(height: 20.h,),
      ],
    );
  }

  Widget _textFormField({required String label, required String hint, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.indigoAccent,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.indigoAccent, width: 1.0),),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
