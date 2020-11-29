import 'package:Sikad/colours.dart';
import 'package:Sikad/pages/signup_page.dart';
import 'package:Sikad/services/authentication.dart';
import 'package:Sikad/services/firestore_service.dart';
import 'package:Sikad/widgets/authenthication_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _errorMsg = '';
  bool _proceed = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn(BuildContext context) async {
    try {
      final auth = Provider.of<FireBaseAuthService>(context, listen: false);
      final _nameEmail = Provider.of<FirestoreService>(context, listen: false);
      final user = await auth.signIn(
          email: _emailController.text.toLowerCase().trim(),
          password: _passwordController.text.toLowerCase().trim());
      _nameEmail.getName(uid: user.uid);
      _nameEmail.getName(uid: user.uid);
      AuthenticationWidget();
      print('uid: ${user.uid}');
    } catch (e) {
      setState(() {
        _proceed = true;
        _errorMsg =
            Provider.of<FireBaseAuthService>(context, listen: false).errorMsg();
      });
      print(_errorMsg);
      print(e);
    }
  }

  final TextStyle _fieldTexts = TextStyle(
      color: Color(OGBlue),
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
      package: 'Sikad');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(OGBG),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'images/logo.png',
                width: 331,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            //fillup forms
            Column(
              children: [
                //error msg
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '$_errorMsg',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'PublicSans',
                        package: 'Sikad'),
                  ),
                ),
                //email input
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 100),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'E-mail Address',
                        style: _fieldTexts,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.centerRight,
                      width: 212,
                      height: 36,
                      child: TextField(
                        controller: _emailController,
                        style: _fieldTexts,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(OGGray),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(OGShadow3),
                            blurRadius: 16,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //password input
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 100),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: _fieldTexts,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 212,
                      height: 36,
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        style: _fieldTexts,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(OGGray),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(OGShadow3),
                            blurRadius: 16,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //buttons and redirect
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 27, 0, 15),
                  child: ButtonTheme(
                    minWidth: 186,
                    height: 36,
                    child: RaisedButton(
                      color: Color(OGShadow2),
                      onPressed: () {
                        _signIn(context).whenComplete(() {
                          if (!_proceed) Navigator.pop(context);
                          print(_proceed);
                          _proceed = !_proceed;
                        });
                      },
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
          ],
        ),
      ),
    );
  }
}
