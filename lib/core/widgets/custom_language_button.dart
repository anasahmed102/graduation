import 'package:flutter/material.dart';

class CustomLanguageButton extends StatelessWidget {
  final IconData leadingIcon;
  final Widget trailingWidget; // Change this to a Widget
  final String buttonText;

  const CustomLanguageButton({
    Key? key,
    required this.leadingIcon,
    required this.trailingWidget,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(leadingIcon, size: 32),
              const SizedBox(
                width: 12,
              ),
              Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          trailingWidget,
        ],
      ),
    );
  }
}
