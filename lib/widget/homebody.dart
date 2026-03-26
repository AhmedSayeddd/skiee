import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/auth/cubit/auth_cubit.dart';
import 'package:skiee/favorites/cubit/favorites_cubit.dart';
import 'package:skiee/flight/model/flight_model.dart';
import 'package:skiee/model/buildflightcard.dart';
import 'package:skiee/model/bulidfavoritcard.dart';
import 'package:skiee/widget/flightdetailsscreen.dart';

// Sample flights data shared across the app
final kSampleFlights = [
  const FlightModel(
    id: 'flight_1',
    airline: 'British Airways',
    flightClass: 'ECONOMY CLASS',
    isBusinessClass: false,
    from: 'CDG',
    fromCity: 'PARIS',
    to: 'LHR',
    toCity: 'LONDON',
    duration: '90 min',
    departTime: '10:10',
    arriveTime: '10:40',
    date: 'Jun 24, 2024',
    price: '\$150',
    airlineLogo: 'assets/images/BritishAir.svg',
  ),
  const FlightModel(
    id: 'flight_2',
    airline: 'Air France',
    flightClass: 'BUSINESS CLASS',
    isBusinessClass: true,
    from: 'HND',
    fromCity: 'TOKYO',
    to: 'CDG',
    toCity: 'PARIS',
    duration: '12h 41m',
    departTime: '08:00',
    arriveTime: '20:45',
    date: 'Jun 24, 2024',
    price: '\$800',
    airlineLogo: 'assets/images/imgSkieeLogo.svg',
  ),
];

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (prev, curr) => prev.userName != curr.userName,
                builder: (context, auth) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.25),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, ${auth.userName ?? 'Traveller'}',
                                  style: AppStyle.titleStyle.copyWith(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Where are we flying today?',
                                  style: AppStyle.subtitleStyle.copyWith(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Icon(Icons.search,
                                  color: AppColors.textHint, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search flights',
                                    hintStyle:
                                        AppStyle.subtitleStyle.copyWith(
                                      fontSize: 14,
                                      color: AppColors.textHint,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(7),
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.tune,
                                    color: Colors.white, size: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // ── Favourite Flights ─────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Favorite Flights',
                      style: AppStyle.titleStyle.copyWith(
                        fontSize: 17,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: AppStyle.subtitleStyle.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Favourite cards driven by FavoritesCubit
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: FavoriteFlightCard(
                            flightId: 'fav_paris_london',
                            imagePath: AppImages.Airphoto,
                            title: 'Paris to London',
                            info: 'Direct · 1h 20m',
                            price: '\$150',
                            isFavorite: favState
                                .isFavorite('fav_paris_london'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FavoriteFlightCard(
                            flightId: 'fav_london',
                            imagePath: AppImages.Airphoto2,
                            title: 'London',
                            info: '1 Stop · 8h',
                            price: '\$200',
                            isFavorite:
                                favState.isFavorite('fav_london'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Discover Flights',
                  style: AppStyle.titleStyle.copyWith(
                    fontSize: 17,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Discover flight cards
              ...kSampleFlights.asMap().entries.map((entry) {
                final flight = entry.value;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FlightDetailsScreen(flight: flight),
                      ),
                    ),
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
                  ),
                );
              }),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
