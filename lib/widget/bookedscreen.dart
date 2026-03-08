import 'package:flutter/material.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/model/buildflightcard.dart';

class BookedScreen extends StatefulWidget {
  const BookedScreen({super.key});
  static const String routeName = "BookedScreen";

  @override
  State<BookedScreen> createState() => _BookedScreenState();
}

class _BookedScreenState extends State<BookedScreen> {
  bool _showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                      ),
                      Text(
                        "My Bookings",
                        style: AppStyle.titleStyle.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 22),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _showUpcoming = true),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upcoming",
                              style: AppStyle.titleStyle.copyWith(
                                color: _showUpcoming ? Colors.white : Colors.white.withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: _showUpcoming ? FontWeight.w700 : FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 3,
                              width: 70,
                              decoration: BoxDecoration(
                                color: _showUpcoming ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () => setState(() => _showUpcoming = false),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Past",
                              style: AppStyle.titleStyle.copyWith(
                                color: !_showUpcoming ? Colors.white : Colors.white.withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: !_showUpcoming ? FontWeight.w700 : FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                color: !_showUpcoming ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    FlightCard(
                      airline: "British Airways",
                      flightClass: "ECONOMY CLASS",
                      isBusinessClass: false,
                      from: "CDG",
                      fromCity: "PARIS",
                      to: "LHR",
                      toCity: "LONDON",
                      duration: "90 min",
                      departTime: "10:10",
                      arriveTime: "10:40",
                      date: "Jun 24, 2024",
                      price: "\$150",
                      airlineLogo: AppImages.BritishAir,
                      logoBackground: AppColors.red,
                    ),
                    const SizedBox(height: 14),
                    FlightCard(
                      airline: "Air France",
                      flightClass: "BUSINESS CLASS",
                      isBusinessClass: true,
                      from: "HND",
                      fromCity: "TOKYO",
                      to: "CDG",
                      toCity: "PARIS",
                      duration: "12h 41m",
                      departTime: "08:00",
                      arriveTime: "20:45",
                      date: "Jun 24, 2024",
                      price: "\$150",
                      airlineLogo: AppImages.imgSkieeLogo,
                      logoBackground: AppColors.border,
                    ),
                    const SizedBox(height: 14),
                    FlightCard(
                      airline: "British Airways",
                      flightClass: "ECONOMY CLASS",
                      isBusinessClass: false,
                      from: "CDG",
                      fromCity: "PARIS",
                      to: "LHR",
                      toCity: "LONDON",
                      duration: "90 min",
                      departTime: "10:10",
                      arriveTime: "10:40",
                      date: "Jun 24, 2024",
                      price: "\$150",
                      airlineLogo: AppImages.BritishAir,
                      logoBackground: AppColors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}