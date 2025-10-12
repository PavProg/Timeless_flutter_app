import 'package:flutter/material.dart';
import 'menu/dialog_menu_handler.dart';
import 'menu/dialog_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF29292D),
      elevation: 0,
      leading: _MenuButton(),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.settings),
        ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: ImageIcon(
        const AssetImage('AppMaterial/ContextMenu.png'),
        size: 30,
        color: Colors.grey[400],
      ),
      position: PopupMenuPosition.under,
      color: const Color(0xFF29292A),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'hookah_bar',
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Image.asset(
                'AppMaterial/Cocoaloco.png',
                width: 28,
                height: 28,
                color: const Color(0xFF4B4B4D),
              ),
              const SizedBox(width: 12),
              const Text(
                'Кальянный бар',
                style: TextStyle(
                  color: Color(0xFFA1A1A1),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(height: 1),
        PopupMenuItem<String>(
          value: 'cocktail_bar',
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Image.asset(
                'AppMaterial/wineglass.png',
                width: 28,
                height: 28,
                color: const Color(0xFF4B4B4D),
              ),
              const SizedBox(width: 12),
              const Text(
                'Коктейльный бар',
                style: TextStyle(
                  color: Color(0xFFA1A1A1),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (String value) {
        switch (value) {
          case 'hookah_bar':
            DialogMenu.showFullWidthTopDialog(context, [
              SimpleDialogItem('AppMaterial/Cocoaloco.png', 'ООО "СМАК-СУЛТАНА"'),
              SimpleDialogItem('AppMaterial/tongsIcon.png', 'ООО "БИГ-СМОК"'),
              SimpleDialogItem('AppMaterial/limonIcon.png', 'ИП Гурков'),
            ]);
          case 'cocktail_bar':
            DialogMenu.showFullWidthTopDialog(context, [
              SimpleDialogItem('AppMaterial/Cocoaloco.png', 'ООО "СМАК-СУЛТАНА"'),
              SimpleDialogItem('AppMaterial/tongsIcon.png', 'ООО "БИГ-СМОК"'),
              SimpleDialogItem('AppMaterial/limonIcon.png', 'ИП Гурков'),
            ]);

        }
      },
    );
  }
}
