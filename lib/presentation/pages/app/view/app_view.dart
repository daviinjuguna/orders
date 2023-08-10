import 'package:flutter/material.dart';
import 'package:order_app/const/const.dart';
import 'package:order_app/presentation/presentation.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final _navKey = GlobalKey<NavigatorState>();
  late final AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(navigatorKey: _navKey);
    super.initState();
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData.from(colorScheme: AppColors.light),
      darkTheme: ThemeData.from(colorScheme: AppColors.dark),
    );
  }
}
