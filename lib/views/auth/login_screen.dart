import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:unimy_beacon_navigation/provider/root_change_notifier.dart';
import 'package:unimy_beacon_navigation/services/auth_services.dart';
import 'package:unimy_beacon_navigation/views/auth/register_screen.dart';
import 'package:unimy_beacon_navigation/viewstate.dart';
import 'package:unimy_beacon_navigation/widget/custom_text_form_field_widget.dart';
import 'package:unimy_beacon_navigation/widget/login_button_widget.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 72, fontWeight: FontWeight.w700),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: Text(

                    'Please sign up using your UNIMY credentials to continue',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                CustomTextFormField(
                  controller: emailController,
                  label: 'Email',
                  icon: const Icon(Icons.person),
                  obscureText: false,
                ),
                CustomTextFormField(
                    controller: pwController,
                    label: 'Password',
                    icon: const Icon(Icons.lock),
                    obscureText: true),
                buildLoginBtn(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Dont have account? '),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    final changeNotifier = context.watch<RootChangeNotifier>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: LoginButtonWidget(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context
                .read<AuthService>()
                .signIn(
                    email: emailController.text,
                    password: pwController.text,
                    changeNotifier: changeNotifier)
                .catchError((e) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('ERROR'),
                      content: Text(e.toString()),
                      actions: [
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Okay'))
                      ],
                    );
                  }).whenComplete(() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const AuthWrapper();
                  })));
            });
          }
        },
        child: changeNotifier.getViewState == ViewState.BUSY
            ? const CircularProgressIndicator()
            : const Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
