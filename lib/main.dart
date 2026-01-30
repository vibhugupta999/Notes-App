import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/Provider/noteprovider.dart';
import 'package:notes/Provider/registrationcontroller.dart';
import 'package:notes/Screens/homescreen.dart';
import 'package:notes/Screens/loginsignupscreen.dart';
import 'package:notes/Services/authentication_services.dart';
import 'package:notes/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(
          create: (context) => RegistrationcontrollerProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FlutterQuillLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        // darkTheme: ThemeData(brightness: Brightness.dark),
        theme: ThemeData(
          disabledColor: Colors.grey.shade500,
          primaryColor: Color.fromARGB(255, 255, 198, 11),
          primaryColorDark: Color.fromARGB(255, 209, 162, 7),
          textTheme: TextTheme(
            labelMedium: TextStyle(color: Color(0xfff0f2f5)),
            headlineMedium: TextStyle(color: Color(0xff3f4346)),
            titleLarge: TextStyle(fontFamily: "Serif"),
          ),
        ),
        home: StreamBuilder(
          stream: AuthServices.userStream,
          builder: (context, snapshot) {
            return snapshot.hasData && AuthServices.isEmailVerified
                ? const Homescreen()
                : const Loginsignupscreen();
          },
        ),
      ),
    );
  }
}
