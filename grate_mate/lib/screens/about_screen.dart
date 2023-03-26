import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO make custom License Page with LicenseRegistry
      return LicensePage(
          applicationName: 'GrateMate',
          applicationIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/logo_new.png', width: 100),
          ),
          applicationVersion: '0.0.0',
          applicationLegalese: 'Copyright GrateMate',
        );

  }
}
