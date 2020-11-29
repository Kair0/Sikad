import 'package:Sikad/pages/home_page.dart';
import 'package:Sikad/pages/signup_page.dart';
import 'package:Sikad/pages/signin_page.dart';
import 'package:Sikad/services/authentication.dart';
import 'package:Sikad/widgets/authenthication_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Sikad/colours.dart';

//final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class LoginPage extends StatelessWidget {
  Future<void> _signIn(BuildContext context) async {
    print('function is called');
    try {
      final auth = Provider.of<FireBaseAuthService>(context, listen: false);
      final user = await auth.signInWithGoogle();
      print('uid: ${user.uid}');
      AuthenticationWidget();
    } catch (e) {
      print(e);
    }
  }

  // void loading() {
  //   _scaffoldKey.currentState.showSnackBar(new SnackBar(
  //     duration: new Duration(seconds: 4),
  //     content: new Row(
  //       children: <Widget>[
  //         new CircularProgressIndicator(),
  //         new Text("  Signing-In...")
  //       ],
  //     ),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      //key: _scaffoldKey,
      backgroundColor: Color(OGBG),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'images/logo.png',
          width: 331,
          height: 200,
          fit: BoxFit.cover,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Welcome, bayani',
            style: TextStyle(
                color: Color(OGBlue),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'PublicSans',
                package: 'Sikad'),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(53),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: ButtonTheme(
                  minWidth: 186,
                  height: 36,
                  child: RaisedButton(
                    color: Color(OGBlue),
                    onPressed: () {
                      // loading();
                      _signIn(context);
                    },
                    child: Text(
                      'Sign In with Google',
                      style: TextStyle(color: Color(OGShadow2)),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(11.0)),
                  ),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(.6),
                      spreadRadius: -5,
                      blurRadius: 16,
                      offset: Offset(-6, -6),
                    ),
                    BoxShadow(
                      color: Color(OGShadow3),
                      spreadRadius: -5,
                      blurRadius: 16,
                      offset: Offset(6, 6),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: ButtonTheme(
                  minWidth: 186,
                  height: 36,
                  child: RaisedButton(
                    color: Color(OGShadow2),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignInPage())),
                    child: Text(
                      'Sign in',
                      style: TextStyle(),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(11.0)),
                  ),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(.6),
                      spreadRadius: -5,
                      blurRadius: 16,
                      offset: Offset(-6, -6),
                    ),
                    BoxShadow(
                      color: Color(OGShadow3),
                      spreadRadius: -5,
                      blurRadius: 16,
                      offset: Offset(6, 6),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpPage())),
                child: Text('No Account? Sign up here.'),
              )
            ],
          ),
        ),
      ]),
    ));
  }
}
