// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors/App_Colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? fontSize;
  final bool centerTitle;
  final Color? backgroundColor;
  final bool forceMaterialTransparency;
  final bool? automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? leading;
  final double? toolbarHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.fontSize,
    this.centerTitle = true,
    this.backgroundColor,
    this.forceMaterialTransparency = true,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading,
    this.toolbarHeight,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: forceMaterialTransparency,
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          fontSize: fontSize ?? 18,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading ?? GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
            size: 22,
          ),
        ),
      ),
      elevation: forceMaterialTransparency ? 0 : null,
    );
  }
}