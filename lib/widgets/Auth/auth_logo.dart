import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white.withValues(alpha: 0.8),
      child: Image.asset("assets/images/str_app_logo.png", height: 60),
    );
  }
}
