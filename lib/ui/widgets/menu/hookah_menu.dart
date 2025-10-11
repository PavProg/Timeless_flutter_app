import 'package:flutter/material.dart';

class HookahMenu {
  static void showSubMenu(BuildContext context, RelativeRect position) {
    showMenu<String>(
      context: context,
      position: position,
      color: const Color(0xFF29292A),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      items: _buildHookahMenuItems(),
    ).then((selectedValue) {
      if (selectedValue != null) {
        _handleHookahSelection(context, selectedValue);
      }
    });
  }

  static List<PopupMenuEntry<String>> _buildHookahMenuItems() {
    return [
      _createMenuItem('smak_sultana', 'Cocoaloco.png', 'ООО "СМАК-СУЛТАНА"'),
      const PopupMenuDivider(height: 1),
      _createMenuItem('big_smoke', 'tongsIcon.png', 'ООО "БИГ-СМОК"'),
      const PopupMenuDivider(height: 1),
      _createMenuItem('ip_gurkov', 'limonIcon.png', 'ИП Гурков'),
    ];
  }
  
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
          )
        ],
      ),
    );
  }

  static void _handleHookahSelection(BuildContext context, String value) {
    switch (value) {
      case 'smak_sultana':
        print('Choice: smak-sultana');
        break;
      case 'big_smoke':
        print('Choice: big_smoke');
        break;
      case 'ip_gurkov':
        print('Choice: ip_gurkov');
        break;
      default:
        print('unknown chioce');
    }
  }
}