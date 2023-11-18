import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final List priceAcrossStores;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.priceAcrossStores,
  });
}

final todoListProvider =
    NotifierProvider<ProductList, List<Product>>(ProductList.new);

// enum TodoListFilter {
//   // all,
//   electronics,
//   beauty,
// }

final todoListFilter = StateProvider((_) => null);
final todoListCategory = StateProvider<List<String>>((ref) {
  final prodcutCategory = ref
      .watch(todoListProvider)
      .map((e) => e.category.toLowerCase())
      .toSet()
      .toList();
  return prodcutCategory;
});

final todoListCategoryFilter = StateProvider((_) => []);

final todoListFilterByName = StateProvider((_) => '');
final filteredTodos = Provider<List<Product>>((ref) {
  // final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);
  final filterByName = ref.watch(todoListFilterByName);
  final categoryFilter = ref.watch(todoListCategoryFilter);

  print(categoryFilter);
  List<Product> filter = todos;

  if (categoryFilter.isNotEmpty && filterByName.isNotEmpty) {
    final stage1 = todos
        .where((todo) =>
            todo.name.toLowerCase().contains(filterByName.toLowerCase()))
        .toList();
    return stage1
        .where((todo) => categoryFilter.contains(todo.category.toLowerCase()))
        .toList();
  }

  if (filterByName.isNotEmpty) {
    filter = todos
        .where((todo) =>
            todo.name.toLowerCase().contains(filterByName.toLowerCase()))
        .toList();
  }

  if (categoryFilter.isNotEmpty) {
    filter = todos
        .where((todo) => categoryFilter.contains(todo.category.toLowerCase()))
        .toList();
  }

  return filter;
});

class ProductList extends Notifier<List<Product>> {
  @override
  List<Product> build() => [
        Product(
          name: 'Gaming Headset',
          price: 199.0,
          imageUrl: './lib/images/gaming_headset.jpg',
          category: 'electronics',
          rating: 4.5,
          priceAcrossStores: [
            {
              'store': 'Jarir',
              'price': 199.0,
            },
            {
              'store': 'Extra',
              'price': 259.0,
            },
            {
              'store': 'Amazon',
              'price': 369.0,
            },
          ],
        ),
        Product(
          name: 'Gaming Keyboard',
          price: 299.0,
          imageUrl: './lib/images/gaming_keyboard.jpg',
          category: 'electronics',
          rating: 4.5,
          priceAcrossStores: [
            {
              'store': 'Jarir',
              'price': 299.0,
            },
            {
              'store': 'Extra',
              'price': 399.0,
            },
            {
              'store': 'Amazon',
              'price': 499.0,
            },
          ],
        ),
        Product(
          name: 'Gaming Mouse',
          price: 99.0,
          imageUrl: './lib/images/gaming_mouse.jpg',
          category: 'electronics',
          rating: 4,
          priceAcrossStores: [
            {
              'store': 'Jarir',
              'price': 195.0,
            },
            {
              'store': 'Extra',
              'price': 99.0,
            },
            {
              'store': 'Amazon',
              'price': 89.0,
            },
          ],
        ),
        Product(
          name: 'Gaming Chair',
          price: 599.0,
          imageUrl: './lib/images/gaming_chair.jpg',
          category: 'electronics',
          rating: 4.5,
          priceAcrossStores: [
            {
              'store': 'Jarir',
              'price': 599.0,
            },
            {
              'store': 'Extra',
              'price': 699.0,
            },
            {
              'store': 'Amazon',
              'price': 799.0,
            },
          ],
        ),
        Product(
          name: 'Shampoo',
          price: 5.0,
          imageUrl: './lib/images/shampoo.jpg',
          category: 'beauty',
          rating: 3.5,
          priceAcrossStores: [
            {
              'store': 'Panda',
              'price': 5.95,
            },
            {
              'store': 'Carrefour',
              'price': 9.99,
            },
            {
              'store': 'Amazon',
              'price': 10.0,
            },
          ],
        ),
        Product(
          name: 'Conditioner',
          price: 5.0,
          imageUrl: './lib/images/conditioner.jpg',
          category: 'beauty',
          rating: 3.5,
          priceAcrossStores: [
            {
              'store': 'Panda',
              'price': 5.95,
            },
            {
              'store': 'Carrefour',
              'price': 9.99,
            },
            {
              'store': 'Amazon',
              'price': 10.0,
            },
          ],
        ),
        Product(
          name: 'Baby Shampoo',
          price: 12.0,
          imageUrl: './lib/images/baby_shampoo.jpg',
          category: 'beauty',
          rating: 2.5,
          priceAcrossStores: [
            {
              'store': 'Panda',
              'price': 16.95,
            },
            {
              'store': 'Ibn Dawood',
              'price': 18.99,
            },
            {
              'store': 'Amazon',
              'price': 15.95,
            },
          ],
        ),
        Product(
          name: 'Pen',
          price: 1.0,
          imageUrl: './lib/images/pen.jpg',
          category: 'School Supplies',
          rating: 4.5,
          priceAcrossStores: [
            {
              'store': 'Panda',
              'price': 1,
            },
            {
              'store': 'Ibn Dawood',
              'price': 1.5,
            },
            {
              'store': 'Amazon',
              'price': 1.99,
            },
          ],
        ),
        Product(
          name: 'Pencil',
          price: 1.0,
          imageUrl: './lib/images/pencil.jpg',
          category: 'School Supplies',
          rating: 4.5,
          priceAcrossStores: [
            {
              'store': 'Panda',
              'price': 1,
            },
            {
              'store': 'Ibn Dawood',
              'price': 1.5,
            },
            {
              'store': 'Amazon',
              'price': 1.99,
            },
          ],
        ),
        Product(
          name: 'Eraser',
          price: 1.0,
          imageUrl: './lib/images/eraser.jpg',
          category: 'School Supplies',
          rating: 4.5,
          priceAcrossStores: [
            {
              'store': 'Panda',
              'price': 1,
            },
            {
              'store': 'Ibn Dawood',
              'price': 1.5,
            },
            {
              'store': 'Amazon',
              'price': 1.99,
            },
          ],
        ),
        Product(
          name: 'Ruler',
          price: 1.0,
          imageUrl: './lib/images/ruler.jpg',
          category: 'School Supplies',
          rating: 4.5,
          priceAcrossStores: [
            {
              'store': 'Panda',
              'price': 1,
            },
            {
              'store': 'Ibn Dawood',
              'price': 1.5,
            },
            {
              'store': 'Amazon',
              'price': 1.99,
            },
          ],
        ),
      ];
}

final cartProvider = StateNotifierProvider<CartList, List<CartItem>>((ref) {
  return CartList();
});

class CartItem {
  final Product product;
  late int quantity;
  final double price;
  final String store;

  CartItem({
    required this.product,
    required this.quantity,
    required this.price,
    required this.store,
  });
}

class CartList extends StateNotifier<List<CartItem>> {
  CartList() : super([]);

  void add(CartItem cartItem) {
    state = [
      ...state,
      cartItem,
    ];
  }

  void remove(CartItem product) {
    if (state
            .where((element) => element.product.name == product.product.name)
            .first
            .quantity ==
        1) {
      state = state
          .where((cartProduct) => cartProduct.product != product.product)
          .toList();
    } else {
      state
          .where((element) => element.product.name == product.product.name)
          .first
          .quantity--;
    }
    state = state.toList();
    // state = state
    //     .where((cartProduct) => cartProduct.product != product.product)
    //     .toList();
  }
}

final favProvider = StateNotifierProvider<Favorites, List<Product>>((ref) {
  return Favorites();
});

class Favorites extends StateNotifier<List<Product>> {
  Favorites() : super([]);

  void add(Product product) {
    state = [
      ...state,
      product,
    ];
  }

  void remove(Product product) {
    state =
        state.where((favProduct) => favProduct.name != product.name).toList();
  }
}
