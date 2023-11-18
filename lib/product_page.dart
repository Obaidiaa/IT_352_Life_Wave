import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_wave/data.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage(this.product, {super.key});

  final Product product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final favProduct = ref.watch(favProvider);
    final lowestPriceItem = widget.product.priceAcrossStores
        .reduce((curr, next) => curr['price'] < next['price'] ? curr : next);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      widget.product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListTile(
                              title: Text(
                                'Lowest Price ${lowestPriceItem['price'].floor()} SAR',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              subtitle: Text(
                                'From ${lowestPriceItem['store']}',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingBar.builder(
                            initialRating: widget.product.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ),
                        Text('(${widget.product.rating}) 12.5K Reviews'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ButtonBar(
                          children: [
                            OutlinedButton(
                              child: Row(
                                children: [
                                  Icon(
                                      favProduct.contains(widget.product)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favProduct.contains(widget.product)
                                          ? Colors.red
                                          : null),
                                  SizedBox(width: 8),
                                  Text('Favorite'),
                                ],
                              ),
                              onPressed: () {
                                if (favProduct.contains(widget.product)) {
                                  ref
                                      .read(favProvider.notifier)
                                      .remove(widget.product);
                                } else {
                                  ref
                                      .read(favProvider.notifier)
                                      .add(widget.product);
                                }
                              },
                            ),
                            FilledButton(
                                onPressed: () {
                                  ref
                                          .read(cartProvider)
                                          .where((element) =>
                                              element.product.name ==
                                              widget.product.name)
                                          .isEmpty
                                      ? ref.read(cartProvider.notifier).add(
                                          CartItem(
                                              product: widget.product,
                                              price: widget.product.price,
                                              quantity: 1,
                                              store: lowestPriceItem['store']))
                                      : ref
                                          .read(cartProvider)
                                          .firstWhere((element) =>
                                              element.product.name ==
                                              widget.product.name)
                                          .quantity++;
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.add_shopping_cart),
                                    SizedBox(width: 8),
                                    Text('Cart'),
                                  ],
                                )),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...widget.product.priceAcrossStores
                .map(
                  (e) => ListTile(
                    leading: Image.asset(
                      widget.product.imageUrl,
                      width: 50,
                      height: 50,
                    ),
                    title: Text('${e['price'].floor()} SAR'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${e['store']}',
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            ref
                                    .read(cartProvider)
                                    .where((element) =>
                                        element.product.name ==
                                        widget.product.name)
                                    .isEmpty
                                ? ref.read(cartProvider.notifier).add(CartItem(
                                    product: widget.product,
                                    price: widget.product.price,
                                    quantity: 1,
                                    store: e['store']))
                                : ref
                                    .read(cartProvider)
                                    .firstWhere((element) =>
                                        element.product.name ==
                                        widget.product.name)
                                    .quantity++;
                          },
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
