import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:order_app/injection/injection.dart';
import 'package:order_app/presentation/presentation.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.bloc, required this.cubit});
  final HomeBloc bloc;
  final CartCubit cubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // value: bloc,
      providers: [
        BlocProvider.value(value: bloc),
        BlocProvider.value(value: cubit),
        BlocProvider(
          create: (create) => getIt<CheckoutCubit>(),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CheckoutCubit, CheckoutState>(
            listener: (context, state) {
              switch (state) {
                case CheckoutState.loading:
                  context.loadingSnackbar();
                  break;
                case CheckoutState.failure:
                  context.errorSnackbar();
                  break;
                case CheckoutState.success:
                  context.hideSnackBar();
                  //replace with order page
                  // context.router.navigate(const OrderRoute());
                  break;
                default:
              }
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final cart = state.display?.cart;
              // final products = state.display?.products;
              if (cart == null || cart.prodCount == 0) {
                return LottieBuilder.asset(
                  'assets/empty.json',
                  frameBuilder: (context, child, composition) => Column(
                    children: [
                      child,
                      const Text("A little dull in here, don't you think?"),
                      const SizedBox(height: 10),
                      FilledButton(
                        onPressed: () {
                          context.router.navigate(const HomeRoute());
                        },
                        child: const Text("Get something!"),
                      )
                    ],
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                children: [
                  const Text("Cart summary"),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                "\$${(cart.total / 100).toStringAsFixed(2)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Delivery fees not included",
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //cart
                  const SizedBox(height: 10),
                  Text("Cart (${cart.prodCount})"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.display.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      // final productInCart = state.display!.productsInCart[index];
                      final prodDisp = cart.display[index];
                      final product = prodDisp.product;
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
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator.adaptive(
                                    value: progress.progress,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
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
                                        Text(
                                          "\$${product.price / 100}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                                  prodDisp.cartIds.firstOrNull;
                                              if (id != null) {
                                                context
                                                    .read<CartCubit>()
                                                    .removeFromCart(id);
                                              }
                                            },
                                            style: IconButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(
                                            prodDisp.quantity.toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  // TextButton(
                                  //   onPressed: () {
                                  //     context
                                  //         .read<CartCubit>()
                                  //         .clearCart(product);
                                  //   },
                                  //   child: const Text("Remove item"),
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final checkout = await showDialog<bool>(
                        context: context,
                        builder: (builder) => AlertDialog(
                          title: const Text("Checkout"),
                          content: Text(
                            "Are you sure you want to checkout for \$${(cart.total / 100).toStringAsFixed(2)}?",
                          ),
                          actions: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                                backgroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                              ),
                              child: const Text("Cancel"),
                            ),
                            FilledButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );

                      if (checkout == true) {
                        context.read<CheckoutCubit>().checkout(
                              amount: cart.total,
                              products:
                                  cart.products.map((e) => e.product).toList(),
                            );
                      }
                    },
                    icon: const Icon(Icons.payment),
                    label: Text(
                      "Checkout (\$${(cart.total / 100).toStringAsFixed(2)})",
                    ),
                  ),
                  const Text(
                    "OR",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.router.navigate(const HomeRoute());
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text("Add more items"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
