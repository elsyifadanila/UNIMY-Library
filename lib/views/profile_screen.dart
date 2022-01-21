import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:unimy_beacon_navigation/main.dart';
import 'package:unimy_beacon_navigation/provider/root_change_notifier.dart';
import 'package:unimy_beacon_navigation/services/auth_services.dart';
import 'package:unimy_beacon_navigation/viewstate.dart';
import 'package:unimy_beacon_navigation/widget/login_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('Profile Screen ')),
            buildLogoutBtn()
          ],
        ),
      ),
    );
  }

  Widget buildLogoutBtn() {
    final changeNotifier = context.watch<RootChangeNotifier>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 48),
      width: double.infinity,
      child: LoginButtonWidget(
        onPressed: () {
          context.read<AuthService>().signOut(changeNotifier).whenComplete(() =>
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AuthWrapper())));
        },
        child: changeNotifier.getViewState == ViewState.BUSY
            ? const CircularProgressIndicator()
            : const Text(
                'LOG OUT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
