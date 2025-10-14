import 'package:flutter/material.dart';

class CartCanvas extends StatelessWidget {
  const CartCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CartCanvasPainter(),
      child: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    // Пространство для будующих товаров
                    
                    Expanded(child: Container()), //Пустое пространство

                    //Нижняя секция с итогами и кнопкой
                    _buildBottomSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildBottomSection() {
    double tobaccoMass = 0; // кг табака
    double balanceAmount = 0.0; // сумма из сальдовой в рублях
    double totalAmount = 0.0; // общая сумма в рублях

    double percentageDifference = 0.0;
    if (balanceAmount > 0) {
      percentageDifference = ((totalAmount - balanceAmount) / balanceAmount) * 100;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoRow('Масса табака', '${tobaccoMass.toStringAsFixed(0)} кг'),
          const SizedBox(height: 12),

          _buildInfoRow('Сумма из сальдовой', '${_formatCurrency(balanceAmount)} ₽'),
          const SizedBox(height: 12),

          _buildInfoRow('Всего', '${_formatCurrency(totalAmount)} ₽', isTotal: true),
          const SizedBox(height: 12),

          _buildInfoRow('Разница по сальдовой', '${percentageDifference.toStringAsFixed(0)}%'),
          const SizedBox(height: 24),

          _buildOrderButton(),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    String formatted = amount.toStringAsFixed(0);
    if (formatted.length > 3) {
      String result = '';
      int counter = 0;

      for (int i = formatted.length - 1; i >= 0; i--) {
        if (counter == 3) {
          result = ' ' + result; // Добавляем пробел каждые 3 цифры
          counter = 0;
        }
        result = formatted[i] + result;
        counter++;
      }
      return result;
    }
    return formatted;
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false, bool isPercentage = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFA1A1A1),
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isPercentage ? Color(0xFFFF4444) :
            (isTotal ? Color(0xFFFF4444) : Color(0xFFA1A1A1)),
          fontSize: 16,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderButton() {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          //Пока без функции
          print('Button makeOrder pressed');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1F2025),
          foregroundColor: Color(0xFFD07B59),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 3,
        ),
        child: Text(
          'Заказать',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CartCanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = const Color(0xFF131419);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    //Здесь можно добавить декор в корзину
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false; // Не перерисовываем без изменений
}