import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../routing/route_names.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Run splash delay and auth resolution in parallel.
    // On web, Firebase rehydrates the session asynchronously — reading
    // authStateProvider.value before it resolves always returns null,
    // which forces a login every launch. Awaiting the future ensures we
    // only navigate once the auth state is actually known.
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 1500)),
      ref.read(authStateProvider.future),
    ]);
    if (!mounted) return;
    final user = ref.read(authStateProvider).value;
    context.go(user != null ? Routes.dashboard : Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.military_tech, size: 64, color: AppColors.olive),
            SizedBox(height: 24),
            Text(
              AppStrings.appName,
              style: TextStyle(
                fontFamily: 'ShareTechMono',
                fontSize: 24,
                letterSpacing: 4,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'INITIALIZING...',
              style: TextStyle(
                fontFamily: 'ShareTechMono',
                fontSize: 11,
                letterSpacing: 2,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
