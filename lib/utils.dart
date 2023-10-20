import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> saveImageAndReturnPath({
  required File file,
  String? dirPath,
}) async {
  final rootDir = await getApplicationDocumentsDirectory();
  final dir =
      (dirPath != null) ? Directory('${rootDir.path}/${dirPath}') : rootDir;
  if (!await dir.exists()) {
    await dir.create();
  }
  final savedFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
  final savedFilePath = '${dir.path}/$savedFileName';
  final savedFile = File(savedFilePath);
  await savedFile.writeAsBytes(await file.readAsBytes());
  return savedFile.path;
}
