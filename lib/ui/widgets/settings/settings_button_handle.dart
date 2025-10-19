import 'package:flutter/material.dart';

class DialogSettingMenu extends StatefulWidget {
  const DialogSettingMenu({Key? key}) : super(key: key);

  @override
  State<DialogSettingMenu> createState() => _DialogSettingMenu();
}

class _DialogSettingMenu extends State<DialogSettingMenu> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: _toggleExpansion,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF131419),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Настройки',
                  style: TextStyle(
                    color: const Color(0xFFA1A1A1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Кнопка для смены языка
              _buttonLocalization(context),

              // Кнопка для обратной связи
              _buttonFeedback(context),

              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Сменить пароль',
                  style: TextStyle(
                    color: const Color(0xFFA1A1A1),
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Версия приложения Alpha 1.0',
                  style: TextStyle(
                    color: const Color(0x80A1A1A1),
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonLocalization(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 55, left: 20, right: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2025),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              'Русский',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF4B4B4D),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonFeedback(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14, left: 20, right: 20, bottom: 30),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2025),
        border: Border.all(color: Color(0x50D07B59), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18, bottom: 18),
            child: Image.asset(
              'AppMaterial/soundIcon.png',
              width: 20,
              height: 20,
              color: Color(0xFFD07B59),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              'Обратная связь',
              style: const TextStyle(
                color: Color(0xFFD07B59),
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
