import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'no_leading_whitespace.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final String ?labelText;
  final double? labelTextFontSize;
  final FontWeight? labelTextFontWeight;
  final TextEditingController controller;
  final FormFieldValidator<String?>? validatorText;
  final InputBorder? border;
  final Widget? suffixIcon;
  final bool? readonly;
  final bool? expands;
  final int? maxLines;
  final int? minLines;
  final int? maxLenth;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextInputType? textInputType;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? inputContentPadding;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final double? borderRadius;
  final FocusNode? focusNode;
  final bool? autofocus;
  final List<TextInputFormatter>? textInputFormatter;
  bool obscureText;
  void Function(String)? onChanged;
  final Color? fillColor;
  final TextAlign? textAlign;
  final Color? cursorColor;
  final VoidCallback? onEditingComplete;

  TextFieldWidget(
      {Key? key,
        required this.hintText,
        this.expands,
        this.labelTextFontWeight,
        this.fillColor,
        required this.controller,
        this.validatorText,
        this.maxLenth,
        this.labelText,
        this.border,
        this.minLines,
        this.suffixIcon,
        this.obscureText = false,
        this.textInputType,
        this.textInputAction,
        this.onTap,
        this.textInputFormatter,
        this.prefixIcon,
        this.contentPadding,
        this.readonly,
        this.borderRadius,
        this.focusNode,
        this.autofocus,
        this.labelStyle,
        this.hintStyle,
        this.maxLines,
        this.onChanged,
        this.style,
        this.textAlign,
        this.cursorColor,
        this.onEditingComplete, this.labelTextFontSize, this.inputContentPadding})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration:  InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.black, fontSize: 14.sp,fontWeight: FontWeight.w400),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        contentPadding: widget.inputContentPadding??EdgeInsets.symmetric(vertical: 0.2.h, horizontal:6.w),
        border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(widget.borderRadius ?? 2.w),
            borderSide: BorderSide(
                color: Colors.black,
                width: 0.2.w)),
        enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(widget.borderRadius ?? 2.w),
            borderSide: BorderSide(
                color: Colors.black,
                width: 0.2.w)),
        focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(widget.borderRadius ?? 2.w),
            borderSide: BorderSide(
                color: Colors.black,
                width: 0.2.w)),
      ),
      child: TextFormField(
          onChanged: widget.onChanged,
          maxLines: widget.maxLines ?? 1,
          expands: widget.expands ?? false,
          minLines: widget.minLines,
          readOnly: widget.readonly ?? false,
          style: widget.style,
          controller: widget.controller,
          cursorColor: widget.cursorColor ?? blackColor,
          textAlign: widget.textAlign ?? TextAlign.start,

          inputFormatters:[
            ...(widget.textInputFormatter ?? []),
            // widget.isNameScreen == true
            //     ? FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
            //     : FilteringTextInputFormatter.singleLineFormatter,
            NoLeadingSpaceFormatter(),
            FilteringTextInputFormatter.deny(RegExp(r"^\s"))
          ],
          maxLength: widget.maxLenth,
          obscureText: widget.obscureText,
          autofocus: widget.autofocus ?? false,
          focusNode: widget.focusNode,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validatorText,
          keyboardType: widget.textInputType ?? TextInputType.visiblePassword,
          onTap: widget.onTap,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            errorMaxLines: 2,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: widget.contentPadding,
            hintText: widget.hintText,
            border: InputBorder.none,
            prefixIcon:widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            hintStyle: widget.hintStyle,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,)
      ),
    );
  }
}
