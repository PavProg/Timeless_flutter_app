import 'package:flutter/material.dart';
import 'dialog_widget.dart';

class DialogMenu {
  static void showFullWidthTopDialog(BuildContext context, List<SimpleDialogItem> items) {
    final width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
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
      }
    );
  }
}