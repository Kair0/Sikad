import 'package:Sikad/services/authentication.dart';
import 'package:Sikad/services/firestore_service.dart';
import 'package:Sikad/services/image_picker.dart';
import 'package:Sikad/services/storage_service.dart';
import 'package:Sikad/itemsIndex.dart';
import 'package:Sikad/services/name_grab.dart';
import 'package:Sikad/widgets/authenthication_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FireBaseAuthService>(
          create: (_) => FireBaseAuthService(),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
        Provider<ItemsIndex>(
          create: (_) => ItemsIndex(),
        ),
        Provider<NameGrab>(
          create: (_) => NameGrab(),
        ),
      ],
      child: MaterialApp(
        home: AuthenticationWidget(),
      ),
    );
  }
}
