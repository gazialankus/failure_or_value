<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This is a simplified version of Either type defined in dartz package and specifically used for returning a failure or value.

```dart
Either<Failure, int> getFailure() {
  return failure(Failure());
}

Either<Failure, int> getNumber() {
  return success(10);
}

void f() async {
  final failureOrSuccess = getFailure();
  assert(failureOrSuccess.isFailure() == true);
  
  failureOrSuccess.fold(
      (failure) => null, // handle failure,
      (value) => null, // do something with value,
  );

  // Same with fold method but returns a future
  final state = await failureOrSuccess.asyncFold(
        (failure) async {
          await service.updateSomethingInServer();
          State.failure(failure);
        },
        (value) async => State.success(value),
  );
}
```
