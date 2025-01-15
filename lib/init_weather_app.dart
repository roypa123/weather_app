
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/helpers/device_functions.dart';
import 'core/utils/injection_container/injection_container.dart';

Future<void> initWeatherApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectionContainer();
  await ScreenUtil.ensureScreenSize();
  lockDeviceRotation();
}