import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unimy_beacon_navigation/services/auth_services.dart';
import 'package:unimy_beacon_navigation/services/database_services.dart';
import 'package:unimy_beacon_navigation/views/auth/login_screen.dart';
import 'package:unimy_beacon_navigation/views/home/home_screens.dart';
import 'package:unimy_beacon_navigation/views/home/navigation_new.dart';
import 'package:unimy_beacon_navigation/requirement_state_controller.dart';
import 'package:unimy_beacon_navigation/provider/root_change_notifier.dart';
import 'package:unimy_beacon_navigation/views/profile_screen.dart';
import 'package:unimy_beacon_navigation/views/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(RequirementStateController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RootChangeNotifier()),
        Provider(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
            initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: GoogleFonts.workSans().fontFamily,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.grey,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _difference = 0;
  int _bottomSelectedIndex = 0;
  final pageController = PageController(initialPage: 0, keepPage: true);
  void pageChanged(int index) {
    setState(() {
      _bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    print('Current index : $_bottomSelectedIndex');
    print('Previous index : $index');
    _difference = (index - _bottomSelectedIndex).abs();
    print('Difference : $_difference');
    setState(() {
      _bottomSelectedIndex = index;
      if (_difference == 1) {
        print('Animate sikit');
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 600), curve: Curves.easeOut);
      } else {
        print('JUMP TERUS');
        pageController.jumpToPage(
          index,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          onPageChanged: (index) {
            pageChanged(index);
            //_selectBottomBar(pageKeys[index], index);
          },
          scrollDirection: Axis.horizontal,
          controller: pageController,
          children: const [HomeScreen(), ProfileScreen(), SettingScreen()]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int val) {
          bottomTapped(val);
        },
        // backgroundColor: Colors.grey[300],
        currentIndex: _bottomSelectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    print('This is firebase user : $firebaseUser');
    if (firebaseUser != null) {
      DatabaseService(uid: firebaseUser.uid).readUserName;
      return const MyHomePage();
    }
    return const LoginScreen();
  }
}
