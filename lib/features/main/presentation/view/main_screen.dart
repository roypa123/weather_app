import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/configs/constants/string_constants.dart';
import '../../../../core/configs/styles/app_colors.dart';
import '../../../../core/configs/styles/fonts/roboto.dart';
import '../../../../core/utils/helpers/common_functions.dart';
import '../bloc/main_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Isolate? _isolate;
  ReceivePort? _receivePort;
  // @override
  // void initState() {
  //   _init();
  //   _startIsolate();
  //   super.initState();
  // }

  @override
  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    _receivePort?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(listener: (context, state) {
      if (state is ErrorState) {
        showToast(msg: state.errorMessage.toString(), isError: true);
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            leading: const SizedBox(),
            backgroundColor: AppColors.transparent,
            actions: [
              GestureDetector(
                onTap: () {
                  context.read<MainBloc>().add(
                        const GetCoordinatesEvent(),
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
          backgroundColor: AppColors.white,
          body: state is SuccessState
              ? Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: state.name != Strings.empty
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
                          state.temperature != Strings.empty
                              ? "${state.temperature}${Strings.degreeCelsius}"
                              : Strings.empty,
                          style: RobotoPalette.fWhite_60_400),
                      25.verticalSpace,
                      state.condition != Strings.empty
                          ? Image.network(
                              "https://openweathermap.org/img/wn/10d@2x.png")
                          : const SizedBox(),
                      25.verticalSpace,
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 250.w,
                          child: Column(
                            children: [
                              state.humidity != Strings.empty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Text(Strings.humidity,
                                              style:
                                                  RobotoPalette.fWhite_18_400),
                                        ),
                                        Expanded(
                                          child: Text(Strings.symbol1,
                                              style:
                                                  RobotoPalette.fWhite_18_400),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(state.humidity,
                                              style:
                                                  RobotoPalette.fWhite_18_400),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              state.windSpeed != Strings.empty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Text(Strings.windSpeed,
                                              style:
                                                  RobotoPalette.fWhite_18_400),
                                        ),
                                        Expanded(
                                          child: Text(Strings.symbol1,
                                              style:
                                                  RobotoPalette.fWhite_18_400),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(state.windSpeed,
                                              style:
                                                  RobotoPalette.fWhite_18_400),
                                        )
                                      ],
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue,
                  ),
                ));
    });
  }

  _init() async {
    afterInit(() {
      context.read<MainBloc>().add(
            const GetCoordinatesEvent(),
          );
    });
  }

  Future<void> _startIsolate() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_isolateEntry, _receivePort!.sendPort);

    _receivePort?.listen((message) {
      if (message == 'tick') {
        context.read<MainBloc>().add(const GetCoordinatesEvent());
      }
    });
  }

  static void _isolateEntry(SendPort sendPort) {
    Timer.periodic(const Duration(minutes: 10), (timer) {
      sendPort.send('tick');
    });
  }
}
