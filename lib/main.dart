import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_wave/cart_page.dart';
import 'package:life_wave/category_page.dart';
import 'package:life_wave/data.dart';
import 'package:life_wave/fav_page.dart';
import 'package:life_wave/home_page.dart';
import 'package:device_preview/device_preview.dart';

final container = ProviderContainer(
  overrides: [],
);
void main() {
  runApp(
    DevicePreview(
      enabled: kReleaseMode,
      builder: (context) => UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoryPage(),
    FavPage(),
    CartPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Life Wave'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () => const CartPage(),
            ),
          ],
        ),
        bottomNavigationBar: Consumer(
          builder: (context, ref, child) => NavigationBar(
            onDestinationSelected: (value) {
              _onItemTapped(value);
            },
            indicatorColor: Colors.amber,
            selectedIndex: _selectedIndex,
            destinations: <Widget>[
              const NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const NavigationDestination(
                icon: Icon(Icons.category),
                label: 'Categories ',
              ),
              NavigationDestination(
                icon: ref.watch(favProvider).length > 0
                    ? Badge(
                        label: Text('${ref.watch(favProvider).length}'),
                        child: const Icon(Icons.favorite),
                      )
                    : const Icon(Icons.favorite),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: ref.watch(cartProvider).length > 0
                    ? Badge(
                        label: Text('${ref.watch(cartProvider).length}'),
                        child: const Icon(Icons.shopping_cart),
                      )
                    : const Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
            ],
          ),
        ),
        body: ListView(children: [
          _widgetOptions.elementAt(_selectedIndex),
        ]),
      ),
    );
  }
}
