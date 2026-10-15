import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'routes/app_routes.dart';

/// Root widget: sets the app title, theme, and routes.
class TutorMatchApp extends StatelessWidget {
  const TutorMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutor Match AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.background,
      ),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
