import 'package:crud_app/Controllers/ProductController.dart';
import 'package:flutter/material.dart';
import '../Models/product_model.dart';
import '../widgets/product_card.dart';
import '../widgets/product_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = ProductController();
  bool isLoading = true;

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productQtyController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();
  final TextEditingController productUnitPriceController =
      TextEditingController();
  final TextEditingController productTotalPriceController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    setState(() => isLoading = true);
    await productController.fetchProducts();
    setState(() => isLoading = false);
  }

  void showProductDialog({Data? initialProduct}) {
    if (initialProduct != null) {
      productNameController.text = initialProduct.productName ?? '';
      productQtyController.text = initialProduct.qty?.toString() ?? '';
      productImageController.text = initialProduct.img ?? '';
      productUnitPriceController.text =
          initialProduct.unitPrice?.toString() ?? '';
      productTotalPriceController.text =
          initialProduct.totalPrice?.toString() ?? '';
    } else {
      productNameController.clear();
      productQtyController.clear();
      productImageController.clear();
      productUnitPriceController.clear();
      productTotalPriceController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => ProductDialog(
        nameController: productNameController,
        qtyController: productQtyController,
        imageController: productImageController,
        unitPriceController: productUnitPriceController,
        totalPriceController: productTotalPriceController,
        onSave: () async {
          if (initialProduct == null) {
            // Create
            await productController.createProducts(
              productNameController.text,
              productImageController.text,
              int.parse(productQtyController.text.trim()),
              int.parse(productUnitPriceController.text.trim()),
              int.parse(productTotalPriceController.text.trim()),
            );
          } else {
            // Update
            await productController.createUpdateProducts(
              productNameController.text,
              productImageController.text,
              int.parse(productQtyController.text.trim()),
              int.parse(productUnitPriceController.text.trim()),
              int.parse(productTotalPriceController.text.trim()),
              initialProduct.sId,
              true,
            );
          }
          await productController.fetchProducts();
          setState(() {});
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA7BFE8), Color(0xFF6190E8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text(
                  'Product CRUD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                foregroundColor: Color(0xFF283E51),
                shadowColor: Colors.transparent,
                automaticallyImplyLeading: false,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF6D8EFF),
                          ),
                        )
                      : productController.products.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inbox,
                                color: Colors.blue.shade100,
                                size: 80,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "No products found!",
                                style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Tap '+' to add your first product.",
                                style: TextStyle(color: Colors.blue.shade700),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                childAspectRatio: 0.8,
                              ),
                          itemCount: productController.products.length,
                          itemBuilder: (context, index) {
                            var product = productController.products[index];
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: ProductCard(
                                key: ValueKey(product.sId),
                                onEdit: () =>
                                    showProductDialog(initialProduct: product),
                                onDelete: () {
                                  productController
                                      .deleteProducts(product.sId.toString())
                                      .then((value) async {
                                        if (value) {
                                          await productController
                                              .fetchProducts();
                                          setState(() {});
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Product Deleted'),
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Something Went Wrong',
                                              ),
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      });
                                },
                                productData: product,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showProductDialog,
        backgroundColor: const Color(0xFF6D8EFF),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add Product",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
