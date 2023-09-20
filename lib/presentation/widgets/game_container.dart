import 'dart:typed_data';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';

class GameContainer extends StatelessWidget {
  final String title;
  final double profit;
  final int time;
  final List<int> imageBytes;

  const GameContainer(
      {Key? key,
      required this.title,
      required this.profit,
      required this.imageBytes,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 14),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 57,
            width: 57,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(57)),
              color: const Color(0xffF4F4F4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(57.0),
              child: Image.memory(
                Uint8List.fromList(imageBytes),
                fit: BoxFit.cover,
                gaplessPlayback: true,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: AppTextStyles.font16.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: AppColors.gray,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    printDuration(Duration(seconds: time)),
                    style: AppTextStyles.font12.copyWith(
                      color: AppColors.gray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                '${profit > 0 ? '+' : '-'}\$${profit.abs()}',
                style: AppTextStyles.font16.copyWith(
                  color: AppColors.dollarColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}