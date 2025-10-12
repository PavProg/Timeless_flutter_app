import 'package:flutter/material.dart';
import 'dialog_widget.dart';
import '';

class DialogMenu {
  static void showFullWidthTopDialog(BuildContext context, List<SimpleDialogItem> items) {
    final width = MediaQuery.of(context).size.width;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.47),
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Container(
              width: width,
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
                ]
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10), // внутренние отступы сверху и снизу
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // высота по содержимому
                    crossAxisAlignment: CrossAxisAlignment.start,
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
            position: Tween<Offset>(
              begin: const Offset(0, -0.12),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
            child: child,
          ),
        );
      },
    );
  }
}