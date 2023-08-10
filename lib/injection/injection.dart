import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:order_app/data/data.dart';

final getIt = GetIt.asNewInstance();

FutureOr<void> configureDependencies() {
  //external dependencies
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance
    ..enablePersistence(const PersistenceSettings(synchronizeTabs: true));

  getIt.registerLazySingleton(() => auth);
  getIt.registerLazySingleton(() => firestore);

  //data
  getIt.registerLazySingleton<AuthSource>(() => AuthSourceImpl(getIt()));
}
