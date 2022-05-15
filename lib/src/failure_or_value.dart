part of failure_or_value;

class Either<T, K> {
  const Either._(this._failure, this._value);

  final T? _failure;
  final K? _value;

  bool isSuccess() {
    return _failure == null;
  }

  bool isFailure() {
    return _failure != null;
  }

  dynamic fold(
    Function(T failure) onFailure,
    Function(K value) onSuccess,
  ) {
    if (isFailure()) {
      return onFailure(_failure as T);
    }
    return onSuccess(_value as K);
  }

  Future asyncFold(
    Future Function(T failure) onFailure,
    Future Function(K value) onSuccess,
  ) {
    if (isFailure()) {
      return onFailure(_failure as T);
    }
    return onSuccess(_value as K);
  }
}

Either<T, K> failure<T, K>(T failure) {
  return Either._(failure, null);
}

Either<T, K> success<T, K>(K? value) {
  return Either._(null, value);
}
