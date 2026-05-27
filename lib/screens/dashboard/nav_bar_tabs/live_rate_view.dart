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
            height: 180.h,
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
        unit = '\$';
        decimalPlaces = 2;
        break;
      case 'xagusd':
        title = 'Silver COMEX';
        unit = '\$';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.successColor.withOpacity(0.12)
                      : AppColors.errorColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 12.sp,
                      color: isPositive
                          ? AppColors.successColor
                          : AppColors.errorColor,
                    ),
                    SizedBox(width: 4.w),
                    CustomTextWidget(
                      text:
                          '${isPositive ? '+' : ''}${difference.toStringAsFixed(2)}',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: isPositive
                          ? AppColors.successColor
                          : AppColors.errorColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CustomTextWidget(
            text: '$unit${ltp.toStringAsFixed(decimalPlaces)}',
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'High',
                      fontSize: 10.sp,
                      color: AppColors.textHint,
                    ),
                    CustomTextWidget(
                      text: '$unit${high.toStringAsFixed(decimalPlaces)}',
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
                  children: [
                    CustomTextWidget(
                      text: 'Low',
                      fontSize: 10.sp,
                      color: AppColors.textHint,
                    ),
                    CustomTextWidget(
                      text: '$unit${low.toStringAsFixed(decimalPlaces)}',
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
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildProductCard(rate, index + 1),
          );
        },
      );
    });
  }

  Widget _buildProductCard(dynamic rate, int rowNum) {
    final symbol = rate.symbol ?? 'Product';
    final source = rate.source ?? '';
    final mcxAsk = double.tryParse(rate.mcxAsk?.toString() ?? '0') ?? 0;
    final premium = double.tryParse(rate.premium?.toString() ?? '0') ?? 0;
    final purity = double.tryParse(rate.purity?.toString() ?? '0') ?? 0;
    final diff = double.tryParse(rate.diff?.toString() ?? '0') ?? 0;
    final isPositive = diff >= 0;

    return CustomCardContainer(
      padding: EdgeInsets.all(16.sp),
      borderColor: AppColors.borderLight,
      borderRadius: 16.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: symbol,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    if (source.isNotEmpty)
                      CustomTextWidget(
                        text: source,
                        fontSize: 11.sp,
                        color: AppColors.textHint,
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.successColor.withOpacity(0.12)
                      : AppColors.errorColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12.sp,
                      color: isPositive
                          ? AppColors.successColor
                          : AppColors.errorColor,
                    ),
                    SizedBox(width: 4.w),
                    CustomTextWidget(
                      text: diff.abs().toString(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isPositive
                          ? AppColors.successColor
                          : AppColors.errorColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Stats Grid
          Row(
            children: [
              Expanded(
                child: _buildInfoTile(
                  label: 'MCX Ask',
                  value: '₹${mcxAsk.toStringAsFixed(0)}',
                  isPrimary: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInfoTile(
                  label: 'Premium',
                  value: '₹${premium.abs().toStringAsFixed(0)}',
                  valueColor: premium >= 0
                      ? AppColors.successColor
                      : AppColors.errorColor,
                  prefix: premium >= 0 ? '+' : '-',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoTile(
                  label: 'Base Price',
                  value: '₹${(mcxAsk - premium).toStringAsFixed(0)}',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInfoTile(
                  label: 'Final Ask',
                  value: '₹${purity.toStringAsFixed(0)}',
                  isHighlighted: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Divider(color: AppColors.borderLight, height: 1),
          SizedBox(height: 16.h),

          // Premium Input Row
          Row(
            children: [
              Expanded(child: _buildPremiumInput()),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Apply premium logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: CustomTextWidget(
                    text: 'Apply',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required String label,
    required String value,
    Color? valueColor,
    String? prefix,
    bool isPrimary = false,
    bool isHighlighted = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: label,
          fontSize: 11.sp,
          color: AppColors.textHint,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 6.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: isHighlighted
                ? AppColors.primaryColor.withOpacity(0.08)
                : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(10.r),
            border: isHighlighted
                ? Border.all(color: AppColors.primaryColor.withOpacity(0.3))
                : null,
          ),
          child: CustomTextWidget(
            text: '$prefix${value.isNotEmpty ? value : '--'}',
            fontSize: isPrimary ? 16.sp : 14.sp,
            fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
            color:
                valueColor ??
                (isHighlighted
                    ? AppColors.primaryColor
                    : AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumInput() {
    final TextEditingController premiumController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: 'Your Premium',
          fontSize: 11.sp,
          color: AppColors.textHint,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 6.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: TextField(
            controller: premiumController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter premium',
              hintStyle: TextStyle(fontSize: 12.sp, color: AppColors.textHint),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              prefixText: '₹ ',
              prefixStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
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
