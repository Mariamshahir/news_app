import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/homescreen.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:news_app/splash.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LanguageProvider languageProvider = LanguageProvider();
  await languageProvider.setItems();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => languageProvider),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider provider = Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en"), Locale("ar")],
      locale: Locale(provider.currentLocale),
      routes: {
        Splash.routeName: (_) => Splash(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      initialRoute: Splash.routeName,
    );
  }
}
