import 'package:flutter/material.dart';
import '../../screens/selected_item_screen.dart';

class SimpleDialogItem extends StatelessWidget {
  final String iconPath;
  final String label;

  const SimpleDialogItem(this.iconPath, this.label, {Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => SelectedItemScreen(label: label)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 30,
              height: 30,
              color: const Color(0xFF4B4B4D),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Color(0xFFA1A1A1)),
            ),
          ],
        ),
      ),
    );
  }
}
