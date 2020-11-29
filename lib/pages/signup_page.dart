import 'package:Sikad/services/authentication.dart';
import 'package:Sikad/services/firestore_service.dart';
import 'package:Sikad/services/name_grab.dart';
import 'package:flutter/material.dart';
import 'package:Sikad/colours.dart';
import 'package:provider/provider.dart';

// class SignUpPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Color(OGBG),
//         body: MyCustomForm(),
//       ),
//     );
//   }
// }

// Create a Form widget.
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  String _errorMsg = '';
  bool _proceed = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp(BuildContext context) async {
    try {
      final auth = Provider.of<FireBaseAuthService>(context, listen: false);
      final _nameEmail = Provider.of<FirestoreService>(context, listen: false);
      final name = Provider.of<NameGrab>(context, listen: false);
      final user = await auth.signUp(
          email: _emailController.text.toLowerCase().trim(),
          password: _passwordController.text.toLowerCase().trim());
      name.setNewName(_nameController.text);
      _nameEmail.getName(uid: auth.authResult.user.uid);
    } catch (e) {
      setState(() {
        _proceed = false;
        _errorMsg =
            Provider.of<FireBaseAuthService>(context, listen: false).errorMsg();
      });
      print(_errorMsg);
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();

  final TextStyle _fieldTexts = TextStyle(
      color: Color(OGBlue),
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
      package: 'Sikad');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: MaterialApp(
            home: Scaffold(
                backgroundColor: Color(OGBG),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'images/logo.png',
                              width: 170,
                              height: 100,
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
                              //name input
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 100),
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Name',
                                      style: _fieldTexts,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    alignment: Alignment.centerRight,
                                    width: 212,
                                    height: 36,
                                    child: TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(OGGray),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please fill in the field';
                                        }
                                        return null;
                                      },
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
                              //email input
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 100),
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'E-mail Address',
                                      style: _fieldTexts,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    alignment: Alignment.centerRight,
                                    width: 212,
                                    height: 36,
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(OGGray),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please fill in the field';
                                        }
                                        if (!RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
                                          return 'Please enter valid email';
                                        }
                                        return null;
                                      },
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 25),
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
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(OGGray),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      validator: (value) {
                                        if (value.length < 8) {
                                          return 'Password is too short';
                                        }
                                        return null;
                                      },
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
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 25, 0, 20),
                            child: ButtonTheme(
                              minWidth: 186,
                              height: 36,
                              child: RaisedButton(
                                color: Color(OGShadow2),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _signUp(context).whenComplete(() {
                                      if (_proceed) Navigator.pop(context);
                                      print(_proceed);
                                      _proceed = !_proceed;
                                    });
                                    // Scaffold.of(context).showSnackBar(
                                    //     SnackBar(content: Text('Processing Data')));
                                  }
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(11.0)),
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
                        ],
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
