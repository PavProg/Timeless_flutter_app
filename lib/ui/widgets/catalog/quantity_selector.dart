import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildQuantityButton(
          iconPath: 'AppMaterial/minusIcon.png',
          onTap: () {
            if (quantity > 0) {
              onQuantityChanged(quantity - 1);
            }
          },
        ),

        const SizedBox(width: 8),    // Промежуток между - и количеством

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF4B4B4D),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            quantity.toString(),
            style: const TextStyle(
              color: Color(0xFFA1A1A1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 8),

        _buildQuantityButton(
          iconPath: 'AppMaterial/plusIcon.png',
          onTap: () {
            onQuantityChanged(quantity + 1);
          },
        ),
      ],
    );
  }

  Widget _buildQuantityButton({required String iconPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFF4B4B4D),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Image.asset(
          iconPath,
          width: 18,
          height: 18,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}