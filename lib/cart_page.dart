import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_wave/data.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    return cartItems.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.remove_shopping_cart_outlined,
                  size: 100,
                ),
                Center(
                    child: Text(
                  'No items in cart',
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
              ],
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cart',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              ...cartItems.map(
                (e) => ListTile(
                  leading: Image.asset(
                    e.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  title: Text(e.product.name),
                  subtitle: Text(e.product.category),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        e.price.floor().toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        e.quantity.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref.read(cartProvider.notifier).remove(e);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Items: ${cartItems.fold<double>(0, (sum, item) => sum + item.quantity).toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        'FAT: ${(cartItems.fold<double>(0, (sum, item) => sum + item.price * item.quantity) * 0.15).toStringAsFixed(2)} SAR',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        'Total: ${(cartItems.fold<double>(0, (sum, item) => sum + item.price * item.quantity) * 1.15).toStringAsFixed(2)} SAR',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // ref.read(cartProvider.notifier).clear();
                    },
                    child: const Text('Clear'),
                  ),
                  FilledButton(
                    onPressed: () {
                      // ref.read(cartProvider.notifier).checkout();
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ],
          );
  }
}
