import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final double price;
  final String category;
  final bool inStock;
  final VoidCallback onDelete;

  const ProductTile({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.inStock,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (inStock) {
      backgroundColor = Colors.green[100]!;
    } else {
      backgroundColor = Colors.red[100]!;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Price: $price Tk | Category: $category'),
            ],
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}