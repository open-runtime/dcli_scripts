#! /usr/bin/env dart
/* Copyright (C) S. Brett Sutton - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Brett Sutton <bsutton@onepub.dev>, Jan 2022
 */

import 'package:dcli_scripts/src/mysql/mysql.dart';

/// Connects you to a mysql cli pulling settings (username/password)
/// from a local settings file.
/// Use

Future<void> main(List<String> args) async {
  await mysqlRun(args);
}
