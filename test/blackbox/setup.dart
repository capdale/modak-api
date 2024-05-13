import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

import 'setup_dto.dart';

void main() {
  final testConfig = loadTestConfig();
  print(testConfig.test.auth.invalidTokens);
}

TestConfig loadTestConfig() {
  final configFile = File("./test/test_config.yaml");
  var config = loadYaml(configFile.readAsStringSync());
  return TestConfig.fromJson(jsonDecode(jsonEncode(config)));
}
