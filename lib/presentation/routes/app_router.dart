import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:order_app/presentation/presentation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({super.navigatorKey});
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: SplashRoute.page,
        initial: true,
        path: '/',
      ),
      AutoRoute(page: LoginRoute.page, path: '/login'),
      AutoRoute(page: RegisterRoute.page, path: '/register'),
      AutoRoute(
        page: HomeRoute.page,
        path: '/home',
        children: [
          AutoRoute(page: DashboardRoute.page, path: ''),
          AutoRoute(page: ProfileRoute.page, path: 'profile'),
          RedirectRoute(path: "*", redirectTo: '')
        ],
      ),
      AutoRoute(page: CartRoute.page, path: '/cart'),
      AutoRoute(page: OrderRoute.page, path: '/order'),
      AutoRoute(page: ChatRoute.page, path: '/chat'),
    ];
  }
}
