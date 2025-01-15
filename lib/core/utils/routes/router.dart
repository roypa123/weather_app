import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/routes/route_constants.dart';

import '../../../features/main/presentation/bloc/main_bloc.dart';
import '../../../features/main/presentation/view/main_screen.dart';
import '../../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../../features/splash/presentation/view/splash_screen.dart';
import '../../common/views/empty_screen.dart';
import '../injection_container/injection_container.dart';

part 'route_generator.dart';