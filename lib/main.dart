import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:basic_english/blocs/auth/login/login_bloc.dart';
import 'package:basic_english/blocs/auth/register/register_bloc.dart';
import 'package:basic_english/blocs/profile/profile_bloc.dart';
import 'package:basic_english/blocs/theme/theme_bloc.dart';
import 'package:basic_english/blocs/theme/theme_event.dart';
import 'package:basic_english/blocs/theme/theme_state.dart';
import 'package:basic_english/services/user_service.dart';
import 'package:basic_english/constants/supported_locales.dart';
import 'package:basic_english/generated/codegen_loader.g.dart';
import 'package:basic_english/helpers/ui_helper.dart';
import 'package:basic_english/services/theme_service.dart';
import 'package:basic_english/views/splash/splash_view.dart';

void main() async {
  await dotenv.load();
  await ThemeService.getTheme();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc(userService: UserService())),
        BlocProvider(
            create: (context) => RegisterBloc(userService: UserService())),
        BlocProvider(
            create: (context) => ProfileBloc(userService: UserService())),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: EasyLocalization(
        supportedLocales: SuppertedLocales.supportedLocales,
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late ThemeBloc _themeBloc;

  @override
  void initState() {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    var isDarkMode = ThemeService.isDark;
    if (ThemeService.useDeviceTheme) {
      isDarkMode = brightness == Brightness.dark;
    }
    _themeBloc.add(ChangeTheme(
      isDark: isDarkMode,
      useDeviceTheme: ThemeService.useDeviceTheme,
    ));

    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var brightness = MediaQuery.of(context).platformBrightness;
    await ThemeService.getTheme();

    bool isDarkMode = ThemeService.isDark;
    if (ThemeService.useDeviceTheme) {
      isDarkMode = brightness == Brightness.dark;
    }
    _themeBloc.add(ChangeTheme(
        useDeviceTheme: ThemeService.useDeviceTheme, isDark: isDarkMode));
  }

  @override
  Widget build(BuildContext context) {
    UIHelper.initialize(context);
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return CupertinoApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Template App',
        theme: ThemeService.buildTheme(themeState),
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      );
    });
  }
}
