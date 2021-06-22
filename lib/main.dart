import 'package:flutter/material.dart';
import 'package:lo_rent/app_provider.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'package:lo_rent/utilities/app_themes.dart';
import 'modules/loading/loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderData(),
      child: MaterialApp(
        title: kAppName,
        home: LoadingScreen(),
        theme: AppThemes.getLightTheme(),
        darkTheme: AppThemes.getDarkTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
