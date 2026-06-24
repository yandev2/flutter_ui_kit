import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import '../controller/view_demo_ui_controller.dart';

class DemoSidebar extends StatelessWidget {
  const DemoSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewDemoUiController controller = Get.find();

    return Container(
      width: AppScale.w(260),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppScale.w(24),
              AppScale.h(32),
              AppScale.w(24),
              AppScale.h(16),
            ),
            child: Text(
              'Components',
              style: TextStyle(
                fontSize: AppScale.sp(14),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: AppScale.w(12)),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];

                return Obx(() {
                  final isSelected = controller.selectedCategoryIndex.value == index;
                  return Padding(
                    padding: EdgeInsets.only(bottom: AppScale.h(4)),
                    child: InkWell(
                      onTap: () => controller.scrollToCategory(index),
                      borderRadius: BorderRadius.circular(AppScale.r(8)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppScale.w(16),
                          vertical: AppScale.h(12),
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppScale.r(8)),
                        ),
                        child: Text(
                          category.title,
                          style: TextStyle(
                            fontSize: AppScale.sp(14),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
