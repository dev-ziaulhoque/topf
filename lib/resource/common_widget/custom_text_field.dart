import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors/App_Colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final double? height;
  final double? verticalPadding;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? focusColor;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final int? maxLine;
  final TextAlign textAlign;
  final bool readOnly;
  final TextStyle? style;
  final bool obscureText;
  final String obscuringCharacter;
  final Function(String?)? onSaved;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final bool? filled;
  final Color? hintColor;
  final Color? fillColor;
  final double focusBorderRadius;
  final double focusBorderWidth;
  final String? errorText;
  final String? Function(String?)? validator;
  final bool isBorder;
  final bool? isFocus;
  final bool? enabled;

  const CustomTextField({
    super.key,
    required this.hint,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.focusColor,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.maxLine = 1,
    this.readOnly = false,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.obscuringCharacter = '•',
    this.style,
    this.onSaved,
    this.borderRadius = 8,
    this.focusBorderRadius = 8,
    this.borderColor,
    this.borderWidth = 1.0,
    this.filled = true,
    this.hintColor,
    this.fillColor,
    this.focusBorderWidth = 1.5,
    this.errorText,
    this.validator,
    this.height,
    this.verticalPadding,
    this.isBorder = true,
    this.isFocus = true, this.enabled,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscureText;

  @override
  void initState() {
    super.initState();
    _isObscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.height ??
          (widget.errorText == null
              ? MediaQuery.of(context).size.height / 16
              : MediaQuery.of(context).size.height / 10),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled: widget.filled,
          fillColor: widget.fillColor ??
              (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.black33
                  : AppColors.bgColor),
          focusedBorder: widget.isFocus == true
              ? OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.focusColor ?? AppColors.primaryColor,
              width: widget.focusBorderWidth,
            ),
            borderRadius: BorderRadius.circular(widget.focusBorderRadius),
          )
              : null,
          border: OutlineInputBorder(
            borderSide: widget.isBorder == false
                ? BorderSide.none
                : BorderSide(
              width: widget.borderWidth,
              color: widget.borderColor ?? AppColors.black100,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          hintText: widget.hint,
          hintStyle: GoogleFonts.poppins(
            color: widget.hintColor ?? AppColors.black100,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _isObscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.blackColor,
            ),
            onPressed: _togglePasswordVisibility,
          )
              : widget.suffixIcon,
          errorText: widget.errorText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: widget.verticalPadding ?? 0,
          ),
        ),
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLine,
        textAlign: widget.textAlign,
        readOnly: widget.readOnly,
        style: widget.style ??
            GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 14,
            ),
        obscureText: _isObscureText,
        obscuringCharacter: widget.obscuringCharacter,
        onSaved: widget.onSaved,
        validator: widget.validator,
        enabled: widget.enabled,
      ),
    );
  }
}