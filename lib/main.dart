import 'dart:io';

import 'package:event/Bloc/ClubBloc/clubbloc_bloc.dart';
import 'package:event/Bloc/EventBloc/eventbloc_bloc.dart';
import 'package:event/Bloc/Theme/theme_cubit.dart';
import 'package:event/Bloc/maincubit/main_cubit.dart';
import 'package:event/model/club.dart';
import 'package:event/model/event.dart';
import 'package:event/model/user.dart';
import 'package:event/pages/Home.dart';
import 'package:event/pages/login.dart';
import 'package:event/pages/signUpPage.dart';
import 'package:event/pages/splashScreen.dart';
import 'package:event/univesal/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'Bloc/AuthenticationBloc/authenticationbloc_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ClubAdapter());
  Hive.registerAdapter(EventAdapter());

  await Hive.openBox("user");
  await Hive.openBox("Events");
  await Hive.openBox("club");

  return runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (create) => AuthenticationblocBloc()
            ..add(
              CheckAuthentication(),
            ),
        ),
        BlocProvider(
          create: (create) => ClubblocBloc()..add(FetchClubs()),
        ),
        BlocProvider(
          create: (create) => EventblocBloc(),
        ),
        BlocProvider(
          create: (create) => MainCubit()..changePage(0),
        ),
        BlocProvider(create: (create) => ThemeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: "Event",
        initialRoute: "/landingPage",
        routes: routes);
  }
}

class LandingPage extends StatefulWidget {
  static final String routeName = '/landingPage';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  AuthenticationblocBloc authbloc;
  @override
  void initState() {
    authbloc = BlocProvider.of<AuthenticationblocBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: authbloc,
      builder: (context, state) {
        print(state);
        if (state is AuthenticationblocInitial) {
          return SplashScreen();
        } else if (state is LoginState) {
          return LoginPage();
        } else if (state is SignUpState) {
          print("yes");
          return SignUpPage();
        } else if (state is AuthenticationLogedIn) {
          return MyHome();
        }
        return SplashScreen();
      },
    );
  }

  @override
  void dispose() {
    authbloc.close();
    super.dispose();
  }
}
