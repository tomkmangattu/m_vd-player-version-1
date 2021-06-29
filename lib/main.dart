import 'package:flutter/material.dart';
import 'package:m_vd/file_manager/app_home/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nunito',
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPage.id,
      routes: {
        AppPage.id: (_) => AppPage(),
      },
    );
  }
}
