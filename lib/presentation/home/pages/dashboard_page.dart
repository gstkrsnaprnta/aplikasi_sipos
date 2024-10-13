import 'package:aplikasi_sipos/data/datasources/auth_local_datasource.dart';
import 'package:aplikasi_sipos/presentation/auth/pages/login_page.dart';
import 'package:aplikasi_sipos/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: () {
                  AuthLocalDatasource().removeAuthData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              );
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(LogoutEvent.logout());
                },
                icon: const Icon(
                  Icons.add,
                  size: 24.0,
                ),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body: Center(
        child: const Text("Welcome to the Dashboard!"),
      ),
    );
  }
}
