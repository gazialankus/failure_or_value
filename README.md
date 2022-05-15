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

void test() async {
  final failureOrSuccess = getFailure();
  assert(failureOrSuccess.isFailure() == true);
  
  failureOrSuccess.fold(
      (failure) => null, // handle failure,
      (value) => null, // do something with value,
  );

  // This time returns a future
  final state = await failureOrSuccess.fold(
        (failure) async {
          await service.updateSomethingInServer();
          return State.failure(failure);
        },
        (value) async => State.success(value),
  );
}

// Example for creating Failure objects in catch bloc and sending "Exception" and "Stack Trace".
Future<Either<Failure, User>> getUser(String id) async {
  try {
    final user = await _userService.fetchUser(id);
    return success(user);
  } on PlatformException catch(e, st) {
    return failure(Failure.platform(e, st));
  } on Exception catch(e, st) {
    return failure(Failure.any(e, st));
  }
}

void useGetUserFunction() async {
  final failureOrSuccess = await getUser("12345");
  failureOrSuccess.fold(
      (failure) {
        print(failure.e);
        print(failure.st);
      },
      (value) => print(value),
  );
}
```
