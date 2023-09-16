import 'package:cab_rider/screens/loginpage.dart';
import 'package:cab_rider/screens/main_page.dart';
import 'package:cab_rider/screens/registrationpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Brand-Regular",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialRoute: RegistrationPage.id,
      initialRoute: MainPage.id,
      routes: {
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => const MainPage(),
      },
    );
  }
}
