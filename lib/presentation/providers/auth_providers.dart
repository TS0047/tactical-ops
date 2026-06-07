import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_profile.dart';
import 'infrastructure_providers.dart';

final authStateProvider = StreamProvider<User?>((ref) =>
    ref.watch(authRepositoryProvider).authStateChanges);

final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(null);
  return ref.watch(authRepositoryProvider).watchUserProfile(user.uid);
});
