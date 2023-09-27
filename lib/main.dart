import 'package:flutter/material.dart';
import 'package:flutter_tweeter_clone/features/view/login_view.dart';
import 'package:flutter_tweeter_clone/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      
       home: const Scaffold(
        body: LogginView(),
      ),
    );
  }
}
