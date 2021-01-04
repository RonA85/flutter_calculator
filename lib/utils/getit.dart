import 'package:flutter_calculator/store/firebase_store.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerSingleton<FirebaseStore>(FirebaseStore());
}
