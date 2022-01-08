import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart';

import 'mysql.dart';
import 'mysql_settings.dart';

class ConfigCommand extends Command<void> {
  ConfigCommand() {
    argParser.addFlag('remove',
        abbr: 'r',
        help: 'Removes a database config. Does not touch the actual db');
  }
  @override
  String get description => 'configures credentials for a database.';

  @override
  String get name => 'config';

  @override
  void run() {
    final args = getArgs(argResults);

    final dbname = args[0];

    if (argResults!['remove'] as bool) {
      final pathTo = MySqlSettings.pathToSettings(dbname);
      if (exists(pathTo)) {
        delete(pathTo);
      } else {
        printerr(red('No config for $dbname exits at $pathTo'));
      }
    } else {
      config(dbname);
    }
  }

  void config(String dbname) {
    MySqlSettings.config(dbname);
  }
}
