import 'package:flutter/material.dart';
import '../../../data/models/catalog_item_model.dart';

class WeightSelector extends StatelessWidget {
  final List<WeightOption> weightOptions;
  final int selectedIndex;
  final Function(int) onWeightSelected;

  const WeightSelector({
     Key? key,
     required this.weightOptions,
     required this.selectedIndex,
     required this.onWeightSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weightOptions.asMap().entries.map((entry) {
        int index = entry.key;
        WeightOption option = entry.value;
        bool isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onWeightSelected(index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFD07B59)
                  : const Color(0xFF4B4B4D),
              borderRadius: BorderRadius.circular(25),
              border: isSelected
                ? null
                : Border.all(color: const Color(0xFF6B6B6D)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${option.weight} кг',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFFA1A1A1),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 8),

                Flexible(
                  child: Text(
                    '${option.price.toStringAsFixed(0)} P',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFFA1A1A1),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}