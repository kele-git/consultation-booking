import 'package:flutter/material.dart';
import '../views/home_screen.dart';
import '../views/profile_page_screen.dart';
import '../views/add_consultation_screen.dart';
import '../views/consultation_details_screen.dart';

class RouteManager {
  static const String home = '/';
  static const String profile = '/profile';
  static const String addConsultation = '/addConsultation';
  static const String consultationDetails = '/consultationDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => ProfilePageScreen());

      case addConsultation:
        return MaterialPageRoute(builder: (_) => AddConsultationScreen());

      case consultationDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) =>
                  ConsultationDetailsScreen(consultation: args['consultation']),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
