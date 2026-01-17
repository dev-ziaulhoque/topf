import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors/App_Colors.dart';
import '../common_widget/custom_button.dart';
import '../common_widget/custom_text.dart';
import '../common_widget/lottie_loader.dart';

class CustomPaymentSuccessDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonTap;
  final String lottieAsset;
  final Color successColor;
  final bool autoDismiss;
  final int autoDismissSeconds;

  const CustomPaymentSuccessDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonTap,
    required this.lottieAsset,
    this.successColor = Colors.green,
    this.autoDismiss = false,
    this.autoDismissSeconds = 3,
  });

  @override
  Widget build(BuildContext context) {
    if (autoDismiss) {
      Future.delayed(Duration(seconds: autoDismissSeconds), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      });
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie animation
            LottieLoaderWidget(
                lottieAssetPath: lottieAsset,
                height: 150,
              overlayColor: AppColors.primaryColor,
            ),
            SizedBox(height: 16),
            // Title
            CustomText(
              title: title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: successColor,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            // Subtitle
            CustomText(
              title: subtitle,
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Button
            CustomButton(
              title: buttonText,
              onTap: onButtonTap,
            ),
          ],
        ),
      ),
    );
  }
}
