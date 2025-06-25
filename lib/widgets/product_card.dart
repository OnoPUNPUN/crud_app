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
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  productData.img.toString(),
                  height: 90,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 90,
                    color: Colors.orange.shade50,
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.orange,
                      size: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                productData.productName ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.orange.shade900,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Price: ${productData.unitPrice ?? "-"} | Qty: ${productData.qty ?? "-"}',
                style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit, color: Colors.orange.shade800),
                  ),
                  SizedBox(width: 4),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
