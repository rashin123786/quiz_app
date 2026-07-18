import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/responsive.dart';

import '../../../core/theme/app_theme.dart';

class ScoreCircle extends StatelessWidget {
  final int score;
  final int total;
  final int percent;

  const ScoreCircle({
    super.key,
    required this.score,
    required this.total,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final isPassed = percent >= 60;
    final color = isPassed ? AppColors.correct : AppColors.incorrect;

    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              value: percent / 100,
              strokeWidth: 10,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(color),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$percent%',
                style: TextStyle(
                  fontSize: context.rfs(32),
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                '$score / $total',
                style: TextStyle(
                  fontSize: context.rfs(14),
                  color: AppColors.text2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
