#! /usr/bin/env dcli

/// dcli script generated by:
/// dcli create future_test.dart
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///
import 'dart:async';

void main() {
  var doMe = doFutures();
  print('doFutures returned');
  doMe.then((_) => print('do Future completed'));
}

Future<void> doFutures() async {
  Completer done = Completer<void>();
  print('doFutures: started');
  Future.delayed(Duration(seconds: 10), () {
    print('delayed 10');
    done.complete();
  });
  Future.delayed(Duration(seconds: 5), () => print('delayed 5'));
  print('about to await');
  await Future.delayed(Duration(seconds: 7), () => print('delayed 7'));
  print('await finished');

  print('doFutures: ended');

  return done.future;
}
