import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/presentation/presentation.dart';
import 'package:cached_network_image/cached_network_image.dart';

@RoutePage(name: 'DashboardRoute')
class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.loading:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case HomeStatus.failure:
            return ErrorButton(
              onPressed: () {
                context.read<HomeBloc>().add(WatchHomeDisplay());
              },
            );
          default:
            break;
        }
        if (state.display == null) return Container();
        return ListView.builder(
          itemCount: state.display!.productsInCart.length,
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          // ),
          itemBuilder: (context, index) {
            final productInCart = state.display!.productsInCart[index];
            final product = productInCart.product;
            return Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 140,
                    height: 120,
                    child: CachedNetworkImage(
                      imageUrl: product.image ?? "",
                      imageBuilder: (context, imageProvider) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) =>
                          const SizedBox.shrink(),
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator.adaptive(
                          value: progress.progress,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                            ),
                            Text(
                              "\$${product.price / 100}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        if (productInCart.no > 0) ...[
                          BlocBuilder<CartCubit, CartState>(
                            buildWhen: (previous, current) =>
                                previous.status != current.status,
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton.outlined(
                                    onPressed:
                                        /*  state.status == CartStatus.loading
                                            ? null
                                            : */
                                        () {
                                      final id =
                                          productInCart.cartIds.firstOrNull;
                                      if (id != null) {
                                        context
                                            .read<CartCubit>()
                                            .removeFromCart(id);
                                      }
                                    },
                                    style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text(
                                    "${productInCart.no}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  IconButton.outlined(
                                    onPressed:
                                        /*  state.status == CartStatus.loading
                                            ? null
                                            : */
                                        () {
                                      context
                                          .read<CartCubit>()
                                          .addToCart(product);
                                    },
                                    style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                        if (productInCart.no == 0)
                          BlocBuilder<CartCubit, CartState>(
                            buildWhen: (previous, current) =>
                                previous.status != current.status,
                            builder: (context, state) {
                              return FilledButton(
                                onPressed: /*  state.status == CartStatus.loading
                                    ? null
                                    : */
                                    () {
                                  context.read<CartCubit>().addToCart(product);
                                },
                                style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Add to cart"),
                              );
                            },
                          )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
