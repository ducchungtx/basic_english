import 'package:basic_english/constants/supported_locales.dart';
import 'package:basic_english/services/theme_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  await ThemeService.getTheme();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiBlocProvider(
      providers: [],
      child: EasyLocalization(
        supportedLocales: SuppertedLocales.supportedLocales,
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        // assetLoader: const CodegenLoader(),
        child: const MainApp(),
      )));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
