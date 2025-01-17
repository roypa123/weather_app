import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/configs/constants/app_json.dart';
import '../../../../core/configs/constants/string_constants.dart';
import '../../../../core/configs/styles/app_colors.dart';
import '../../../../core/configs/styles/fonts/roboto.dart';
import '../bloc/main_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              backgroundColor: AppColors.transparent,
              actions: [
                GestureDetector(
                  onTap: () {
                    context.read<MainBloc>().add(
                          const GetDataEvent(
                            latitude: 10.0087996,
                            longitude: 76.3241211,
                          ),
                        );
                  },
                  child: Icon(
                    Icons.replay,
                    color: AppColors.white,
                    size: 30.w,
                  ),
                ),
                25.horizontalSpace
              ],
            ),
            backgroundColor: AppColors.black,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              width: double.maxFinite,
              height: double.maxFinite,
              child: BlocConsumer<MainBloc, MainState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: state is MainSuccess && state.name != Strings.empty
                                ? Column(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: AppColors.white,
                                        size: 25.w,
                                      ),
                                      Text(state.name,
                                          style: RobotoPalette.fWhite_24_400),
                                    ],
                                  )
                                : const SizedBox()),
                        40.verticalSpace,
                        Text(
                            state is MainSuccess && state.temperature != Strings.empty
                                ? "${state.temperature}${Strings.degreeCelsius}"
                                : Strings.empty,
                            style: RobotoPalette.fWhite_60_400),
                        25.verticalSpace,
                        state is MainSuccess && state.condition != Strings.empty
                            ? Lottie.asset(AppJson.jsonThunder,
                                repeat: true,
                                reverse: false,
                                height: 150.w,
                                width: 150.w,
                                animate: true, onLoaded: (composition) {
                                debugPrint(composition.duration.toString());
                              }, delegates: const LottieDelegates())
                            : const SizedBox(),
                        25.verticalSpace,
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: 250.w,
                            child: Column(
                              children: [
                                state is MainSuccess && state.humidity != Strings.empty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Text(Strings.humidity,
                                                style: RobotoPalette
                                                    .fWhite_18_400),
                                          ),
                                          Expanded(
                                            child: Text(Strings.symbol1,
                                                style: RobotoPalette
                                                    .fWhite_18_400),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(state.humidity,
                                                style: RobotoPalette
                                                    .fWhite_18_400),
                                          )
                                        ],
                                      )
                                    : const SizedBox(),
                                state is MainSuccess && state.windSpeed != Strings.empty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Text(Strings.windSpeed,
                                                style: RobotoPalette
                                                    .fWhite_18_400),
                                          ),
                                          Expanded(
                                            child: Text(Strings.symbol1,
                                                style: RobotoPalette
                                                    .fWhite_18_400),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(state.windSpeed,
                                                style: RobotoPalette
                                                    .fWhite_18_400),
                                          )
                                        ],
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          );
        });
  }
}
