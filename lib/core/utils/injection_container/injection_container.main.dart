part of 'injection_container.dart';

GetIt sl = GetIt.instance;

Future<void> injectionContainer() async {
  await _initNetworkServices();
  await _initMainBloc();
}

Future<void> _initNetworkServices() async {
  sl.registerLazySingleton<NetWorkBaseServices>(() => NetworkServices());
}



Future<void> _initMainBloc() async {
  sl.registerFactory(
    () => MainBloc(),
  );
}
