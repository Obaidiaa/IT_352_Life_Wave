import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_wave/data.dart';
import 'package:life_wave/product_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(todoListProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Text(
                'Welcome Ahmed,',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        ...ref.watch(todoListCategory).map(
              (e) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Text(
                          '${e}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                    ),
                    items: products
                        .where((element) => element.category.toLowerCase() == e)
                        .map((i) {
                      final low = i.priceAcrossStores.reduce((curr, next) =>
                          curr['price'] < next['price'] ? curr : next);

                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(i),
                              ),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image.asset(
                                        i.imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      i.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text('Start from ${low['price']} SAR',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
