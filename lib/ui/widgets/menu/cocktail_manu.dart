import 'package:flutter/material.dart';

class CocktailMenu {
  // Показать подменю коктейльного бара
  static void showSubMenu(BuildContext context, RelativeRect position) {
    showMenu<String>(
      context: context,
      position: position,
      color: const Color(0xFF29292A),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      items: _buildCocktailMenuItems(),
    ).then((selectedValue) {
      if (selectedValue != null) {
        _handleCocktailSelection(context, selectedValue);
      }
    });
  }

  // Строим пункты меню коктейльного бара
  static List<PopupMenuEntry<String>> _buildCocktailMenuItems() {
    return [
      _createMenuItem('cocktail_alcoholic', 'wineglass.png', 'Алкогольные коктейли'),
      const PopupMenuDivider(height: 1),
      _createMenuItem('cocktail_nonalcoholic', 'wineglass.png', 'Безалкогольные коктейли'),
      const PopupMenuDivider(height: 1),
      _createMenuItem('cocktail_signature', 'wineglass.png', 'Авторские коктейли'),
    ];
  }

  // Создаем отдельный пункт меню
  static PopupMenuItem<String> _createMenuItem(String value, String iconPath, String text) {
    return PopupMenuItem<String>(
      value: value,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Image.asset(
            'AppMaterial/$iconPath',
            width: 25,
            height: 25,
            color: const Color(0xFF4B4B4D),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFFA1A1A1),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // Обработка выбора в подменю коктейльного бара
  static void _handleCocktailSelection(BuildContext context, String value) {
    switch (value) {
      case 'cocktail_alcoholic':
        print('Выбраны алкогольные коктейли');
        // Здесь будет логика для алкогольных коктейлей
        break;
      case 'cocktail_nonalcoholic':
        print('Выбраны безалкогольные коктейли');
        // Здесь будет логика для безалкогольных коктейлей
        break;
      case 'cocktail_signature':
        print('Выбраны авторские коктейли');
        // Здесь будет логика для авторских коктейлей
        break;
      default:
        print('Неизвестный тип коктейля: $value');
    }
  }
}
