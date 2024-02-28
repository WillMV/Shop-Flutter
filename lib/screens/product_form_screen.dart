import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/widget/app_drawer.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});
  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final imageUrlController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  String imageUrl = '';

  bool isUpdating = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context, listen: false);

    final product = ModalRoute.of(context)?.settings.arguments as Product?;

    final bool hasProduct = product != null;

    if (hasProduct) {
      imageUrlController.text = product.imageUrl;
      _formData['id'] = product.id;
      imageUrl = product.imageUrl;
      isUpdating = true;
    }

    void onSubmit() async {
      bool isValidate = _formkey.currentState!.validate();

      if (isValidate) {
        _formkey.currentState?.save();

        setState(() {
          isLoading = true;
        });

        provider.saveItem(_formData).catchError((error) {
          return showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error!!!'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok ;-;'))
              ],
            ),
          );
        }).then((value) {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        });
      }
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Product form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  initialValue: hasProduct ? product.title : null,
                  onSaved: (name) => _formData['title'] = (name ?? ''),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'The name field must be filled.';
                    }
                    if (value.length < 3) {
                      return 'The name must have at least 3 characters.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onSaved: (price) => _formData['price'] = double.parse(
                      price!.trim().isNotEmpty
                          ? price.replaceFirst(',', '.')
                          : '0'),
                  initialValue: hasProduct ? (product.price.toString()) : null,
                  validator: (value) {
                    final price = value!.replaceFirst(',', '.');
                    if (price.trim().isEmpty) {
                      return 'The price field must be filled.';
                    }
                    if (double.tryParse(price) == null) {
                      return "The price must be a valid number.";
                    }
                    if (double.parse(price) <= 0) {
                      return "The price must be greater than zero.";
                    }
                    return null;
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    label: Text('Price'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onSaved: (description) =>
                      _formData['description'] = (description ?? ''),
                  maxLines: 3,
                  initialValue: hasProduct ? product.description : null,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'The description field must be filled.';
                    }

                    if (value.length < 10) {
                      return 'The name must have at least 10 characters.';
                    }

                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: imageUrlController,
                        onSaved: (imageUrl) =>
                            _formData['imageUrl'] = (imageUrl ?? ''),
                        keyboardType: TextInputType.url,
                        validator: (value) {
                          String urlImage = value ?? '';
                          bool isValidUrl =
                              Uri.tryParse(urlImage)!.hasAbsolutePath;

                          if (urlImage.trim().isEmpty) {
                            return 'The url field must be filled.';
                          }
                          if (!isValidUrl) {
                            return 'Please provide a valid URL.';
                          }
                          return null;
                        },
                        onChanged: (value) => setState(() {
                          imageUrl = value;
                        }),
                        decoration: const InputDecoration(
                          label: Text('Image URL'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: imageUrl.isEmpty
                            ? null
                            : Image.network(
                                imageUrl,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Text('Insira um link'),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => onSubmit(),
                child: Text(isUpdating ? 'Update' : 'Submit'),
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
