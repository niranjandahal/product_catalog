// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/product_provider.dart';
// import '../widgets/product_tile.dart';
// import 'details_screen.dart';
// import '../widgets/shimmer_product_tile.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   Provider.of<ProductProvider>(context, listen: false).fetchProducts();
//     // });
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider = Provider.of<ProductProvider>(context, listen: false);
//       if (!provider.hasLoaded) {
//         provider.fetchProducts();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductProvider>(
//       builder: (context, provider, child) {
//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: const InputDecoration(
//                   labelText: 'Search',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: provider.search,
//               ),
//             ),
//             if (provider.isLoading)
//               const Expanded(child: ShimmerList())
//             else if (provider.error != null)
//               Expanded(child: Center(child: Text(provider.error!)))
//             else if (provider.products.isEmpty)
//               const Expanded(child: Center(child: Text('No products found.')))
//             else
//               Expanded(
//                 child: RefreshIndicator(
//                   onRefresh: () => _onRefresh(provider),
//                   child: LayoutBuilder(
//                     builder: (context, constraints) {
//                       final isWide = constraints.maxWidth > 600;
//                       if (isWide) {
//                         return GridView.builder(
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 childAspectRatio: 3.5,
//                               ),
//                           itemCount: provider.products.length,
//                           itemBuilder: (context, index) {
//                             final product = provider.products[index];
//                             return ProductTile(
//                               product: product,
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailsScreen(product: product),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       } else {
//                         return ListView.builder(
//                           itemCount: provider.products.length,
//                           itemBuilder: (context, index) {
//                             final product = provider.products[index];
//                             return ProductTile(
//                               product: product,
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailsScreen(product: product),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _onRefresh(ProductProvider provider) async {
//     _searchController.clear();
//     await provider.fetchProducts();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

// class ShimmerList extends StatelessWidget {
//   const ShimmerList({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 8,
//       itemBuilder: (context, index) => const ShimmerProductTile(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_tile.dart';
import 'details_screen.dart';
import '../widgets/shimmer_product_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      if (!provider.hasLoaded) {
        provider.fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: provider.search,
              ),
            ),
            if (provider.isLoading)
              const Expanded(child: ShimmerList())
            else if (provider.error != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        provider.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (provider.products.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'No products found.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    const Text(
                      'All Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.storefront, color: Colors.blueAccent),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => _onRefresh(provider),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 600;
                        if (isWide) {
                          return GridView.builder(
                            padding: const EdgeInsets.only(top: 4),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3.5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: provider.products.length,
                            itemBuilder: (context, index) {
                              final product = provider.products[index];
                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ProductTile(
                                  product: product,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreen(product: product),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: provider.products.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final product = provider.products[index];
                              return Card(
                                margin: EdgeInsets.zero,
                                elevation: 1.5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ProductTile(
                                  product: product,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreen(product: product),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _onRefresh(ProductProvider provider) async {
    _searchController.clear();
    await provider.fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 8,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemBuilder: (context, index) => const ShimmerProductTile(),
    );
  }
}
