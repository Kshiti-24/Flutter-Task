import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:speechtotext/Screens/home_screen.dart';
import 'package:speechtotext/Screens/recording_list_screen.dart';
import 'package:speechtotext/firebase_options.dart';

late Size size;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/recordings': (context) => RecordingsListScreen(),
      },
    );
  }
}
