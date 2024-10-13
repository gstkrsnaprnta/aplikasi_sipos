import 'package:aplikasi_sipos/data/datasources/auth_local_datasource.dart';
import 'package:aplikasi_sipos/presentation/auth/pages/login_page.dart';
import 'package:aplikasi_sipos/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:aplikasi_sipos/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../widgets/nav_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    Center(
      child: Text("Order"),
    ),
    Center(
      child: Text("History"),
    ),
    Center(
      child: Text("Menu"),
    ),
    // const HomePage(),
    // const OrdersPage(),
    // const Placeholder(),
    // const ManageMenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: Assets.icons.home.path,
              label: 'Home',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
                iconPath: Assets.icons.orders.path,
                label: 'Orders',
                isActive: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  //context.push(const OrdersPage());
                }),
            NavItem(
              iconPath: Assets.icons.payments.path,
              label: 'History',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            NavItem(
              iconPath: Assets.icons.dashboard.path,
              label: 'Kelola',
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
