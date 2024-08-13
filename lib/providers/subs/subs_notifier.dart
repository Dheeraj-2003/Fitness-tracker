import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/providers/subs/subs_state.dart';

class SubsNotifier extends StateNotifier<SubsState> {
  SubsNotifier() : super(InitialSubsState());

  void changeSubsAmount(int amount) {
    try {
      state = ChangedSubsState(changedAmount: amount);
    } catch (e) {
      log("add weights: $e");
    }
  }
}
