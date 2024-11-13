enum ImpulsePlayerState {
  loading('loading'),
  ready('ready'),
  error('error');

  final String rawValue;

  const ImpulsePlayerState(this.rawValue);

  factory ImpulsePlayerState.fromValue(String value) {
    return ImpulsePlayerState.values.firstWhere(
      (status) => status.rawValue == value,
      orElse: () => throw "Unexpected state: $value",
    );
  }
}
