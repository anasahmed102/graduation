import 'package:flutter/material.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';

class PropertyTypeRadioButton extends StatefulWidget {
  final int index;
  final String text;
  final ValueChanged<int> onChanged;

  const PropertyTypeRadioButton({
    Key? key,
    required this.index,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PropertyTypeRadioButtonState createState() =>
      _PropertyTypeRadioButtonState();
}

class _PropertyTypeRadioButtonState extends State<PropertyTypeRadioButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          widget.onChanged(widget.index);
        },
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: isSelected ? 0 : 1,
              right: isSelected ? 0 : 1,
              top: isSelected ? 0 : 1,
              bottom: isSelected ? 0 : 1,
              onEnd: () {},
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: isSelected ? AppTheme.primaryColor : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
