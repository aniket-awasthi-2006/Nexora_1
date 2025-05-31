import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FlashcardStorage {
  Future<Directory> get _localDir async {
    return await getApplicationDocumentsDirectory();
  }

  Future<void> saveFlashcardSet(String fileName, Map<String, dynamic> data) async {
    final dir = await _localDir;
    final file = File('${dir.path}/$fileName.json');
    await file.writeAsString(jsonEncode(data));
  }

  Future<List<Map<String, dynamic>>> getAllFlashcardSummaries() async {
  final dir = await getApplicationDocumentsDirectory();
  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.json'));

  List<Map<String, dynamic>> summaries = [];

  for (final file in files) {
    try {
      final data = jsonDecode(await file.readAsString());
      summaries.add({
        'fileName': file.path.split('/').last,
        'topic': data['topic'],
        'description': data['description'],
      });
    } catch (e) {
      print('Error reading ${file.path}: $e');
    }
  }

  return summaries;
}
}