import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skiee/auth/pages/login_screen.dart';
import 'package:skiee/core/app_colors.dart';
import 'package:skiee/core/app_images.dart';
import 'package:skiee/core/app_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // controllers for all the fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // for showing/hiding passwords
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  // checkbox for terms and conditions
  bool _agreedToTerms = false;

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
    return Scaffold(
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
                "Create Account",
                style: AppStyle.titleStyle.copyWith(
                  fontSize: 30,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Join us and start exploring the world",
                style: AppStyle.subtitleStyle,
              ),

              const SizedBox(height: 32),

              Text(
                "Full Name",
                style: AppStyle.loginwith.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                style: AppStyle.subtitleStyle.copyWith(
                  color: AppColors.textDark,
                ),
                decoration: InputDecoration(
                  hintText: "John Doe",
                  hintStyle: AppStyle.subtitleStyle,
                  filled: true,
                  fillColor: const Color(0xFFF5F7FA),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      AppImages
                          .profile, // use whatever your person icon asset is
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.textHint,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "Email",
                style: AppStyle.loginwith.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppStyle.subtitleStyle.copyWith(
                  color: AppColors.textDark,
                ),
                decoration: InputDecoration(
                  hintText: "john@example.com",
                  hintStyle: AppStyle.subtitleStyle,
                  filled: true,
                  fillColor: const Color(0xFFF5F7FA),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      AppImages.Email,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.textHint,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "Password",
                style: AppStyle.loginwith.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: !_showPassword,
                style: AppStyle.subtitleStyle.copyWith(
                  color: AppColors.textDark,
                ),
                decoration: InputDecoration(
                  hintText: "••••••••",
                  hintStyle: AppStyle.subtitleStyle,
                  filled: true,
                  fillColor: const Color(0xFFF5F7FA),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      AppImages.pass,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.textHint,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: SvgPicture.asset(
                        AppImages.eye_visualisation,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          AppColors.textHint,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "Confirm Password",
                style: AppStyle.loginwith.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_showConfirmPassword,
                style: AppStyle.subtitleStyle.copyWith(
                  color: AppColors.textDark,
                ),
                decoration: InputDecoration(
                  hintText: "••••••••",
                  hintStyle: AppStyle.subtitleStyle,
                  filled: true,
                  fillColor: const Color(0xFFF5F7FA),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      AppImages.confirm_Password, // reusing same lock icon
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.textHint,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: SvgPicture.asset(
                        AppImages.eye_visualisation,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          AppColors.textHint,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _agreedToTerms = !_agreedToTerms;
                      });
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _agreedToTerms
                              ? AppColors.primary
                              : AppColors.textHint,
                          width: 1.5,
                        ),
                        color: _agreedToTerms
                            ? AppColors.primary
                            : Colors.transparent,
                      ),
                      child: _agreedToTerms
                          ? const Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            )
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
                            text: "By signing up, you agree to our ",
                          ),
                          TextSpan(
                            text: "Terms of Service",
                            style: AppStyle.subtitleStyle.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: "\nand "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: AppStyle.subtitleStyle.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: "."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Center(
                child: SizedBox(
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
                          color: AppColors.primary.withOpacity(0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords don't match!"),
                            ),
                          );
                          return;
                        }
                        if (!_agreedToTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please agree to terms first"),
                            ),
                          );
                          return;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: AppStyle.titleStyle.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Expanded(
                    child: Divider(color: AppColors.border, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "OR CONTINUE WITH",
                      style: AppStyle.subtitleStyle.copyWith(
                        fontSize: 11,
                        letterSpacing: 0.8,
                        color: AppColors.textHint,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: AppColors.border, thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  // google
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: google sign in
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppImages.Google,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Google",
                            style: AppStyle.subtitleStyle.copyWith(
                              color: AppColors.textMedium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: facebook sign in
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppImages.Facebook,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Facebook",
                            style: AppStyle.subtitleStyle.copyWith(
                              color: AppColors.textMedium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                    Text(
                      "Already have an account?",
                      style: AppStyle.subtitleStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Sign In",
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
    );
  }
}
