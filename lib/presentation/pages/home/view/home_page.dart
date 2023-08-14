import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/injection/injection.dart';
import 'package:order_app/presentation/presentation.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => getIt<LogoutCubit>()),
        BlocProvider(
          create: (create) => getIt<HomeBloc>()..add(WatchHomeDisplay()),
        ),
        BlocProvider(create: (create) => getIt<CartCubit>())
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.navigate(const ChatRoute());
        },
        child: const Icon(Icons.message_outlined),
      ),
      appBarBuilder: (context, tabsRouter) => AppBar(
        title: const Text('Order App'),
        actions: [
          //cart button
          IconButton(
            onPressed: () {
              context.router.navigate(CartRoute(
                bloc: context.read(),
                cubit: context.read(),
              ));
            },
            icon: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final cart = state.display?.cart;
                if (cart == null || cart.prodCount == 0) {
                  return const Icon(Icons.shopping_cart);
                }
                return Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cart.prodCount.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      routes: const [
        DashboardRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}
