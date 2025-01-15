import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/configs/constants/string_constants.dart';
import '../../../../core/configs/styles/app_colors.dart';
import '../../../../core/utils/routes/route_constants.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigate) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteConstants.routeMainScreen,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.flashlight_on,
                size: 70.w,
                color: AppColors.ffd8b0e,
              ),
              25.verticalSpace,
              Text(
                Strings.weatherApp,
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ffd8b0e),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
