import 'package:flutter/material.dart';
import 'package:jogging_app/constant/spaces.dart';
import 'package:jogging_app/constant/text_style.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    this.onConfirmTap,
  });

  final String title;
  final VoidCallback? onConfirmTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppStyles.caption12Semibold(),
            ),
            kVerticalSpace16,
            Row(
              children: [
                kHorizontalSpace16,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: Colors.lightBlue)),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: AppStyles.button01(
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                kHorizontalSpace16,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (onConfirmTap != null) {
                        onConfirmTap!();
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.lightBlue,
                      ),
                      child: Center(
                        child: Text(
                          "Delete",
                          style: AppStyles.button01(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                kHorizontalSpace16,
              ],
            )
          ],
        ),
      ),
    );
  }
}
