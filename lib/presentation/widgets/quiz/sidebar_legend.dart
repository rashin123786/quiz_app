import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class SidebarLegend extends StatelessWidget {
  const SidebarLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AppColors.border, height: 24),
        _LegendItem(color: AppColors.primary, label: 'Current'),
        const SizedBox(height: 6),
        _LegendItem(color: AppColors.primaryLight, label: 'Answered',
            textColor: AppColors.primary),
        const SizedBox(height: 6),
        _LegendItem(color: AppColors.surface, label: 'Not answered',
            textColor: AppColors.text2),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final Color textColor;

  const _LegendItem({
    required this.color,
    required this.label,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.border),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: context.rfs(12),
            color: AppColors.text2,
          ),
        ),
      ],
    );
  }
}
