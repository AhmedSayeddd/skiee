import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skiee/auth/cubit/auth_cubit.dart';
import 'package:skiee/auth/pages/login_screen.dart';
import 'package:skiee/auth/pages/register_screen.dart';
import 'package:skiee/favorites/cubit/favorites_cubit.dart';
import 'package:skiee/flight/cubit/booking_cubit.dart';
import 'package:skiee/navigation/cubit/navigation_cubit.dart';
import 'package:skiee/navigation/main_shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => BookingCubit()),
        BlocProvider(create: (_) => FavoritesCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          MainShell.routeName: (context) => const MainShell(),
        },
      ),
    );
  }
}
