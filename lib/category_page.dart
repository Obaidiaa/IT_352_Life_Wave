import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_wave/data.dart';
import 'package:life_wave/product_page.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(favProvider);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: SearchBar(
            leading: Icon(Icons.mic),
            hintText: 'Search',
            onChanged: (value) {
              ref.read(todoListFilterByName.notifier).state = value;
            },
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final todos = ref.watch(filteredTodos);
            return Column(
              children: [
                Wrap(
                  spacing: 5.0,
                  children: ref.watch(todoListCategory).map((exercise) {
                    return FilterChip(
                      label: Text(exercise),
                      selected:
                          ref.watch(todoListCategoryFilter).contains(exercise),
                      onSelected: (bool selected) {
                        print('-------------------------------------');
                        print(ref
                            .watch(todoListCategoryFilter)
                            .contains(exercise));
                        print('-------------------------------------');

                        // setState(() {
                        if (selected) {
                          ref
                              .read(todoListCategoryFilter.notifier)
                              .update((state) => [...state, exercise]);
                        } else {
                          ref.read(todoListCategoryFilter.notifier).update(
                              (state) => state
                                  .where((element) => element != exercise)
                                  .toList());
                        }
                        // });
                      },
                    );
                  }).toList(),
                ),
                if (todos.isEmpty)
                  const Center(
                    child: Text('No products found'),
                  )
                else
                  ...todos
                      .map(
                        (e) => InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductPage(e),
                                  ),
                                ),
                            child: ListTile(
                              leading: Image.asset(
                                e.imageUrl,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(e.name),
                              subtitle: Text(e.category),
                              trailing: ButtonBar(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: ref.read(favProvider).contains(e)
                                        ? const Icon(Icons.favorite,
                                            color: Colors.red)
                                        : const Icon(Icons.favorite_border),
                                    onPressed: () {
                                      if (ref.read(favProvider).contains(e)) {
                                        ref.read(favProvider.notifier).remove(
                                            ref.read(favProvider).firstWhere(
                                                (element) =>
                                                    element.name == e.name));
                                      } else {
                                        ref.read(favProvider.notifier).add(ref
                                            .read(todoListProvider)
                                            .firstWhere((element) =>
                                                element.name == e.name));
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_shopping_cart),
                                    onPressed: () {
                                      ref
                                              .read(cartProvider)
                                              .where((element) =>
                                                  element.product.name ==
                                                  e.name)
                                              .isEmpty
                                          ? ref.read(cartProvider.notifier).add(
                                              CartItem(
                                                  product: e,
                                                  price: e.price,
                                                  quantity: 1,
                                                  store: 'Store'))
                                          : ref
                                              .read(cartProvider)
                                              .firstWhere((element) =>
                                                  element.product.name ==
                                                  e.name)
                                              .quantity++;
                                    },
                                  ),
                                ],
                              ),
                            )),
                      )
                      .toList()
              ],
            );
          },
        )
      ],
    );
  }
}
