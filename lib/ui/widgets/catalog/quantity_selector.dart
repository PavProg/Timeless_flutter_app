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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), // уменьшили
      decoration: BoxDecoration(
        color: const Color(0x804B4B4D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(
            iconPath: 'AppMaterial/minusIcon.png',
            onTap: () {
              if (quantity > 0) onQuantityChanged(quantity - 1);
            },
          ),
          const SizedBox(width: 4), // уменьшили
          // Фиксированная ширина для числа, чтобы избежать скачков
          SizedBox(
            width: 28,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFA1A1A1),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 4),
          _buildQuantityButton(
            iconPath: 'AppMaterial/plusIcon.png',
            onTap: () => onQuantityChanged(quantity + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({required String iconPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Image.asset(
          iconPath,
          width: 16,
          height: 16,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}