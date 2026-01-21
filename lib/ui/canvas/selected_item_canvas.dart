import 'package:flutter/material.dart';
import 'package:time_multiapplication_byflutter/data/models/catalog_item_model.dart';
import 'package:time_multiapplication_byflutter/data/services/api_service.dart';
import '../widgets/catalog/catalog_item_widget.dart';

class SelectedItemCanvas extends StatefulWidget {
  const SelectedItemCanvas({Key? key}) : super(key: key);

  @override
  State<SelectedItemCanvas> createState() => _SelectedItemCanvasState();
}

class _SelectedItemCanvasState extends State<SelectedItemCanvas> {
  late Future<List<CatalogItemModel>> _catalogFuture;
  final ApiService _apiService = ApiService();
  List<CatalogItemModel> _catalogItems = [];

  @override
  void initState() {
    super.initState();
    _loadCatalog();
  }
  // Загрузка каталога
  void _loadCatalog() {
    setState(() {
      _catalogFuture = _apiService.getProducts();
    });
  }
  // Обновление товара в списке
  void _updateItemInList(CatalogItemModel updatedItem) {
    setState(() {
      final index = _catalogItems.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        _catalogItems[index] = updatedItem;
      }
    });
  }
  // Метод для проверки обновлений
  @override
  void didUpdateWidget(SelectedItemCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Логика при обновлении виджета
  }

  Widget _buildCanvasContent(List<CatalogItemModel> items, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return CustomPaint(
      painter: ItemCanvasPainter(),
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок секции
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                child: Text(
                  'Каталог товаров',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jura',
                  ),
                ),
              ),

              // Список товаров
              ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: CatalogItemWidget(
                  item: item,
                  width: screenWidth * 0.5,
                  collapsedHeight: screenHeight / 7 - 40,
                  onItemUpdated: _updateItemInList,
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CatalogItemModel>>(
      future: _catalogFuture,
      builder: (context, snapshot) {
        // Состояние загрузки
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        // Состояние ошибки
        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error.toString());
        }

        // Успешная загрузка
        final items = snapshot.data ?? [];
        _catalogItems = items; // Сохраняем для обновлений

        if (items.isEmpty) {
          return _buildEmptyState();
        }

        return _buildCanvasContent(items, context);
      },
    );
  }

  Widget _buildLoadingState() {
    return CustomPaint(
      painter: ItemCanvasPainter(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF4B4B4D),
            ),
            SizedBox(height: 20),
            Text(
              'Загрузка каталога...',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return CustomPaint(
      painter: ItemCanvasPainter(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 50,
              ),
              SizedBox(height: 20),
              Text(
                'Не удалось загрузить каталог',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadCatalog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B4B4D),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Повторить',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return CustomPaint(
      painter: ItemCanvasPainter(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              color: Color(0xFF4B4B4D),
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              'Каталог пуст',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Добавьте товары через админ-панель',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}

// Painter для фона (без изменений)
class ItemCanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = const Color(0xFF212226);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}