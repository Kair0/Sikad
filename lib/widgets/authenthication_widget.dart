import 'package:Sikad/pages/home_page.dart';
import 'package:Sikad/pages/login_page.dart';
import 'package:Sikad/pages/nav_bar_page.dart';
import 'package:Sikad/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authService =
        Provider.of<FireBaseAuthService>(context, listen: false);
    return StreamBuilder<AppUser>(
        stream: _authService.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final _user = snapshot.data;
            if (_user != null) {
              return Provider<AppUser>.value(
                value: _user,
                child: NavBar(),
              );
            }
            print(_user);
            return LoginPage();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
