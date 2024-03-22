import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:translation_app/providers/change_password_provider.dart';
import 'package:translation_app/providers/home_page_provider.dart';
import 'package:translation_app/providers/login_logout_provider.dart';
import 'package:translation_app/screens/home_page.dart';
import 'package:translation_app/screens/login_page.dart';
import 'package:translation_app/screens/registre_page.dart';
import 'package:translation_app/screens/second_register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthMethodProvider()),
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        // ChangeNotifierProvider(create: (context) => TranslationProvider()),
        ChangeNotifierProvider(create: (context) => ChangPasswordProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Provider.of<AuthMethodProvider>(context , listen: false ).checkLoginStorage();
  }
//hello
  @override
  Widget build(BuildContext context) {
    final authMethodProvider = Provider.of<AuthMethodProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAS',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.grey),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (authMethodProvider.str == true)? HomePage(): RegistrePage(),
    );
  }
}
