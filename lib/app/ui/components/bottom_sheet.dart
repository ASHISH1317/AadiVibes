import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:flutter/material.dart';

/// Dashboard Bottom Sheet Widget
class DashBoardBottomSheet extends StatelessWidget {
  /// Dashboard Bottom Sheet Widget
  const DashBoardBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: AppColors.kffffff,
        ),
      );
}
