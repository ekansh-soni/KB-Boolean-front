import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kb_boolean/services/socket_service.dart';
import 'package:kb_boolean/theme/app_colors.dart';
import 'package:kb_boolean/utils/utils.dart';
import 'package:kb_boolean/widgets/custom_card_container.dart';
import 'package:kb_boolean/widgets/custom_text_widget.dart';

class LiveRateView extends StatelessWidget {
  LiveRateView({super.key});

  final socket = SocketService.to;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Add refresh logic here
        // socket.refreshData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Market Overview Section
            _buildMarketOverview(),
            SizedBox(height: 24.h),

            CustomTextWidget(
              text: 'Live Rates',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),

            spaceHeight(12.h),
            // Product Cards
            _buildProductList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketOverview() {
    return Obx(() {
      if (socket.comexList.isEmpty) {
        return const SizedBox.shrink();
      }

      // Filter and sort comex data
      final comexData = socket.comexList.where((item) {
        final symbol = item.symbol?.toString().toLowerCase() ?? '';
        return ['xauusd', 'xagusd', 'inrspot'].contains(symbol);
      }).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: 'Market Overview',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 140.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: comexData.length,
              itemBuilder: (context, index) {
                final item = comexData[index];
                return Container(
                  width: 160.w,
                  margin: EdgeInsets.only(right: 12.w),
                  child: _buildMarketCard(item),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildMarketCard(dynamic item) {
    final symbol = item.symbol?.toString().toLowerCase() ?? '';
    final ltp = double.tryParse(item.ltp?.toString() ?? '0') ?? 0;
    final high = double.tryParse(item.high?.toString() ?? '0') ?? 0;
    final low = double.tryParse(item.low?.toString() ?? '0') ?? 0;
    final difference = double.tryParse(item.difference?.toString() ?? '0') ?? 0;
    final isPositive = difference >= 0;

    String title;
    String unit;
    int decimalPlaces;

    switch (symbol) {
      case 'xauusd':
        title = 'Gold COMEX';
        unit = '₹';
        decimalPlaces = 2;
        break;
      case 'xagusd':
        title = 'Silver COMEX';
        unit = '₹';
        decimalPlaces = 2;
        break;
      case 'inrspot':
        title = 'INR Spot';
        unit = '₹';
        decimalPlaces = 2;
        break;
      default:
        title = symbol.toUpperCase();
        unit = '';
        decimalPlaces = 0;
    }

    return CustomCardContainer(
      bgColor: AppColors.cardBackground,
      borderColor: AppColors.borderLight,
      padding: EdgeInsets.all(14.sp),
      borderRadius: 16.r,
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: .min,
          children: [
            CustomTextWidget(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 12.h),
            CustomTextWidget(
              text: ltp.toStringAsFixed(decimalPlaces),
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: .start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: .start,
                    children: [
                      CustomTextWidget(
                        text: 'High',
                        fontSize: 10.sp,
                        color: AppColors.textHint,
                      ),
                      CustomTextWidget(
                        text: high.toStringAsFixed(2),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.successColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: .start,
                    children: [
                      CustomTextWidget(
                        text: 'Low',
                        fontSize: 10.sp,
                        color: AppColors.textHint,
                      ),
                      CustomTextWidget(
                        text: low.toStringAsFixed(2),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.errorColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Obx(() {
      final rates = socket.webSocketResponseBean.value?.rates ?? [];

      if (rates.isEmpty) {
        return _buildShimmerLoader();
      }

      return ListView.builder(
        itemCount: rates.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final rate = rates[index];
          return _buildProductCard(rate, index + 1);
        },
      );
    });
  }

  Widget _buildProductCard(dynamic rate, int rowNum) {
    final symbol = rate.symbol ?? 'Product';
    final source = rate.source ?? '';
    final ask = rate.ask?.toString() ?? '--';
    final bid = rate.bid?.toString() ?? '--';
    final high = rate.high?.toString() ?? '--';
    final low = rate.low?.toString() ?? '--';
    final diff = double.tryParse(rate.diff?.toString() ?? '0') ?? 0;
    final time = rate.time?.toString() ?? '';
    final isPositive = diff > 0;

    // Parse colors based on diff
    Color getDiffColor() {
      if (diff > 0) return AppColors.successColor;
      if (diff < 0) return AppColors.errorColor;
      return AppColors.textSecondary;
    }

    return CustomCardContainer(
      padding: EdgeInsets.all(16.sp),
      borderColor: AppColors.borderLight,
      borderRadius: 16.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Symbol and Source
          CustomTextWidget(
            text: symbol,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          SizedBox(height: 12.h),

          // Labels: SELL and BUY
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              CustomTextWidget(
                text: 'SELL (Ask)',
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),

                CustomTextWidget(
                  text: 'BUY (Bid)',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
            ],
          ),
          SizedBox(height: 4.h),

          // Prices: Ask and Bid with indicators
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomTextWidget(
                      text: ask,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: getDiffColor(),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 14.sp,
                      color: getDiffColor(),
                    ),
                  ],
                ),
              ),

              Expanded(
                  child: Row(
                    mainAxisAlignment: .end,
                    children: [
                      CustomTextWidget(
                        text: bid,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: getDiffColor(),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        size: 14.sp,
                        color: getDiffColor(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),

          // High, Low, Change, and Time in one row
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomTextWidget(
                      text: 'High: ',
                      fontSize: 11.sp,
                      color: AppColors.textHint,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextWidget(
                      text: high == '--' ? '--' : high,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.successColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: .end,
                  children: [
                    CustomTextWidget(
                      text: 'Low: ',
                      fontSize: 11.sp,
                      color: AppColors.textHint,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextWidget(
                      text: low == '--' ? '--' : low,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.errorColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            height: 200.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
