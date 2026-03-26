import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';

class FlightCard extends StatelessWidget {
  const FlightCard({
    super.key,
    required this.airline,
    required this.flightClass,
    required this.isBusinessClass,
    required this.from,
    required this.fromCity,
    required this.to,
    required this.toCity,
    required this.duration,
    required this.departTime,
    required this.arriveTime,
    required this.date,
    required this.price,
    required this.airlineLogo,
    required this.logoBackground,
  });

  final String airline;
  final String flightClass;
  final bool isBusinessClass;
  final String from;
  final String fromCity;
  final String to;
  final String toCity;
  final String duration;
  final String departTime;
  final String arriveTime;
  final String date;
  final String price;
  final String airlineLogo;
  final Color logoBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // airline logo + name + class badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // circle with custom color + svg logo
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: logoBackground,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(7),
                    child: SvgPicture.asset(
                      airlineLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    airline,
                    style: AppStyle.subtitleStyle.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              // orange for business, blue for economy
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: isBusinessClass
                      ? const Color(0xFFFFF3E0)
                      : const Color(0xFFE8F0FE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  flightClass,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isBusinessClass ? Colors.orange : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // from -- duration line -- to
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // departure side
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    from,
                    style: AppStyle.titleStyle.copyWith(
                      fontSize: 28,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    fromCity,
                    style: AppStyle.subtitleStyle.copyWith(fontSize: 11),
                  ),
                ],
              ),

              // middle: duration + dot line + non-stop blue badge
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        duration,
                        style: AppStyle.subtitleStyle.copyWith(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // empty circle on the left
                          Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.textHint,
                                width: 1.5,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(height: 1, color: AppColors.textHint),
                          ),
                          // filled circle on the right
                          Container(
                            width: 9,
                            height: 9,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // non-stop - just blue text, no border or background
                      Text(
                        "Non-stop",
                        style: AppStyle.subtitleStyle.copyWith(
                          fontSize: 10,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // arrival side
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    to,
                    style: AppStyle.titleStyle.copyWith(
                      fontSize: 28,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    toCity,
                    style: AppStyle.subtitleStyle.copyWith(fontSize: 11),
                  ),
                ],
              ),

            ],
          ),

          const SizedBox(height: 6),

          // depart and arrive times
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                departTime,
                style: AppStyle.subtitleStyle.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              Text(
                arriveTime,
                style: AppStyle.subtitleStyle.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 12),

          // date with svg calendar icon on the left --- price on the right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // calendar svg + date text
              Row(
                children: [
                  SvgPicture.asset(
                    AppImages.Calender, // your svg calendar asset
                    width: 14,
                    height: 14,
                    colorFilter: ColorFilter.mode(
                      AppColors.textHint,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    date,
                    style: AppStyle.subtitleStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),

              // just the price text, no icon
              Text(
                price,
                style: AppStyle.titleStyle.copyWith(
                  fontSize: 18,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}