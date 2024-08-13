import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/providers/subs/subs_notifier.dart';
import 'package:weight_tracker/providers/subs/subs_state.dart';

final StateNotifierProvider<SubsNotifier, SubsState> weightsProvider =
    StateNotifierProvider<SubsNotifier, SubsState>((ref) {
  return SubsNotifier();
});
