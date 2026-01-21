import 'package:flutter/material.dart';
import 'package:time_multiapplication_byflutter/data/services/api_service.dart';
import '../../../data/models/catalog_item_model.dart';
import 'quantity_selector.dart';
import 'weight_selector.dart';

// Главный виджет каталога

class CatalogItemWidget extends StatefulWidget {
  final CatalogItemModel item;
  final double width;
  final double collapsedHeight;
  final Function(CatalogItemModel)? onItemUpdated;

  const CatalogItemWidget({
    Key? key,
    required this.item,
    required this.width,
    required this.collapsedHeight,
    this.onItemUpdated,
  }) : super(key: key);

  @override
  State<CatalogItemWidget> createState() => _CatalogItemWidgetState();
}

class _CatalogItemWidgetState extends State<CatalogItemWidget> {
  bool isExpanded = false;
  int selectedWeightIndex = -1;   // -1 = не выбрано
  bool _isUpdating = false;
  late CatalogItemModel _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.item;
  }

  @override
  void didUpdateWidget(CatalogItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.id != widget.item.id) {
      setState(() {
        _currentItem = widget.item;
      });
    }
  }

  Future<void> _updateQuantityOnServer(int newQuantity) async {
    if (_isUpdating || selectedWeightIndex < 0) return;
    final selectedOption = _currentItem.weightOptions[selectedWeightIndex];

    setState(() {
      _isUpdating = true;
    });

    try {
      final ApiService apiService = ApiService();
      final updatedItem = await apiService.updateQuantity(
        productId: _currentItem.id,
        weight: selectedOption.weight,
        newQuantity: newQuantity,
      );

      setState(() {
        _currentItem = updatedItem;
      });

      if (widget.onItemUpdated != null) {
        widget.onItemUpdated!(updatedItem);
      }

      // Показываем подтверждение
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Количество обновлено'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

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
          boxShadow: [
            BoxShadow(
              color: Color(0x40A1A1A1),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            _currentItem.name,
            style: const TextStyle(
              color: Color(0xFFA1A1A1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
          weightOptions: _currentItem.weightOptions,
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
    final selectedOption = _currentItem.weightOptions[selectedWeightIndex];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: QuantitySelector(
            quantity: selectedOption.quantity,
            onQuantityChanged: (newQuantity) async {
              await _updateQuantityOnServer(newQuantity);
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0x804B4B4D),
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
    int weightOptionsCount = _currentItem.weightOptions.length;
    height += weightOptionsCount * 52; // Каждая опция занимает ~52px (padding + текст + отступ)
    height += 16; // Отступ перед селектором граммовки

    // Если выбрана граммовка, добавляем высоту для селектора количества
    if (selectedWeightIndex >= 0) {
      height += 50; // Высота для строки с кнопками +/- и корзиной
    }
    return height;
  }

}