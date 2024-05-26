import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelected;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!isSelected),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          border: isSelected
              ? Border.all(color: Color(0XFF3737))
              : Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
