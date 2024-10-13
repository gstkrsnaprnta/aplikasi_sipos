import 'package:aplikasi_sipos/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../home/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const SpaceHeight(120.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Container(
              child: Image.asset(
                Assets.images.logo.path,
              ),
            ),
          ),
          const SpaceHeight(50.0),
          CustomTextField(
            controller: usernameController,
            label: 'Username',
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SpaceHeight(24.0),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (authResponseModel) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        context.read<LoginBloc>().add(LoginEvent.login(
                            email: usernameController.text,
                            password: passwordController.text));
                      },
                      label: 'Masuk',
                    );
                  },
                  loading: () {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
