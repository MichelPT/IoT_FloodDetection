import 'package:flood_detection_app/dashboard.dart';
import 'package:flood_detection_app/firebase_options.dart';
import 'package:flood_detection_app/main_status.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 101, 183, 250)),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget currentScreen = const MainStatusScreen();
  var currentPlace = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Flood Detection IoT Dashboard',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.safety_check_rounded), label: 'Safety Status'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded), label: 'History'),
        ],
        currentIndex: currentPlace,
        onTap: (value) {
          if (value == 0) {
            setState(() {
              currentScreen = const MainStatusScreen();
              currentPlace = value;
            });
          } else {
            setState(() {
              currentScreen = const DashboardScreen();
              currentPlace = value;
            });
          }
        },
      ),
    );
  }
}
