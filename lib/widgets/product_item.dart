import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  // const ProductItem({
  //   super.key,
  //   required this.id,
  //   required this.imageUrl,
  //   required this.title,
  // });
  //
  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(19),
      child: GridTile(
        footer: GridTileBar(
            trailing: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                    'Added item to cart',
                    textAlign: TextAlign.center,
                  ),
                  action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      }),
                  duration: const Duration(
                    seconds: 5,
                  ),
                ));
                cart.addItem(product.id, product.price, product.title);
              },
              icon: const Icon(Icons.shopping_bag),
              color: Theme.of(context).colorScheme.secondary,
            ),
            leading: IconButton(
              onPressed: () {
                product.togglefavoritestatus();
              },
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
            backgroundColor: Colors.black54,
            subtitle: Text('\$${product.price}'),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            )),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
