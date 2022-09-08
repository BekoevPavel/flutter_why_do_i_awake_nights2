import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/data/chat_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/data/main_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/auth/bloc/auth_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/bloc/calendar_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/pages/main_calendar_page.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/chat/bloc/chat_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/chat/pages/chat_page.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/bloc/post_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/pages/post_page.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/pages/add_tag_page.dart';

import 'data/models/tag_model.dart';
import 'presentation/auth/pages/sign_in_screen.dart';
import 'presentation/auth/pages/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1024 * 1024 * 300;
  await Firebase.initializeApp();

  runApp(const MyApp());
}

Widget _buildHomePage(BuildContext context) {
  return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return MainCalendarPage();
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
    FirebaseFirestore.instance.collection('posts').snapshots().listen(
      (event) {
        event.docs.length;
      },
    );

    // ChatRepositoryImpl().addMessage(
    //     date: DateTime.now(), message: 'Hello', imagesUrl: ['img1', 'img2']);

    // ChatRepositoryImpl().getMessage().listen(
    //   (event) {
    //     print('----lenght ${event.length}');
    //     for (var i in event) {
    //       print('mes: ${i.message},');
    //     }
    //   },
    // );

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) => AuthCubit()),
          ),
          BlocProvider(
            create: ((context) =>
                CalendarCubit()..updateMonth(DateTime.now().month)),
          ),
          BlocProvider(
            create: ((context) => PostCubit()),
          ),
          BlocProvider(
            create: ((context) => ChatCubit()),
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
          home: _buildHomePage(context),
          routes: {
            SignUpScreen.id: ((context) => const SignUpScreen()),
            SignInScreen.id: ((context) => const SignInScreen()),
            MainCalendarPage.id: ((context) => MainCalendarPage()),
            PostPage.id: (context) => PostPage(),
            AddTagPage.id: (context) => AddTagPage(),
            ChatPage.id: (context) => const ChatPage()
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
