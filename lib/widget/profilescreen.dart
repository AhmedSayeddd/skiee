import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skiee/auth/cubit/auth_cubit.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/auth/pages/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = 'ProfileScreen';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeName,
            (route) => false,
          );
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, auth) {
          return Scaffold(
            backgroundColor: const Color(0xFFF0F2F8),
            body: SafeArea(
              child: Column(
                children: [
                  // ── Header ──────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.fromLTRB(20, 16, 20, 40),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 22),
                            Text(
                              'Profile',
                              style: AppStyle.titleStyle.copyWith(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 22),
                          ],
                        ),
                        const SizedBox(height: 24),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              AppImages.profilepic,
                              width: 96,
                              height: 96,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5A623),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'GOLD MEMBER',
                            style: AppStyle.subtitleStyle.copyWith(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          auth.userName ?? 'Traveller',
                          style: AppStyle.titleStyle.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          auth.userEmail ?? '',
                          style: AppStyle.subtitleStyle.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Account menu ─────────────────────────────────
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ACCOUNT',
                          style: AppStyle.subtitleStyle.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: AppColors.textHint,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildMenuItem(
                                icon: AppImages.favorite,
                                iconColor: AppColors.primary,
                                iconBg: const Color(0xFFEEF2FF),
                                label: 'Favorite Flights',
                                showArrow: true,
                                onTap: () {},
                              ),
                              const Divider(
                                height: 1,
                                indent: 56,
                                color: Color(0xFFEEEEEE),
                              ),
                              _buildMenuItem(
                                icon: AppImages.LogOut,
                                iconColor: Colors.redAccent,
                                iconBg: const Color(0xFFFFECEC),
                                label: 'Log Out',
                                labelColor: Colors.redAccent,
                                showArrow: false,
                                onTap: () {
                                  context.read<AuthCubit>().logout();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    Color? labelColor,
    required bool showArrow,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration:
                  BoxDecoration(color: iconBg, shape: BoxShape.circle),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(icon,
                  colorFilter:
                      ColorFilter.mode(iconColor, BlendMode.srcIn)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: AppStyle.subtitleStyle.copyWith(
                  color: labelColor ?? AppColors.textDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            if (showArrow)
              const Icon(Icons.arrow_forward_ios,
                  size: 14, color: Color(0xFFBBBBBB)),
          ],
        ),
      ),
    );
  }
}
