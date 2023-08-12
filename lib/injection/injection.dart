import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:order_app/data/data.dart';
import 'package:order_app/domain/domain.dart';
import 'package:order_app/presentation/presentation.dart';

final getIt = GetIt.asNewInstance();

FutureOr<void> configureDependencies() {
  //external dependencies
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance
    ..settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

  getIt.registerLazySingleton(() => auth);
  getIt.registerLazySingleton(() => firestore);

  //data
  getIt.registerLazySingleton<AuthSource>(() => AuthSourceImpl(getIt()));
  getIt.registerLazySingleton<ProductSource>(() => ProductSourceImpl(
        getIt(),
        getIt(),
      ));

  //domain
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
  getIt.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(getIt()));

  //usecase
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchAuthUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => HomeDisplayUseCase(getIt()));
  getIt.registerLazySingleton(() => AddToCartUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveFromCartUseCase(getIt()));
  getIt.registerLazySingleton(() => ClearCartUseCase(getIt()));
  getIt.registerLazySingleton(() => CheckoutUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchOrderUseCase(getIt()));

  //bloc
  getIt.registerFactory(() => SplashBloc(getIt()));
  getIt.registerFactory(() => AuthCubit(getIt()));
  getIt.registerFactory(() => LogoutCubit(getIt()));
  getIt.registerFactory(() => ProductBloc(getIt()));
  getIt.registerFactory(() => HomeBloc(getIt()));
  getIt.registerFactory(() => CartCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => CheckoutCubit(getIt()));
  getIt.registerFactory(() => OrderBloc(getIt()));
}
