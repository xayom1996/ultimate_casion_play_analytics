import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';

class LineChartSample2 extends StatefulWidget {
  final Map<String, dynamic> data;
  final Map<int, double> spots;
  final double maxY;
  final double lastBalance;
  final double percentDifference;

  const LineChartSample2(
      {super.key,
      required this.data,
      required this.spots,
      required this.maxY,
      required this.lastBalance,
      required this.percentDifference});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColors.mainBlue,
    AppColors.white,
  ];

  bool showAvg = false;

  Map<int, double> sortedSpots() {
    return SplayTreeMap<int, double>.from(
        widget.spots, (a, b) => a.compareTo(b));
  }

  String getTouchedPrice(int idx) {
    return context.read<SettingsCubit>().getPrice(sortedSpots()[sortedSpots().keys.toList()[idx]]!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.20,
          child: Padding(
            padding: const EdgeInsets.only(
                // right: 18,
                // left: 12,
                // top: 24,
                // bottom: 12,
                ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        Positioned(
          top: 14,
          left: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balance',
                style: AppTextStyles.font16,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                context.read<SettingsCubit>().getPrice(widget.lastBalance),
                style: AppTextStyles.font24,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(54)),
                  color: AppColors.mainBlue,
                ),
                child: Center(
                  child: Text(
                    '${widget.percentDifference > 0 ? '+': widget.percentDifference != 0 ? '-' : ''}${widget.percentDifference.abs().toStringAsFixed(2)}%',
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = AppTextStyles.font12.copyWith(
      fontWeight: FontWeight.w300,
    );
    int lastIdx = widget.data['count'].toInt();
    Widget text;
    if (value == 1) {
      text = Text(widget.data['lines'].first, style: style);
    } else if (value == lastIdx) {
      text = Text(widget.data['lines'].last, style: style);
    } else {
      return const SizedBox.shrink();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xffD6D6D6),
            strokeWidth: 0.78,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xffD6D6D6),
            strokeWidth: 0.78,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: widget.data['count'].toDouble() + 1,
      minY: 0,
      maxY: 2 * context.read<SettingsCubit>().state.getActualPrice(widget.maxY),
      lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: AppColors.white,
            tooltipRoundedRadius: 20.0,
            showOnTopOfTheChartBoxArea: true,
            fitInsideHorizontally: false,
            tooltipMargin: -10,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map(
                    (LineBarSpot touchedSpot) {
                  var textStyle = AppTextStyles.font14.copyWith(
                    color: AppColors.mainBlue,
                    fontWeight: FontWeight.w700,
                  );
                  return LineTooltipItem(
                    getTouchedPrice(touchedSpot.spotIndex.toInt()),
                    textStyle,
                  );
                },
              ).toList();
            },
          ),

      ),
      lineBarsData: [
        LineChartBarData(
          spots: sortedSpots()
              .keys
              .map((key) => FlSpot(key.toDouble(), context.read<SettingsCubit>().state.getActualPrice(widget.spots[key]!)))
              .toList(),
          isCurved: true,
          color: gradientColors[0],
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
