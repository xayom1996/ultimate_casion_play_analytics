import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<TextInputFormatter>? textInputFormatters;
  final TextInputType? keyboardType;
  final bool? isDatePicker;
  final Function()? onTap;
  final Widget? suffixIcon;

  const CustomTextField(
      {Key? key, required this.hintText,
        required this.controller,
        this.keyboardType,
        this.isDatePicker = false,
        this.onTap,
        this.suffixIcon,
        this.textInputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppTextStyles.font16.copyWith(
        fontWeight: FontWeight.w500,
      ),
      keyboardType: keyboardType,
      inputFormatters: textInputFormatters,
      onTap: () {
        if (isDatePicker == true) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) =>
                Container(
                  height: 216,
                  padding: const EdgeInsets.only(top: 6.0),
                  // The Bottom margin is provided to align the popup above the system
                  // navigation bar.
                  margin: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom,
                  ),
                  // Provide a background color for the popup.
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  // Use a SafeArea widget to avoid system overlaps.
                  child: SafeArea(
                    top: false,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      maximumDate: DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime newDate) {
                        controller.text =
                            DateFormat('dd.MM.yyyy').format(newDate);
                      },
                    ),
                  ),
                ),
          );
        }
        else if (onTap != null){
          onTap!();
        }
      },
      readOnly: isDatePicker == true || onTap != null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText,
        hintStyle: AppTextStyles.font16.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.gray,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
