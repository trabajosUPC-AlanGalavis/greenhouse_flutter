import 'package:flutter/material.dart';
import 'package:greenhouse/screens/crops/crops_archive.dart';
import 'package:greenhouse/screens/menu/home.dart';
import 'package:greenhouse/screens/crops/crops_in_progress.dart';
import 'package:greenhouse/screens/menu/dashboard.dart';
import 'package:greenhouse/screens/menu/login.dart';
import 'package:greenhouse/screens/crops/records.dart';
import 'package:greenhouse/screens/menu/sign_up.dart';
import 'package:greenhouse/screens/crops/stepper.dart';
import 'package:greenhouse/screens/profiles/user_profile.dart';
import 'package:greenhouse/widgets/crop_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greenhouse',
      theme: ThemeData(
        fontFamily: 'Inter',
        splashColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => HomeScreen();
            break;
          case '/login':
            builder = (BuildContext _) => LoginScreen();
            break;
          case '/signup':
            builder = (BuildContext _) => SignUpScreen();
            break;
          case '/dashboard':
            builder = (BuildContext _) => Dashboard();
            break;
          case '/crops-in-progress':
            builder = (BuildContext _) => CropsInProgress(key: UniqueKey());
            break;
          case '/crops-archive':
            builder = (BuildContext _) => CropsArchive(key: UniqueKey());
            break;
          case '/stepper':
            builder = (BuildContext _) => StepperWidget(chosenCrop: settings.arguments as CropCard);
            break;
          case '/records':
            builder = (BuildContext _) => RecordsScreen();
            break;
          case '/user-profile':
            builder = (BuildContext _) => UserProfile();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
