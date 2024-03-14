#! /usr/bin/env dart
/* Copyright (C) S. Brett Sutton - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Brett Sutton <bsutton@onepub.dev>, Jan 2022
 */

import 'package:dcli/dcli.dart';

/// dcli script generated by:
/// dcli create dnsflush.dart
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///

void main() {
  if (which('resolvectl').notfound) {
    'systemd-resolve --flush-caches'.start(privileged: true);
    'systemd-resolve --statistics'.start(privileged: true);
  } else {
    // 22.04 onward.
    'resolvectl flush-caches'.start(privileged: true);
    'resolvectl statistics'.start(privileged: true);
  }
}
