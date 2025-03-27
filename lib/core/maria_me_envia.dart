import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../features/features.dart';
import 'core.dart';

class MariaMeEnvia extends StatefulWidget {
  const MariaMeEnvia({Key? key}) : super(key: key);
  @override
  _MariaMeEnviaState createState() => _MariaMeEnviaState();
}

class _MariaMeEnviaState extends State<MariaMeEnvia> {
  @override
  void initState() {
    Modular.get<AuthController>().init();
    super.initState();
  }

  @override
  void dispose() {
    Modular.get<NavBarController>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: AppTheme.theme(context),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
    ).modular();
  }
}
