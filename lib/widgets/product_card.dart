import 'package:flutter/material.dart';

import '../Models/product_model.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Data productData;

  const ProductCard({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            child: Image.network(
              "https://m.media-amazon.com/images/I/917IJDfk36L._SL1500_.jpg",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  productData.productName.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Text(
                  'Price: ${productData.unitPrice.toString()} || QTY: ${productData.qty.toString()}',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: Icon(Icons.edit, color: Colors.orange),
                    ),
                    const SizedBox(width: 5, child: VerticalDivider(width: 10)),
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
