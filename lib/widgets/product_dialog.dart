import 'package:flutter/material.dart';

class ProductDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController qtyController;
  final TextEditingController imageController;
  final TextEditingController unitPriceController;
  final TextEditingController totalPriceController;
  final Future<void> Function() onSave;

  const ProductDialog({
    super.key,
    required this.nameController,
    required this.qtyController,
    required this.imageController,
    required this.unitPriceController,
    required this.totalPriceController,
    required this.onSave,
  });

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add Product",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6D8EFF),
                  ),
                ),
                const SizedBox(height: 18),
                _buildTextField(
                  controller: widget.nameController,
                  label: "Product Name",
                  icon: Icons.edit,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: widget.qtyController,
                  label: "Quantity",
                  icon: Icons.numbers,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: widget.imageController,
                  label: "Image URL",
                  icon: Icons.image,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: widget.unitPriceController,
                  label: "Unit Price",
                  icon: Icons.attach_money,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: widget.totalPriceController,
                  label: "Total Price",
                  icon: Icons.calculate,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D8EFF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text(
                      "Save",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await widget.onSave();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF6D8EFF)),
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF6D8EFF)),
        focusColor: const Color(0xFF6D8EFF),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: const Color(0xFFF8FAFF),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }
}