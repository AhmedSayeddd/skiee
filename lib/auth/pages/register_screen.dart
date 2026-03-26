import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skiee/auth/cubit/auth_cubit.dart';
import 'package:skiee/auth/pages/login_screen.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';
import 'package:skiee/navigation/main_shell.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';

  @override
  Widget build(BuildContext context) {
    return const _RegisterBody();
  }
}

class _RegisterBody extends StatefulWidget {
  const _RegisterBody();

  @override
  State<_RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<_RegisterBody> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainShell.routeName,
            (route) => false,
          );
        } else if (state.status == AuthStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.redAccent,
            ),
          );
          context.read<AuthCubit>().clearError();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(height: 24),
                Text(
                  'Create Account',
                  style: AppStyle.titleStyle.copyWith(
                    fontSize: 30,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Join us and start exploring the world',
                    style: AppStyle.subtitleStyle),
                const SizedBox(height: 32),

                // Full Name
                Text('Full Name',
                    style: AppStyle.loginwith.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _nameController,
                  hint: 'John Doe',
                  keyboardType: TextInputType.name,
                  prefixIcon: SvgPicture.asset(AppImages.profile,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          AppColors.textHint, BlendMode.srcIn)),
                ),
                const SizedBox(height: 16),

                // Email
                Text('Email',
                    style: AppStyle.loginwith.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _emailController,
                  hint: 'john@example.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: SvgPicture.asset(AppImages.Email,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          AppColors.textHint, BlendMode.srcIn)),
                ),
                const SizedBox(height: 16),

                // Password
                Text('Password',
                    style: AppStyle.loginwith.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (p, c) => p.showPassword != c.showPassword,
                  builder: (context, state) => _buildTextField(
                    controller: _passwordController,
                    hint: '••••••••',
                    obscure: !state.showPassword,
                    prefixIcon: SvgPicture.asset(AppImages.pass,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            AppColors.textHint, BlendMode.srcIn)),
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          context.read<AuthCubit>().toggleShowPassword(),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(AppImages.eye_visualisation,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                                AppColors.textHint, BlendMode.srcIn)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password
                Text('Confirm Password',
                    style: AppStyle.loginwith.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (p, c) =>
                      p.showConfirmPassword != c.showConfirmPassword,
                  builder: (context, state) => _buildTextField(
                    controller: _confirmPasswordController,
                    hint: '••••••••',
                    obscure: !state.showConfirmPassword,
                    prefixIcon: SvgPicture.asset(AppImages.confirm_Password,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            AppColors.textHint, BlendMode.srcIn)),
                    suffixIcon: GestureDetector(
                      onTap: () => context
                          .read<AuthCubit>()
                          .toggleShowConfirmPassword(),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(AppImages.eye_visualisation,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                                AppColors.textHint, BlendMode.srcIn)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Terms checkbox
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (p, c) =>
                      p.agreedToTerms != c.agreedToTerms,
                  builder: (context, state) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            context.read<AuthCubit>().toggleAgreedToTerms(),
                        child: Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: state.agreedToTerms
                                  ? AppColors.primary
                                  : AppColors.textHint,
                              width: 1.5,
                            ),
                            color: state.agreedToTerms
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                          child: state.agreedToTerms
                              ? const Icon(Icons.check,
                                  size: 12, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppStyle.subtitleStyle,
                            children: [
                              const TextSpan(
                                  text: 'By signing up, you agree to our '),
                              TextSpan(
                                text: 'Terms of Service',
                                style: AppStyle.subtitleStyle.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                              const TextSpan(text: '\nand '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: AppStyle.subtitleStyle.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Sign Up button
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (p, c) =>
                      p.status != c.status ||
                      p.agreedToTerms != c.agreedToTerms,
                  builder: (context, state) {
                    final isLoading = state.status == AuthStatus.loading;
                    return SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryLight],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Passwords don't match!"),
                                    ));
                                    return;
                                  }
                                  if (!state.agreedToTerms) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text('Please agree to terms first'),
                                    ));
                                    return;
                                  }
                                  context.read<AuthCubit>().register(
                                        _nameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2),
                                )
                              : Text(
                                  'Sign Up',
                                  style: AppStyle.titleStyle.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                            color: AppColors.border, thickness: 1)),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR CONTINUE WITH',
                        style: AppStyle.subtitleStyle.copyWith(
                            fontSize: 11,
                            letterSpacing: 0.8,
                            color: AppColors.textHint),
                      ),
                    ),
                    const Expanded(
                        child: Divider(
                            color: AppColors.border, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.Google,
                                width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('Google',
                                style: AppStyle.subtitleStyle.copyWith(
                                    color: AppColors.textMedium,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.Facebook,
                                width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('Facebook',
                                style: AppStyle.subtitleStyle.copyWith(
                                    color: AppColors.textMedium,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: AppStyle.subtitleStyle),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 4),
                          minimumSize: Size.zero,
                          tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign In',
                          style: AppStyle.subtitleStyle.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      style: AppStyle.subtitleStyle.copyWith(color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppStyle.subtitleStyle,
        filled: true,
        fillColor: const Color(0xFFF5F7FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        prefixIcon: Padding(
            padding: const EdgeInsets.all(14), child: prefixIcon),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
