import 'package:Sikad/colours.dart';
import 'package:flutter/material.dart';
import 'package:Sikad/itemsIndex.dart';
import 'package:provider/provider.dart';

//Pages
import 'package:Sikad/pages/home_page.dart';
import 'package:Sikad/pages/login_page.dart';
import 'package:Sikad/pages/profile_page.dart';
import 'package:Sikad/pages/upload_page.dart';
import 'package:Sikad/pages/social_page.dart';
import 'package:Sikad/pages/signup_page.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<ItemsIndex>(
        create: (context) => ItemsIndex(),
        child: NavigBar(title: 'Navigation Bar'),
      ),
    );
  }
}

class NavigBar extends StatelessWidget {
  final title;

  NavigBar({Key key, this.title}) : super(key: key);
  var pages = [
    HomePage(),
    LoginPage(),
    SocialMedia(),
    ImageUpload(),
    SocialMedia(),
    ProfPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final inde = Provider.of<ItemsIndex>(context, listen: true);
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(OGBlue),
          body: pages[inde.value()],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0),
                  spreadRadius: 1,
                )
              ],
              color: Color(OGBG), //borderRadius: BorderRadius.circular(0)
            ),
            child: Row(
              children: [
                navigationBar(context, Icons.search, 1, 0),
                navigationBar(context, Icons.people_outline, 2, 0),
                navigationBar(context, Icons.add, 3, 1),
                navigationBar(context, Icons.bike_scooter_sharp, 4, 0),
                navigationBar(context, Icons.person_outline, 5, 0),
              ],
            ),
          )),
    );
  }
}

Widget navigationBar(context, IconData icon, int index, int type) {
  final _selectedItemIndex = Provider.of<ItemsIndex>(context, listen: true);
  return GestureDetector(
    onTap: () {
      _selectedItemIndex.equate(index);
      if (_selectedItemIndex.ind == 5) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfPage()));
        _selectedItemIndex.ind = 0;
      } else if (_selectedItemIndex.ind == 3) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ImageUpload()));
        _selectedItemIndex.ind = 0;
      }
      print(_selectedItemIndex.ind);
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 5,
      height: 90,
      child: icon != null
          ? Stack(children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                    left: MediaQuery.of(context).size.width / 10 - 25),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: type == 0 ? Color(0xFFFFFFFF) : Color(OGRed),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                    left: MediaQuery.of(context).size.width / 10 - 25),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: index == _selectedItemIndex.ind
                      ? RadialGradient(
                          colors: [Color(0x33000000), Color(0x66000000)])
                      : RadialGradient(
                          colors: [Color(0x00000000), Color(0x00000000)]),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 25,
                  color: index == _selectedItemIndex.ind || index == 3
                      ? Colors.white
                      : Color(OGBlue),
                ),
              ),
            ])
          : Container(),
    ),
  );
}
