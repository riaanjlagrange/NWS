import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_state.dart';
import 'package:nws/components/custom_bottom_nav_bar.dart';
import 'package:nws/components/loader.dart';
import 'package:nws/core/constants.dart';
import 'package:nws/pages/dashboard/dashboard_page.dart';
import 'package:nws/pages/kata/kata_page.dart';
import 'package:nws/pages/loader_page.dart';
import 'package:nws/pages/nav_page.dart';
import 'package:nws/pages/profile/profile_page.dart';
import 'package:nws/pages/videos/videos_page.dart';

// MainScaffold is to be used to manage all sub pages when logged in
// to make it more seemless when switches between pages/tabs
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  // set the starting index (dashboard)
  int _currentIndex = 0;

  // list of pages using navpage abstract class
  late final List<NavPage> _pages = [
    const DashboardPage(),
    const VideosPage(),
    const KataPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // get the current page
    final currentPage = _pages[_currentIndex];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // set the appbar title to the current page title
        title: Text(currentPage.title),
        automaticallyImplyLeading: false,
        // set the appbar actions to the current page's actions
        actions: currentPage.appBarActions,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // check the state and display the correct widget
          if (state is AuthLoading) {
            return LoaderPage(color: theme.colorScheme.primary, size: 40.0);
          }
          if (state is AuthAuthenticated) {
            // if the state is authenticated, show the current page
            return IndexedStack(index: _currentIndex, children: _pages);
          }
          return const Center(child: Text("Not authenticated"));
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
