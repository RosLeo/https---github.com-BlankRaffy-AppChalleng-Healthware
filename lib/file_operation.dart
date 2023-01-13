import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> getFilePathToken() async {
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  String appDocumentsPath = appDocumentsDirectory.path;
  String filePath = '$appDocumentsPath/token.txt';

  return filePath;
}

void saveFileToken(String token) async {
  File file = File(await getFilePathToken());
  file.writeAsString("$token");
}

Future<String> readFileToken() async {
  File file = File(await getFilePathToken()); // 1
  String fileContent = await file.readAsString(); // 2

  return '$fileContent';
}

Future<String> getFilePathEmail() async {
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  String appDocumentsPath = appDocumentsDirectory.path;
  String filePath = '$appDocumentsPath/login.txt';

  return filePath;
}

void saveFileEmail(String email) async {
  File file = File(await getFilePathEmail());
  file.writeAsString("$email");
}

Future<String> readFileEmail() async {
  File file = File(await getFilePathEmail()); // 1
  String fileContent = await file.readAsString(); // 2

  return '$fileContent';
}

Future<String> getFilePathType() async {
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  String appDocumentsPath = appDocumentsDirectory.path;
  String filePath = '$appDocumentsPath/type.txt';

  return filePath;
}

void saveFileType(String type) async {
  File file = File(await getFilePathType());
  file.writeAsString("$type");
}

Future<String> readFileType() async {
  File file = File(await getFilePathType()); // 1
  String fileContent = await file.readAsString(); // 2

  return '$fileContent';
}
