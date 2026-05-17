import 'package:bdappsclass2/productTile_widget.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> products = [];

  void addProduct() {
    final String name = nameController.text.trim();
    final double price = double.tryParse(priceController.text.trim()) ?? 0.0;
    final String category = categoryController.text.trim();

    if (name.isEmpty) {
      return;
    }

    final Map<String, dynamic> product = {
      'name': name,
      'price': price,
      'category': category,
      'inStock': price > 0.0,
    };

    setState(() {
      products.add(product);
      nameController.clear();
      priceController.clear();
      categoryController.clear();
    });
  }

  void removeProduct(String name) {
    setState(() {
      products.removeWhere(
            (product) =>
        product['name'].toString().toLowerCase() == name.toLowerCase(),
      );
    });
  }

  void sortProducts() {
    setState(() {
      products.sort(
            (a, b) => a['name'].toString().compareTo(
          b['name'].toString(),
        ),
      );
    });
  }

  List<Map<String, dynamic>> get searchedProducts {
    final String query = searchController.text.trim().toLowerCase();

    return products.where((product) {
      return product['name'].toString().toLowerCase().contains(query);
    }).toList();
  }

  double get totalInventoryValue {
    double total = 0.0;
    for (int i = 0; i < products.length; i++) {
      total += products[i]['price'];
    }
    return total;
  }

  List<String> get inStockProducts {
    return [
      for (final product in products)
        if (product['inStock'] == true) product['name'].toString(),
    ];
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    categoryController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> visibleProducts = searchedProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E-Commerce Manager',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price (Taka)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addProduct,
                    child: const Text('Add'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: sortProducts,
                    child: const Text('Sort'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: searchController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Search Product',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text('Total Inventory Value: ${totalInventoryValue.toStringAsFixed(2)} Tk'),
            const SizedBox(height: 8),
            Text('In Stock: ${inStockProducts.join(', ')}'),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleProducts.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> product = visibleProducts[index];
                return ProductTile(
                  name: product['name'].toString(),
                  price: product['price'],
                  category: product['category'].toString(),
                  inStock: product['inStock'],
                  onDelete: () => removeProduct(product['name'].toString()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}