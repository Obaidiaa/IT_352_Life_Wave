import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_wave/data.dart';
import 'package:life_wave/product_page.dart';

class FavPage extends ConsumerStatefulWidget {
  const FavPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavPageState();
}

class _FavPageState extends ConsumerState<FavPage> {
  @override
  Widget build(BuildContext context) {
    final favProduct = ref.watch(favProvider);
    return favProduct.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite_border,
                  size: 100,
                ),
                Center(
                    child: Text(
                  'No items in favorites list',
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
              ],
            ),
          )
        : Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: favProduct.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(favProduct[index]),
                      ),
                    ),
                    child: ListTile(
                        leading: Image.asset(
                          favProduct[index].imageUrl,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(favProduct[index].name),
                        subtitle: Text(favProduct[index].category),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref
                                .read(favProvider.notifier)
                                .remove(favProduct[index]);
                          },
                        )),
                  );
                },
              ),
            ],
          );
  }
}
