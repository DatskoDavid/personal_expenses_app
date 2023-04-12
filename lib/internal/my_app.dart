import 'package:flutter/material.dart';
import 'package:transactions_track_app/presentation/utils/theme.dart';

import '../presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: MyTheme.customTheme,
      home: MyHomePage(titleText: 'Personal Expenses'),
      //home: TestingSizer(),
    );
  }
}
