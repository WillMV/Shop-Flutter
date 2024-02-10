import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/utils/routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Column(
      children: [
        ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  product.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            title: Text(
              product.title,
              style: const TextStyle(color: Colors.black, fontFamily: 'lato'),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.productForm,
                            arguments: product);
                      },
                      icon: Icon(
                        Icons.create,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  IconButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                  'Are you sure delete this product?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      provider.deleteItem(product.id);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('yes')),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                )
                              ],
                            ),
                          ),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ))
                ],
              ),
            )),
        const Divider(color: Colors.black12),
      ],
    );
  }
}
