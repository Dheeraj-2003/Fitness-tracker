abstract class SubsState {
  int amount = 0;
}

class InitialSubsState extends SubsState {}

class ChangedSubsState extends SubsState {
  final int changedAmount;

  ChangedSubsState({required this.changedAmount}) {
    amount = changedAmount;
  }
}

class ErrorSubsState extends SubsState {
  ErrorSubsState({
    required this.errorMessage,
  });
  final String errorMessage;
}
