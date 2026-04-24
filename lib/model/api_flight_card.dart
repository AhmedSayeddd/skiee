import 'package:flutter/material.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/data/models/api_flight_model.dart';

/// A flight card widget that displays live SerpAPI flight data.
/// Matches the visual style of the existing [FlightCard] widget.
class ApiFlightCard extends StatelessWidget {
  const ApiFlightCard({
    super.key,
    required this.flight,
    this.onTap,
  });

  final ApiFlightModel flight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isBusinessClass =
        flight.travelClass.toLowerCase().contains('business');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
            // ── Airline row ─────────────────────────────────
            Row(
              children: [
                _AirlineLogo(
                  logoUrl: flight.airlineLogo,
                  airline: flight.airline,
                  background:
                      isBusinessClass ? AppColors.border : AppColors.red,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flight.airline,
                        style: AppStyle.titleStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        '${flight.travelClass.toUpperCase()} CLASS',
                        style: AppStyle.subtitleStyle.copyWith(
                          fontSize: 11,
                          color: isBusinessClass
                              ? AppColors.primary
                              : AppColors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Price badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    flight.priceDisplay,
                    style: AppStyle.titleStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEFF4)),
            const SizedBox(height: 16),

            // ── Route row ────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Departure
                _TimeAirport(
                  time: _formatTime(flight.departureTime),
                  code: flight.departureAirport,
                  city: flight.departureCityShort,
                  align: CrossAxisAlignment.start,
                ),

                // Duration + plane icon
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        flight.duration,
                        style: AppStyle.subtitleStyle.copyWith(
                          fontSize: 11,
                          color: AppColors.textHint,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: const Color(0xFFDDE1EC),
                            ),
                          ),
                          const Icon(
                            Icons.flight,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: const Color(0xFFDDE1EC),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Direct',
                        style: AppStyle.subtitleStyle.copyWith(
                          fontSize: 11,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrival
                _TimeAirport(
                  time: _formatTime(flight.arrivalTime),
                  code: flight.arrivalAirport,
                  city: flight.arrivalCityShort,
                  align: CrossAxisAlignment.end,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Strips date prefix from SerpAPI time strings like "2025-08-01 10:10".
  static String _formatTime(String raw) {
    if (raw.contains(' ')) return raw.split(' ').last;
    return raw;
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────

class _AirlineLogo extends StatelessWidget {
  const _AirlineLogo({
    required this.logoUrl,
    required this.airline,
    required this.background,
  });

  final String logoUrl;
  final String airline;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: background.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: logoUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                logoUrl,
                width: 44,
                height: 44,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => _fallback(),
              ),
            )
          : _fallback(),
    );
  }

  Widget _fallback() {
    final initials = airline.isNotEmpty ? airline[0].toUpperCase() : '?';
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: background,
        ),
      ),
    );
  }
}

class _TimeAirport extends StatelessWidget {
  const _TimeAirport({
    required this.time,
    required this.code,
    required this.city,
    required this.align,
  });

  final String time;
  final String code;
  final String city;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          time,
          style: AppStyle.titleStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        Text(
          code,
          style: AppStyle.titleStyle.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        Text(
          city,
          style: AppStyle.subtitleStyle.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}
