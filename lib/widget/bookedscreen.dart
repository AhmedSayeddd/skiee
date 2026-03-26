import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/flight/cubit/booking_cubit.dart';
import 'package:skiee/model/buildflightcard.dart';

class BookedScreen extends StatelessWidget {
  const BookedScreen({super.key});
  static const String routeName = 'BookedScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF0F2F8),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header with tabs ──────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  decoration:
                      const BoxDecoration(color: AppColors.primary),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Bookings',
                        style: AppStyle.titleStyle.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _TabItem(
                            label: 'Upcoming',
                            isActive:
                                state.activeTab == BookingTab.upcoming,
                            onTap: () => context
                                .read<BookingCubit>()
                                .selectTab(BookingTab.upcoming),
                            width: 70,
                          ),
                          const SizedBox(width: 24),
                          _TabItem(
                            label: 'Past',
                            isActive:
                                state.activeTab == BookingTab.past,
                            onTap: () => context
                                .read<BookingCubit>()
                                .selectTab(BookingTab.past),
                            width: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Bookings list ─────────────────────────────────
                Expanded(
                  child: state.activeTab == BookingTab.upcoming
                      ? _buildUpcoming(context, state)
                      : _buildPast(context, state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUpcoming(BuildContext context, BookingState state) {
    if (state.bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flight_takeoff,
                size: 64,
                color: AppColors.textHint.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              'No upcoming bookings',
              style: AppStyle.subtitleStyle.copyWith(
                color: AppColors.textHint,
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: state.bookings.map((flight) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: FlightCard(
              airline: flight.airline,
              flightClass: flight.flightClass,
              isBusinessClass: flight.isBusinessClass,
              from: flight.from,
              fromCity: flight.fromCity,
              to: flight.to,
              toCity: flight.toCity,
              duration: flight.duration,
              departTime: flight.departTime,
              arriveTime: flight.arriveTime,
              date: flight.date,
              price: flight.price,
              airlineLogo: flight.airlineLogo,
              logoBackground: flight.isBusinessClass
                  ? AppColors.border
                  : AppColors.red,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPast(BuildContext context, BookingState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history,
              size: 64,
              color: AppColors.textHint.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text(
            'No past bookings',
            style: AppStyle.subtitleStyle.copyWith(
              color: AppColors.textHint,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.width,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyle.titleStyle.copyWith(
              color: isActive
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
              fontWeight:
                  isActive ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: width.toDouble(),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}