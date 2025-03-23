import 'package:chinese_dict/screens/characters_page.dart';
import 'package:chinese_dict/screens/add_character_screen.dart';
import 'package:chinese_dict/screens/add_word_screen.dart';
import 'package:chinese_dict/screens/words_page.dart';
import 'package:flutter/material.dart';
import 'package:chinese_dict/custom_widgets/header_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int ind = 0;

  final List<Widget> _screensList = [
    const WordsPage(),
    const CharactersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HeaderText(text: 'Китайский за год ееееее'),
        backgroundColor: Colors.indigoAccent[100],
        actions: [
          PopupMenuButton(
            color: Colors.white,
            icon: const Icon(Icons.add),
            iconSize: 30,
            iconColor: Colors.white,
            onSelected: (isChar) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    if (isChar) {return const AddCharacterScreen();}
                    else {return const AddWordScreen();}
                  })
                );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: true,
                child: Text('Добавить иероглиф'),
              ),
              const PopupMenuItem(
                  value: false,
                  child: Text('Добавить слово')),
            ],
          ),

        ],
      ),
      body: _screensList[ind],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 13.sp,
        unselectedFontSize: 12.sp,
        backgroundColor: Colors.white,
        currentIndex: ind,
        onTap: (index) => setState(() {ind = index;}),
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/word.png', height: 25.h,), label: 'Слова'),
          BottomNavigationBarItem(icon: Image.asset('assets/symbol.png', height: 25.h,), label: 'Иероглифы'),
        ],
      ),
    );
  }
}
