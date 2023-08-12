import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/const/const.dart';
import 'package:order_app/domain/domain.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<SplashBloc, UserEntity>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                _appRouter.pushAndPopUntil(
                  const HomeRoute(),
                  predicate: (route) => false,
                );
                break;
              case AuthStatus.unauthenticated:
                _appRouter.pushAndPopUntil(
                  const LoginRoute(),
                  predicate: (route) => false,
                );
                break;
              default:
            }
          },
          child: Container(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        theme: const AppUi().theme,
        darkTheme: const DarkAppUi().theme,
      ),
    );
  }
}
