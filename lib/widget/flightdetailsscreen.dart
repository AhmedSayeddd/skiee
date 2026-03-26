import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/favorites/cubit/favorites_cubit.dart';
import 'package:skiee/flight/cubit/booking_cubit.dart';
import 'package:skiee/flight/model/flight_model.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key, required this.flight});
  static const String routeName = 'FlightDetailsScreen';

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == BookingStatus.booked) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✈️ Flight booked successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state.status == BookingStatus.error &&
            state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F8),
        body: SafeArea(
          child: Column(
            children: [
              // ── Custom App Bar ─────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
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
                          child: SvgPicture.asset(
                            AppImages.ARROW,
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        Text(
                          'Flight Details',
                          style: AppStyle.titleStyle.copyWith(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(AppImages.bri,
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              flight.airline,
                              style: AppStyle.titleStyle.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'BA 301',
                              style: AppStyle.subtitleStyle.copyWith(
                                color: Colors.white
                                    .withValues(alpha: 0.8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // ── Favourite heart ───────────────────────
                        BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder: (context, favState) {
                            final isFav =
                                favState.isFavorite(flight.id);
                            return GestureDetector(
                              onTap: () => context
                                  .read<FavoritesCubit>()
                                  .toggleFavorite(flight.id),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFav
                                      ? Colors.redAccent
                                      : Colors.white,
                                  size: 18,
                                ),
                              ),
                            );
                          },
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Route card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _RouteRow(
                              time: flight.departTime,
                              airport:
                                  '${_airportName(flight.from)}, ${_cityName(flight.fromCity)}',
                              code: flight.from,
                              iconAsset: AppImages.imgSkieeLogo,
                              iconBg: const Color(0xFFF0F2F8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 4, bottom: 4),
                              child: Row(
                                children: [
                                  Container(
                                      width: 1,
                                      height: 36,
                                      color:
                                          const Color(0xFFDDE1EC)),
                                  const SizedBox(width: 20),
                                  Text(
                                    '${flight.duration.toUpperCase()} FLIGHT',
                                    style:
                                        AppStyle.subtitleStyle.copyWith(
                                      fontSize: 11,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _RouteRow(
                              time: flight.arriveTime,
                              airport:
                                  '${_airportName(flight.to)}, ${_cityName(flight.toCity)}',
                              code: flight.to,
                              iconAsset: AppImages.air,
                              iconBg: AppColors.primary,
                              iconColorWhite: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Flight experience
                      Text(
                        'Flight Experience',
                        style: AppStyle.titleStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _InfoChip(
                              icon: AppImages.Airbus,
                              label: 'Airbus A319',
                              highlight: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _InfoChip(
                              icon: AppImages.typeOfClass,
                              label: flight.isBusinessClass
                                  ? 'Business Class'
                                  : 'Economy Class',
                              highlight: true,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Extensions',
                        style: AppStyle.titleStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildExtensionItem(
                          AppImages.Avreage, 'Average legroom (31 in)'),
                      const SizedBox(height: 10),
                      _buildExtensionItem(
                          AppImages.wifi, 'Wi-Fi for a fee'),
                      const SizedBox(height: 10),
                      _buildExtensionItem(AppImages.inseat,
                          'In-seat power & USB outlets'),
                      const SizedBox(height: 10),
                      _buildExtensionItem(
                          AppImages.video, 'On-demand video'),
                      const SizedBox(height: 10),
                      _buildExtensionItem(AppImages.carbon,
                          'Carbon emissions estimate: 461 kg'),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // ── Bottom bar with Book button ─────────────────────
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL PRICE',
                          style: AppStyle.subtitleStyle.copyWith(
                              fontSize: 11, letterSpacing: 0.5),
                        ),
                        Text(
                          flight.price,
                          style: AppStyle.titleStyle.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<BookingCubit, BookingState>(
                      builder: (context, bookState) {
                        final isLoading =
                            bookState.status == BookingStatus.loading;
                        final isBooked =
                            bookState.isBooked(flight.id);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              isBooked ? 'BOOKED ✓' : 'SAVER FARE',
                              style: AppStyle.subtitleStyle.copyWith(
                                fontSize: 11,
                                color: isBooked
                                    ? Colors.green
                                    : Colors.green,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              height: 48,
                              width: 180,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isBooked
                                        ? [Colors.grey, Colors.grey]
                                        : [
                                            AppColors.primary,
                                            AppColors.primaryLight
                                          ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.35),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: isLoading || isBooked
                                      ? null
                                      : () => context
                                          .read<BookingCubit>()
                                          .bookFlight(flight),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child:
                                              CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              isBooked
                                                  ? 'Booked'
                                                  : 'Book Flight',
                                              style: AppStyle.titleStyle
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.w700,
                                              ),
                                            ),
                                            if (!isBooked) ...[
                                              const SizedBox(width: 6),
                                              const Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                  size: 16),
                                            ],
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExtensionItem(String svgPath, String label) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgPath, width: 20, height: 20),
          const SizedBox(width: 14),
          Text(
            label,
            style: AppStyle.subtitleStyle.copyWith(
              color: AppColors.textDark,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static String _airportName(String code) {
    const map = {
      'CDG': 'Charles de Gaulle Airport',
      'LHR': 'Heathrow Airport',
      'HND': 'Haneda Airport',
    };
    return map[code] ?? code;
  }

  static String _cityName(String city) {
    return city[0] + city.substring(1).toLowerCase();
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.time,
    required this.airport,
    required this.code,
    required this.iconAsset,
    required this.iconBg,
    this.iconColorWhite = false,
  });

  final String time;
  final String airport;
  final String code;
  final String iconAsset;
  final Color iconBg;
  final bool iconColorWhite;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            iconAsset,
            colorFilter: iconColorWhite
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : null,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: AppStyle.titleStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark),
            ),
            Text(airport,
                style: AppStyle.subtitleStyle.copyWith(fontSize: 12)),
          ],
        ),
        const Spacer(),
        Text(
          code,
          style: AppStyle.subtitleStyle.copyWith(
            fontSize: 13,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip(
      {required this.icon, required this.label, required this.highlight});

  final String icon;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: highlight ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: (highlight ? AppColors.primary : Colors.black)
                .withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon,
              width: 18,
              height: 18,
              colorFilter: highlight
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: AppStyle.subtitleStyle.copyWith(
                color: highlight ? Colors.white : AppColors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
