import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpg_assignment/firebase_options.dart';
import 'package:tpg_assignment/views/screens/login_screen.dart';
import 'viewmodels/consultation_viewmodel.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'routes/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';

// Group Members //
// K Kekane, 220043566
// TA Mokgothu, 222029599
// TF Mokone, 222014234
// ST Hadebe, 222078272
// K Taaibosch, 222001440
// TP Montsho, 222034315

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAuNeua1ROPQGLo4-jRPDxLFytAz3oidM4",
        appId: "1:672341438364:web:5c479dec65a5d74f6b2259",
        messagingSenderId: "672341438364",
        projectId: "student-portal-b19f0",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConsultationViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPG Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteManager.home,
      onGenerateRoute: RouteManager.generateRoute,
      home: const LoginScreen(),
    );
  }
}
