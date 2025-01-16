import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/configs/constants/app_constants.dart';
import 'core/configs/styles/app_theme.dart';
import 'core/utils/routes/route_constants.dart';
import 'core/utils/routes/router.dart';


class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        title: AppConstants.appName,
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: RouteConstants.routeMainScreen,
        theme: AppTheme.themeData,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery.withClampedTextScaling(
            minScaleFactor: 0.75,
            maxScaleFactor: 1.4,
            child: child ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
