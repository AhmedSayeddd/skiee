import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/model/buildflightcard.dart';
import 'package:skiee/model/bulidfavoritcard.dart';
import 'package:skiee/widget/bookedscreen.dart';
import 'package:skiee/widget/flightdetailsscreen.dart';
import 'package:skiee/widget/profilescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                          backgroundColor: Colors.white.withOpacity(0.25),
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
                              "Hello, John",
                              style: AppStyle.titleStyle.copyWith(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Where are we flying today?",
                              style: AppStyle.subtitleStyle.copyWith(
                                color: Colors.white.withOpacity(0.85),
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
                          Icon(
                            Icons.search,
                            color: AppColors.textHint,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search flights",
                                hintStyle: AppStyle.subtitleStyle.copyWith(
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
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Favorite Flights",
                      style: AppStyle.titleStyle.copyWith(
                        fontSize: 17,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: FavoriteFlightCard(
                        imagePath: AppImages.Airphoto,
                        title: "Paris to London",
                        info: "Direct · 1h 20m",
                        price: "\$150",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FavoriteFlightCard(
                        imagePath: AppImages.Airphoto2,
                        title: "London",
                        info: "1 Stop · 8h",
                        price: "\$200",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Discover Flights",
                  style: AppStyle.titleStyle.copyWith(
                    fontSize: 17,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    FlightDetailsScreen.routeName,
                  ),
                  child: FlightCard(
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
                ),
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FlightCard(
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
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    FlightDetailsScreen.routeName,
                  ),
                  child: FlightCard(
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
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            Navigator.pushNamed(context, BookedScreen.routeName);
          } else if (index == 2) {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          }
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        elevation: 10,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.home,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                AppColors.textHint,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppImages.home,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.booked,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                AppColors.textHint,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppImages.booked,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            label: "Booked",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.profile,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                AppColors.textHint,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppImages.profile,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
