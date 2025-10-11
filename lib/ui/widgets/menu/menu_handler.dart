import 'package:flutter/material.dart';
import 'hookah_menu.dart';
import 'cocktail_manu.dart';

class MenuHandler {
  static void handleMainMenuSelection(BuildContext context, String value) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    switch (value) {
      case 'hookah_bar':
        HookahMenu.showSubMenu(context, position);
        break;
      case 'cocktail_bar':
        CocktailMenu.showSubMenu(context, position);
        break;
      default:
        print('Неизвестный пункт меню: $value');
    }
  }
}