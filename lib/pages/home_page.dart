import 'package:Sikad/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:Sikad/services/name_grab.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sikad/colours.dart';
import 'package:Sikad/itemsIndex.dart';
import 'package:Sikad/pages/profile_page.dart';
import 'package:Sikad/widgets/post_widget.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<ItemsIndex>(
        create: (context) => ItemsIndex(),
        child: Home(title: 'Home Page'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(OGBG),
      body: Container(
        //padding: EdgeInsets.only(left: 10, right: 10, top: 45),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 74,
              width: 123,
              child: Image.asset(
                'images/Logo_home.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Highlights",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(OGBlue),
                    fontFamily: 'PublicSans',
                    package: 'Sikad',
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              //height: MediaQuery.of(context).size.width / 1.5,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('causes')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return const Text('Loading');
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(8),
                        itemBuilder: (context, index) =>
                            eachCard(context, snapshot.data.docs[index]));
                  }),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("New Drives",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(OGBlue),
                      fontFamily: 'PublicSans',
                      package: 'Sikad',
                    )),
              ),
            ),
            Flexible(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('causes')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return const Text('Loading');
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, index) =>
                          eachCard(context, snapshot.data.docs[index]),
                    );
                  }),
            )
          ],
        ),
      ), /*
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0),
                    spreadRadius: 1,
                  )
                ],
                color: Colors.grey.withOpacity(0),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                navigationBar(context, Icons.search, 1, 0),
                navigationBar(context, Icons.people_outline, 2, 0),
                navigationBar(context, Icons.add, 3, 1),
                navigationBar(context, Icons.bike_scooter_sharp, 4, 0),
                navigationBar(context, Icons.person_outline, 5, 0),
              ],
            ),
          )),*/
    ));
  }

  Widget navigationBar(context, IconData icon, int index, int type) {
    final selectedItemIndex = Provider.of<ItemsIndex>(context, listen: true);
    return GestureDetector(
      onTap: () {
        selectedItemIndex.equate(index);
        if (selectedItemIndex.ind == 5) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfPage()));
        } else {
          null;
        }

        print(selectedItemIndex.ind);
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
                    gradient: index == selectedItemIndex.ind
                        ? RadialGradient(
                            colors: [Color(0xFF000000), Color(0x66000000)])
                        : RadialGradient(
                            colors: [Color(0x00000000), Color(0x00000000)]),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: 25,
                    color: index == selectedItemIndex.ind
                        ? Colors.white
                        : Color(OGBlue),
                  ),
                ),
              ])
            : Container(),
      ),
    );
  }
}
