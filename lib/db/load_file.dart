import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
Future<String> loadPDF(url) async {
  print('llllllllllllllllllllllllllllllllllll');
  print(url);
  var response = await http.get(Uri.parse(url));
  int i = Random().nextInt(100);
  print(i);
  var uu = '${url.split('/').last}';
  var dir = await getApplicationDocumentsDirectory();
  File file = new File("${dir.path}/$uu");
  file.writeAsBytesSync(response.bodyBytes, flush: true);
  return file.path;
}
