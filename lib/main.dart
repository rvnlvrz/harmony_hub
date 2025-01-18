import 'package:animations/animations.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/attendance.dart';
import 'package:harmony_hub/dashboard.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harmony Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF5946D2)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Harmony Hub'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  Credentials? _credentials;
  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 =
        Auth0('dev-gsbc-org.us.auth0.com', 'H0oLVM5XrHC08ljf2sBkvvtPF9djvs80');
  }

  void changeSelectedTab(int value) {
    setState(() {
      _selectedIndex = value;

      if (kDebugMode) {
        print('Selected index: $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_sharp), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline), label: 'Attendance')
          ],
          onTap: changeSelectedTab,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed),
      appBar: AppBar(
        backgroundColor: context.colors.scheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: _selectedIndex == 0
            ? Dashboard(key: ValueKey(0), credentials: _credentials)
            : Attendance(key: ValueKey(1)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startSession,
        tooltip: 'Start Session',
        child: const Icon(Icons.timer_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> handleAuthAction() async {
    if (_credentials == null) {
      return loginAsync();
    } else {
      return logoutAsync();
    }
  }

  Future<void> logoutAsync() async {
    // Use a Universal Link logout URL on iOS 17.4+ / macOS 14.4+
    // useHTTPS is ignored on Android
    await auth0.webAuthentication(scheme: 'harmonyhub').logout(useHTTPS: true);
    setState(() {
      _credentials = null;
    });
  }

  Future<void> loginAsync() async {
    // Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
    // useHTTPS is ignored on Android
    final credentials = await auth0
        .webAuthentication(scheme: 'harmonyhub')
        .login(useHTTPS: true);

    setState(() {
      _credentials = credentials;
    });
  }

  void _startSession() {}
}
