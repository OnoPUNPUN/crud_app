import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void productDialogue() {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.orange, size: 28),
              const SizedBox(width: 10),
              const Text(
                "Add Product",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  controller: productNameController,
                  label: "Product Name",
                  icon: Icons.edit,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: productQtyController,
                  label: "Quantity",
                  icon: Icons.numbers,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: productImageController,
                  label: "Image URL",
                  icon: Icons.image,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: productUnitPriceController,
                  label: "Unit Price",
                  icon: Icons.attach_money,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: productTotalPriceController,
                  label: "Total Price",
                  icon: Icons.calculate,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.orange),
        labelText: label,
        focusColor: Colors.orange,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.orange.shade50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text(
          'Product CRUD',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        backgroundColor: Colors.orange,
        elevation: 4,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: productDialogue,
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add Product",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag,
                size: 100,
                color: Colors.orange.shade200,
              ),
              const SizedBox(height: 16),
              const Text(
                "No products yet!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Tap the + button to add your first product.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
