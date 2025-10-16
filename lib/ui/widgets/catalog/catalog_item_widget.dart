import 'package:flutter/material.dart';
import '../../../data/models/catalog_item_model.dart';
import 'quantity_selector.dart';
import 'weight_selector.dart';

// Главный виджет каталога

class CatalogItemWidget extends StatefulWidget {
  final CatalogItemModel item;
  final double width;
  final double collapsedHeight;

  const CatalogItemWidget({
    Key? key,
    required this.item,
    required this.width,
    required this.collapsedHeight,
  }) : super(key: key);

  @override
  State<CatalogItemWidget> createState() => _CatalogItemWidgetState();
}

class _CatalogItemWidgetState extends State<CatalogItemWidget> {
  bool isExpanded = false;
  int selectedWeightIndex = -1;   // -1 = не выбрано

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpansion,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: widget.width,
        height: isExpanded ? _getExpandedHeight() : widget.collapsedHeight,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2C),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Color(0xFF4B4B4D),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),  // Заголовок товара

                if (isExpanded) ...[
                  const SizedBox(height: 16),
                  _buildExpandedContent(),  // Содержимое в развернутом виде
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.item.name,
            style: const TextStyle(
              color: Color(0xFFA1A1A1),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        AnimatedRotation(
          turns: isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey[400],
            size: 24,
          ),
        ),
      ],
    );
  }

  // Содержимое в развернутом виде
  Widget _buildExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        WeightSelector(
          weightOptions: widget.item.weightOptions,
          selectedIndex: selectedWeightIndex,
          onWeightSelected: (index) {
            setState(() {
              selectedWeightIndex = index;
            });
          },
        ),

        if (selectedWeightIndex >= 0) ...[
          const SizedBox(height: 16),
          _buildQuantityAndCartSection(),
        ],
      ],
    );
  }

  Widget _buildQuantityAndCartSection() {
    final selectedOption = widget.item.weightOptions[selectedWeightIndex];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: QuantitySelector(
            quantity: selectedOption.quantity,
            onQuantityChanged: (newQuantity) {
              setState(() {
                selectedOption.quantity = newQuantity;
              });
            },
          ),
        ),

        const SizedBox(width: 8),

        _buildCartButton(),
      ],
    );
  }

  Widget _buildCartButton() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF4B4B4D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        'AppMaterial/cartIconsm.png',
        width: 18,
        height: 18,
        color: Colors.grey[400],
      ),
    );
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  double _getExpandedHeight() {
    double height = 0;

    // Базовая высота для заголовка и отступов
    height += 60;  // Высота заголовка с padding

    // Высота селектора граммовки
    int weightOptionsCount = widget.item.weightOptions.length;
    height += weightOptionsCount * 52; // Каждая опция занимает ~52px (padding + текст + отступ)
    height += 16; // Отступ перед селектором граммовки

    // Если выбрана граммовка, добавляем высоту для селектора количества
    if (selectedWeightIndex >= 0) {
      height += 60; // Высота для строки с кнопками +/- и корзиной
      height += 16; // Отступ перед селектором количества
    }

    // Добавляем запас на padding контейнера
    height += 32; // 16px padding сверху + 16px снизу

    return height;
  }

}