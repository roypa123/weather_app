import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/configs/constants/string_constants.dart';
import '../../../../core/configs/styles/app_colors.dart';
import '../bloc/main_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: BlocConsumer<MainBloc, MainState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    state is FlashlightOnState
                        ? Icons.flashlight_on
                        : Icons.flashlight_off,
                    color: AppColors.ffd8b0e,
                    size: 80.w,
                  ),
                  35.verticalSpace,
                ],
              );
            }),
      ),
    );
  }
}
