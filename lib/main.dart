import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/data/main_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/auth/bloc/auth_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/pages/main_calendar_page.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/states/calendar_state.dart';

import 'data/models/tag_model.dart';
import 'presentation/auth/pages/sign_in_screen.dart';
import 'presentation/auth/pages/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1024 * 1024 * 300;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Widget _buildHomePage() {
  return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return const MainCalendarPage();
        } else {
          return const SignInScreen();
        }
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CalendarController contr = CalendarController();
    var t = contr.findLastDay(9);
    print(t);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) => AuthCubit()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.cyan,
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w300),
              // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          ),
          home: _buildHomePage(),
          routes: {
            SignUpScreen.id: ((context) => const SignUpScreen()),
            SignInScreen.id: ((context) => const SignInScreen()),
            MainCalendarPage.id: ((context) => const MainCalendarPage())
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;
    var hexCode = '0xFF${color.value.toRadixString(16).substring(2, 8)}';
    Color newColor = Color(int.parse(hexCode));
    print(hexCode);
    print(newColor);

    MainRepositoryImpl repositoryImpl = MainRepositoryImpl();
    repositoryImpl
        .singIn(email: 'pablank@bk.ru', password: 'pablank123')
        .then((value) {
      if (value != null) {
        print(value.toString());
      }
    });
    //repositoryImpl.getPost(Timestamp.now(), Timestamp.now());
    repositoryImpl.getPost(Timestamp.now(), Timestamp.now()).listen((event) {
      print(event);
    });
    repositoryImpl.addPost(
      descriptoin: 'Описание чего то ',
      tags: [
        TagModel(name: 'работал', color: Colors.green),
        TagModel(name: 'изобретал', color: Colors.yellow),
      ],
      // imagesUrl: ['img1', 'img2'],
    );

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          color: newColor,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
