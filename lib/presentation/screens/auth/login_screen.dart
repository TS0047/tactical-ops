import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../presentation/providers/infrastructure_providers.dart';
import '../../../routing/route_names.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _error;

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    try {
      await ref
          .read(authRepositoryProvider)
          .signInWithEmail(_emailCtrl.text.trim(), _passCtrl.text);
      if (mounted) context.go(Routes.dashboard);
    } catch (e) {
      setState(() => _error = 'Invalid credentials. Stand by.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.military_tech, size: 56, color: AppColors.olive),
                  const SizedBox(height: 20),
                  const Text(
                    AppStrings.appName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'ShareTechMono',
                      fontSize: 22,
                      letterSpacing: 4,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 48),
                  TextFormField(
                    controller: _emailCtrl,
                    decoration: const InputDecoration(labelText: AppStrings.email),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passCtrl,
                    decoration: const InputDecoration(labelText: AppStrings.password),
                    obscureText: true,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!,
                        style: const TextStyle(color: AppColors.redLight, fontSize: 13)),
                  ],
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: _loading ? null : _signIn,
                    child: _loading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.textPrimary))
                        : const Text(AppStrings.signIn),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => context.go(Routes.register),
                    child: const Text('CREATE ACCOUNT'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
