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
  int SelectedWeightIndex = -1;   // -1 = не выбрано

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpansion,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: widget.width,
        height: isExpanded ? _getExpandedHeight : widget.collapsedHeight,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Widget _buildHeader() {
    return Row(

    );
  }
}