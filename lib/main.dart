import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweeter_clone_flutter/features/auth/view/login_view.dart';
import 'package:tweeter_clone_flutter/features/auth/view/signup_view.dart';
import 'package:tweeter_clone_flutter/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

 
 @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return MaterialApp(
      title: 'Twitter Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      
       home: const Scaffold(
        body: SignupView(),
      ),
    );
  }
}
