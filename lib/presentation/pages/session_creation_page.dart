import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/custom_text_field.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/default_adding_page.dart';

class SessionCreationPage extends StatelessWidget {
  const SessionCreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAddingPage(
      title: 'Session creation',
      onConfirm: () {

      },
      widgets: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Date',
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Casino',
                  style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Casino Royal',
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Balance',
                  style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: '\$1000',
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
