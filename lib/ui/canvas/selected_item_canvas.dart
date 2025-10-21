import 'package:flutter/material.dart';
import 'package:time_multiapplication_byflutter/data/models/catalog_item_model.dart';
import '../widgets/catalog/catalog_item_widget.dart';

class SelectedItemCanvas extends StatelessWidget {

  const SelectedItemCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final testItem = CatalogItemModel(
      id: '1',
      name: 'MustHave\nStrawberry-Lychy',
      weightOptions: [
        WeightOption(weight: 100, price: 500),
        WeightOption(weight: 200, price: 1000),
        WeightOption(weight: 300, price: 1500),
      ],
    );

    return CustomPaint(
      painter: ItemCanvasPainter(), // Основной painter для фона и декора
      child: SizedBox.expand(
        // Занимаем все доступное пространство
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Пример плитки для будущих элементов из базы данных
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: CatalogItemWidget(
                item: testItem,
                width: screenWidth * 0.5,
                collapsedHeight: screenHeight / 7 - 40,
              ),
            ),
            // Здесь можно добавить ListView.builder для элементов из базы данных:
            // ListView.builder(
            //   itemCount: catalogItems.length,
            //   itemBuilder: (context, index) {
            //     return CatalogItemWidget(
            //       item: catalogItems[index],
            //       width: screenWidth / 2 - 20,
            //       collapsedHeight: screenHeight / 7 - 40,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

// Painter для основного фона экрана
class ItemCanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Основной фон
    final backgroundPaint = Paint()..color = const Color(0xFF212226);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    // Можно добавить декоративные элементы, паттерны, градиенты
    /*final decorPaint = Paint()
      ..color = const Color(0xFF2A2A2C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;*/

    // Пример: сетка в фоне
    /* for (double i = 0; i < size.width; i += 50) {
        canvas.drawLine(Offset(i, 0), Offset(i, size.height), decorPaint);
    } */
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter для отдельных плиток элементов
class ItemTilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Фон плитки
    final tilePaint = Paint()..color = const Color(0xFF2A2A2C);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      tilePaint,
    );

    // Рамка плитки
    final borderPaint = Paint()
      ..color = const Color(0xFF4B4B4D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
