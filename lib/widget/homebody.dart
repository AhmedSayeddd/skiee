import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skiee/core/api_constants.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/auth/cubit/auth_cubit.dart';
import 'package:skiee/data/models/api_flight_model.dart';
import 'package:skiee/favorites/cubit/favorites_cubit.dart';
import 'package:skiee/flight/model/flight_model.dart';
import 'package:skiee/flights/cubit/flights_cubit.dart';
import 'package:skiee/model/api_flight_card.dart';
import 'package:skiee/model/bulidfavoritcard.dart';
import 'package:skiee/widget/flightdetailsscreen.dart';

// ── Legacy sample data kept for the Favourite Flights cards section ──────────
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

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // Search controllers
  final _departureCtrl = TextEditingController(text: ApiConstants.defaultDeparture);
  final _arrivalCtrl = TextEditingController(text: ApiConstants.defaultArrival);
  final _dateCtrl = TextEditingController(text: ApiConstants.defaultDate);
  final _filterCtrl = TextEditingController();

  @override
  void dispose() {
    _departureCtrl.dispose();
    _arrivalCtrl.dispose();
    _dateCtrl.dispose();
    _filterCtrl.dispose();
    super.dispose();
  }

  void _search(BuildContext ctx) {
    FocusScope.of(ctx).unfocus();
    ctx.read<FlightsCubit>().fetchFlights(
          departure: _departureCtrl.text.trim().toUpperCase(),
          arrival: _arrivalCtrl.text.trim().toUpperCase(),
          date: _dateCtrl.text.trim(),
        );
  }

  /// Converts an [ApiFlightModel] to the existing [FlightModel] so the
  /// unchanged [FlightDetailsScreen] can receive it.
  FlightModel _toFlightModel(ApiFlightModel f) {
    return FlightModel(
      id: f.id,
      airline: f.airline,
      flightClass: '${f.travelClass.toUpperCase()} CLASS',
      isBusinessClass: f.travelClass.toLowerCase().contains('business'),
      from: f.departureAirport,
      fromCity: f.departureCityShort.toUpperCase(),
      to: f.arrivalAirport,
      toCity: f.arrivalCityShort.toUpperCase(),
      duration: f.duration,
      departTime: _stripDate(f.departureTime),
      arriveTime: _stripDate(f.arrivalTime),
      date: f.date,
      price: f.priceDisplay,
      airlineLogo: 'assets/images/imgSkieeLogo.svg', // local fallback logo
    );
  }

  static String _stripDate(String raw) {
    if (raw.contains(' ')) return raw.split(' ').last;
    return raw;
  }

  Future<void> _pickDate(BuildContext ctx) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.tryParse(_dateCtrl.text) ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _dateCtrl.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

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
                                    color:
                                        Colors.white.withValues(alpha: 0.85),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        // ── Search bar (filter on loaded results) ─────
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
                                  controller: _filterCtrl,
                                  onChanged: (q) => context
                                      .read<FlightsCubit>()
                                      .filterFlights(q),
                                  decoration: InputDecoration(
                                    hintText: 'Filter by airline or airport',
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
                              // Sort menu
                              BlocBuilder<FlightsCubit, FlightsState>(
                                builder: (ctx, state) {
                                  if (state is! FlightsSuccess) {
                                    return const SizedBox(width: 48);
                                  }
                                  return PopupMenuButton<FlightSortOption>(
                                    icon: Container(
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
                                    onSelected: (opt) => ctx
                                        .read<FlightsCubit>()
                                        .sortFlights(opt),
                                    itemBuilder: (_) => [
                                      const PopupMenuItem(
                                        value: FlightSortOption.price,
                                        child: Text('Sort by Price'),
                                      ),
                                      const PopupMenuItem(
                                        value: FlightSortOption.duration,
                                        child: Text('Sort by Duration'),
                                      ),
                                      const PopupMenuItem(
                                        value: FlightSortOption.airline,
                                        child: Text('Sort by Airline'),
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
                  );
                },
              ),

              const SizedBox(height: 24),

              // ── Favourite Flights ────────────────────────────────
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
                            isFavorite:
                                favState.isFavorite('fav_paris_london'),
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
                            isFavorite: favState.isFavorite('fav_london'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ── Discover Flights ─────────────────────────────────
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

              const SizedBox(height: 12),

              // ── Search inputs ────────────────────────────────────
              _SearchPanel(
                departureCtrl: _departureCtrl,
                arrivalCtrl: _arrivalCtrl,
                dateCtrl: _dateCtrl,
                onDateTap: () => _pickDate(context),
                onSearch: () => _search(context),
              ),

              const SizedBox(height: 14),

              // ── Results / Loading / Error ────────────────────────
              BlocBuilder<FlightsCubit, FlightsState>(
                builder: (context, state) {
                  if (state is FlightsInitial) {
                    return _EmptyState(
                      icon: Icons.flight_takeoff,
                      message: 'Enter a route above and tap Search',
                    );
                  }
                  if (state is FlightsLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2.5,
                        ),
                      ),
                    );
                  }
                  if (state is FlightsError) {
                    return _ErrorState(
                      message: state.message,
                      onRetry: () => _search(context),
                    );
                  }
                  if (state is FlightsSuccess) {
                    if (state.displayFlights.isEmpty) {
                      return _EmptyState(
                        icon: Icons.search_off,
                        message: 'No flights found for this route.',
                      );
                    }
                    return Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${state.displayFlights.length} flights found',
                                style: AppStyle.subtitleStyle.copyWith(
                                  fontSize: 13,
                                  color: AppColors.textHint,
                                ),
                              ),
                              Text(
                                'Sorted by ${state.sortBy.name}',
                                style: AppStyle.subtitleStyle.copyWith(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...state.displayFlights.map(
                          (flight) => Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                            child: ApiFlightCard(
                              flight: flight,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FlightDetailsScreen(
                                    flight: _toFlightModel(flight),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private UI helpers ────────────────────────────────────────────────────────

/// The three-field search panel (departure / arrival / date + search button).
class _SearchPanel extends StatelessWidget {
  const _SearchPanel({
    required this.departureCtrl,
    required this.arrivalCtrl,
    required this.dateCtrl,
    required this.onDateTap,
    required this.onSearch,
  });

  final TextEditingController departureCtrl;
  final TextEditingController arrivalCtrl;
  final TextEditingController dateCtrl;
  final VoidCallback onDateTap;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _SearchField(
                    controller: departureCtrl,
                    label: 'From',
                    icon: Icons.flight_takeoff,
                    hint: 'CDG',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.swap_horiz,
                      color: AppColors.primary, size: 22),
                ),
                Expanded(
                  child: _SearchField(
                    controller: arrivalCtrl,
                    label: 'To',
                    icon: Icons.flight_land,
                    hint: 'LHR',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onDateTap,
              child: AbsorbPointer(
                child: _SearchField(
                  controller: dateCtrl,
                  label: 'Date',
                  icon: Icons.calendar_today_outlined,
                  hint: 'YYYY-MM-DD',
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: onSearch,
                  icon: const Icon(Icons.search, color: Colors.white, size: 18),
                  label: Text(
                    'Search Flights',
                    style: AppStyle.titleStyle.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.hint,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.subtitleStyle.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(icon, size: 16, color: AppColors.textHint),
              const SizedBox(width: 6),
              Expanded(
                child: TextField(
                  controller: controller,
                  textCapitalization: TextCapitalization.characters,
                  style: AppStyle.titleStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: AppStyle.subtitleStyle.copyWith(
                      fontSize: 13,
                      color: AppColors.textHint,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.message});
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 48, color: AppColors.textHint.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyle.subtitleStyle.copyWith(
                fontSize: 14,
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 48,
                color: Colors.redAccent.withValues(alpha: 0.6)),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyle.subtitleStyle.copyWith(
                fontSize: 14,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh, color: Colors.white, size: 16),
              label: const Text('Retry',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
