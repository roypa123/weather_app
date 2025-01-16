import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/configs/constants/app_json.dart';
import '../../../../core/configs/constants/string_constants.dart';
import '../../../../core/configs/styles/app_colors.dart';
import '../../../../core/configs/styles/fonts/dm_serif_display.dart';
import '../bloc/main_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: AppColors.transparent,
        actions: [
          GestureDetector(
            onTap: () {},
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
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: AppColors.white,
                          size: 30.w,
                        ),
                        Text("India",
                            style: DmSerifDisplayPalette.fWhite_24_400),
                        Text("Date",
                            style: DmSerifDisplayPalette.fWhite_18_400),
                      ],
                    ),
                  ),
                  40.verticalSpace,
                  Text("22", style: DmSerifDisplayPalette.fWhite_60_400),
                  25.verticalSpace,
                  Lottie.asset(AppJson.jsonThunder,
                      repeat: true,
                      reverse: false,
                      height: 150.w,
                      width: 150.w,
                      animate: true, onLoaded: (composition) {
                    debugPrint(composition.duration.toString());
                  }, delegates: const LottieDelegates()),
                  25.verticalSpace,
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 250.w,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text("Humidity (%)",
                                    style: DmSerifDisplayPalette.fWhite_18_400),
                              ),
                              Expanded(
                                child: Text(" - ",
                                    style: DmSerifDisplayPalette.fWhite_18_400),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("sa ",
                                    style: DmSerifDisplayPalette.fWhite_18_400),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text("Wind Speed (m/s)",
                                    style: DmSerifDisplayPalette.fWhite_18_400),
                              ),
                              Expanded(
                                child: Text(" - ",
                                    style: DmSerifDisplayPalette.fWhite_18_400),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("sas",
                                    style: DmSerifDisplayPalette.fWhite_18_400),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
