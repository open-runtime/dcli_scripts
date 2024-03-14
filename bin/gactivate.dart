#! /usr/bin/env dart

// ignore: unused_import
import 'dart:io';

import 'package:args/args.dart';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart';
import 'package:pubspec_manager/pubspec_manager.dart';

/// dcli script generated by:
/// dcli create %scriptname%
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///
void main(List<String> args) {
  final parser = ArgParser()
    ..addFlag('compile',
        abbr: 'c',
        help: 'compiles a global activated package and installs it '
            'into the dcli bin');

  final ArgResults argResult;
  try {
    argResult = parser.parse(args);
  } on FormatException catch (e) {
    printerr(red(e.message));
    print(parser.usage);
    exit(1);
  }
  final compile = argResult['compile'] as bool;

  if (compile) {
    compilePackage(argResult);
  } else {
    if (args.length != 1) {
      printerr(red('You must pass a path.'));
      exit(1);
    }

    'dart pub global activate -spath ${args[0]}'.run;
  }
}

void compilePackage(ArgResults argResults) {
  if (argResults.rest.length != 1) {
    printerr(red('You must provide the name of a package to compile'));
  }

  final packageName = argResults.rest[0];

  final version = PubCache().findPrimaryVersion(packageName);
  final pathToPackage =
      PubCache().pathToPackage(packageName, version.toString());

  // we can't compile in the .pub_cache as pub get throws errors
  // so copy the package to a temp dir.
  withTempDir((tempDir) {
    copyTree(pathToPackage, tempDir);
    final pubspec = PubSpec.loadFromPath(join(tempDir, 'pubspec.yaml'));
    final execs = pubspec.executables;
    if (execs.isEmpty) {
      printerr(red('No executables listed in the pubspec.yaml'));
      throw Exception('No executables listed in the pubspec.yaml');
    }
    final binDir = join(tempDir, 'bin');
    for (final executable in execs) {
      'dcli compile ${executable.scriptPath}'.start(workingDirectory: tempDir);
      final installPath = join(Settings().pathToDCliBin, executable.name);
      if (exists(installPath)) {
        delete(installPath);
      }
      move(join(binDir, basenameWithoutExtension(executable.scriptPath)),
          installPath);
    }
  });
}
