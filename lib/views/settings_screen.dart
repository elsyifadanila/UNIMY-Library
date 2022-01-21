import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unimy_beacon_navigation/constant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _switchValueNotification = false;
  bool _switchValueApp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
            ),
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'ACCOUNT',
                            style: subtitleStyle,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const FaIcon(FontAwesomeIcons.chevronRight)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Change Password',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const FaIcon(FontAwesomeIcons.chevronRight)
                          ],
                        )
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'NOTIFICATION',
                            style: subtitleStyle,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notification',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            CupertinoSwitch(
                              activeColor: Colors.grey,
                              value: _switchValueNotification,
                              onChanged: (value) {
                                setState(() {
                                  _switchValueNotification = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'App Notification',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            CupertinoSwitch(
                              activeColor: Colors.grey,
                              value: _switchValueApp,
                              onChanged: (value) {
                                setState(() {
                                  _switchValueApp = value;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'MORE',
                            style: subtitleStyle,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Language',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const FaIcon(FontAwesomeIcons.chevronRight)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Terms and condition',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const FaIcon(FontAwesomeIcons.chevronRight)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'FAQs',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const FaIcon(FontAwesomeIcons.chevronRight)
                          ],
                        )
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
