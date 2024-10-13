import 'package:aplikasi_sipos/core/constants/colors.dart';
import 'package:aplikasi_sipos/data/datasources/auth_local_datasource.dart';
import 'package:aplikasi_sipos/data/datasources/auth_remote_datasource.dart';
import 'package:aplikasi_sipos/presentation/auth/bloc/login/login_bloc.dart';
import 'package:aplikasi_sipos/presentation/auth/pages/login_page.dart';
import 'package:aplikasi_sipos/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:aplikasi_sipos/presentation/home/pages/dashboard_page.dart'; // Pastikan kamu import DashboardPage
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isAuth(),
          builder: (context, snapshot) {
            // Jika data telah didapatkan dari Future dan bernilai true, arahkan ke DashboardPage
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data == true) {
              return const DashboardPage(); // Arahkan ke Dashboard jika pengguna sudah login
            } else {
              return const LoginPage(); // Arahkan ke LoginPage jika pengguna belum login
            }
          },
        ),
      ),
    );
  }
}
