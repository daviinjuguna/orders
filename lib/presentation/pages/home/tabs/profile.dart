import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/presentation/presentation.dart';

@RoutePage(name: "ProfileRoute")
class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          child: Center(
            child: Column(
              children: [
                const CircleAvatar(),
                const SizedBox(height: 10),
                Text(
                  context.read<SplashBloc>().state.email ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.monetization_on),
          title: const Text("Order History"),
          onTap: () {
            context.navigateTo(const OrderRoute());
            // context.router.pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () async {
            //
            final logout = await showDialog<bool>(
              context: context,
              builder: (builder) => AlertDialog(
                title: const Text("Logout"),
                content: const Text("Are you sure you want to logout?"),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text("Cancel"),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onError,
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Logout"),
                  ),
                ],
              ),
            );
            if (!mounted) return;
            if (logout == true) {
              context.read<LogoutCubit>().logout();
            }
          },
        ),
        // FilledButton.icon(
        //   onPressed: () {
        //     context.read<LogoutCubit>().logout();
        //   },
        //   icon: const Icon(Icons.logout),
        //   label: const Text("Logout"),
        // )
      ],
    );
  }
}
