import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/blocs/liked_cats_cubit.dart';

// Создаем глобальный экземпляр GetIt
final getIt = GetIt.instance;

void configureDependencies() {
  // Регистрация кубита лайкнутых котиков как синглтон,
  // чтобы он был доступен во всем приложении.
  getIt.registerLazySingleton<LikedCatsCubit>(() => LikedCatsCubit());
}
