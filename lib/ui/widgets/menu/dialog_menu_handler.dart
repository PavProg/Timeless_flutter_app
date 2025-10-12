import 'package:flutter/material.dart';
import 'dialog_widget.dart';
import '../../screens/selected_item_screen.dart';

class DialogMenu {
  static void showFullWidthTopDialog(
    BuildContext context,
    List<SimpleDialogItem> items,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.47),
      transitionDuration: const Duration(milliseconds: 260),

      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
            child: Container(
              width: screenWidth,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF4B4B4D),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ), // внутренние отступы сверху и снизу
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // высота по содержимому
                    children: items,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, -0.12),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic),
                ),
            child: child,
          ),
        );
      },
    );
  }
}
