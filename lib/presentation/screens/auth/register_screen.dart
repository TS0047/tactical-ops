import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/user_profile.dart';
import '../../../presentation/providers/infrastructure_providers.dart';
import '../../../routing/route_names.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _callSignCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _error;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    try {
      final cred = await ref
          .read(authRepositoryProvider)
          .registerWithEmail(_emailCtrl.text.trim(), _passCtrl.text);
      final uid = cred.user!.uid;
      final callSign = _callSignCtrl.text.trim().toUpperCase();
      await ref.read(authRepositoryProvider).createUserProfile(
            UserProfile(
              uid: uid,
              displayName: callSign,
              email: _emailCtrl.text.trim(),
              callSign: callSign.isEmpty ? 'OPERATOR' : callSign,
              createdAt: DateTime.now(),
            ),
          );
      if (mounted) context.go(Routes.dashboard);
    } catch (e) {
      setState(() => _error = 'Registration failed. Try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('ENLIST'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(Routes.login),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _callSignCtrl,
                  decoration: const InputDecoration(labelText: AppStrings.callSign),
                  textCapitalization: TextCapitalization.characters,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: AppStrings.email),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passCtrl,
                  decoration: const InputDecoration(labelText: AppStrings.password),
                  obscureText: true,
                  validator: (v) =>
                      v != null && v.length < 6 ? 'Min 6 characters' : null,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!,
                      style: const TextStyle(
                          color: AppColors.redLight, fontSize: 13)),
                ],
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: _loading ? null : _register,
                  child: _loading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.textPrimary))
                      : const Text(AppStrings.signUp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
