import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection/injection.dart';
import 'presentation/blocs/liked_cats_cubit.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  // Настраиваем DI
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LikedCatsCubit>(create: (_) => getIt<LikedCatsCubit>()),
      ],
      child: MaterialApp(
        title: 'Cat Tinder',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.pink[50],
          primarySwatch: Colors.pink,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
