/*
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
}*/
