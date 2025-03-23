import 'package:chinese_dict/models/character.dart';
import 'package:chinese_dict/models/word.dart';
import 'package:chinese_dict/screens/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';

late Isar isar;
final locator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([CharacterSchema, WordSchema], directory: dir.path);

  locator.registerSingleton<Isar>(isar);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Иероглифы',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const NavigationPage(),
        );
      }
    );
  }
}

